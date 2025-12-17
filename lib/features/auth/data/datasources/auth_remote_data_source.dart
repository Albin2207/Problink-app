import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<String> sendOtp(String phoneNumber);
  Future<void> verifyOtp(String verificationId, String otp);
  Future<void> signOut();
  String? getCurrentUserId();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<String> sendOtp(String phoneNumber) async {
    final completer = Completer<String>();
    
    try {
      // Format phone number with country code
      final formattedPhone = phoneNumber.startsWith('+')
          ? phoneNumber
          : '+91$phoneNumber';

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto-verification (usually for test numbers on Android)
          // We'll handle it via codeSent callback
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) {
            completer.completeError(
              AuthException(
                e.message ?? 'Verification failed',
                code: e.code,
              ),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
        timeout: const Duration(seconds: 60),
      );

      return await completer.future;
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        e.message ?? 'Authentication failed',
        code: e.code,
      );
    } catch (e) {
      throw ServerException('Failed to send OTP: ${e.toString()}');
    }
  }

  @override
  Future<void> verifyOtp(String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      // Wait a bit for Firebase to process user data
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Verify user is authenticated
      if (userCredential.user == null) {
        throw AuthException('Authentication failed - no user returned');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        throw AuthException('Invalid OTP', code: e.code);
      } else if (e.code == 'session-expired') {
        throw AuthException('OTP expired. Please request a new one', code: e.code);
      } else {
        throw AuthException(
          e.message ?? 'OTP verification failed',
          code: e.code,
        );
      }
    } catch (e) {
      // Catch type cast errors and other Firebase internal errors
      if (e.toString().contains('Pigeon') || e.toString().contains('type cast')) {
        // If authentication succeeded but there's a type cast error,
        // check if user is actually authenticated
        if (_firebaseAuth.currentUser != null) {
          // User is authenticated, ignore the type cast error
          return;
        }
        throw AuthException('Authentication completed but user data error occurred');
      }
      throw ServerException('Failed to verify OTP: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw ServerException('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }
}


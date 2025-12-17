import 'package:flutter/foundation.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  // State
  bool _isLoading = false;
  String? _errorMessage;
  String? _verificationId;
  String? _phoneNumber;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get verificationId => _verificationId;
  String? get phoneNumber => _phoneNumber;
  bool get isAuthenticated => _authRepository.getCurrentUserId() != null;

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Send OTP
  Future<bool> sendOtp(String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    _phoneNumber = phoneNumber;
    notifyListeners();

    try {
      _verificationId = await _authRepository.sendOtp(phoneNumber);
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
      return true;
    } on AuthException catch (e) {
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unknown error occurred';
      notifyListeners();
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String otp) async {
    if (_verificationId == null) {
      _errorMessage = 'Please send OTP first';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.verifyOtp(_verificationId!, otp);
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
      return true;
    } on AuthException catch (e) {
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unknown error occurred';
      notifyListeners();
      return false;
    }
  }

  // Resend OTP
  Future<bool> resendOtp() async {
    if (_phoneNumber == null) {
      _errorMessage = 'Phone number not found';
      notifyListeners();
      return false;
    }

    return await sendOtp(_phoneNumber!);
  }

  // Sign out
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signOut();
      _verificationId = null;
      _phoneNumber = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to sign out';
      notifyListeners();
    }
  }

  // Reset state
  void reset() {
    _verificationId = null;
    _phoneNumber = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}


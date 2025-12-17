import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<String> sendOtp(String phoneNumber) async {
    try {
      return await _remoteDataSource.sendOtp(phoneNumber);
    } on AuthException catch (e) {
      throw e;
    } on ServerException catch (e) {
      throw e;
    } catch (e) {
      throw ServerException('Failed to send OTP: ${e.toString()}');
    }
  }

  @override
  Future<void> verifyOtp(String verificationId, String otp) async {
    try {
      await _remoteDataSource.verifyOtp(verificationId, otp);
    } on AuthException catch (e) {
      throw e;
    } on ServerException catch (e) {
      throw e;
    } catch (e) {
      throw ServerException('Failed to verify OTP: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
    } on ServerException catch (e) {
      throw e;
    } catch (e) {
      throw ServerException('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  String? getCurrentUserId() {
    return _remoteDataSource.getCurrentUserId();
  }
}


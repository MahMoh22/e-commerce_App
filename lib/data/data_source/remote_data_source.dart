import 'package:e_commerce_app/data/network/app_api.dart';
import 'package:e_commerce_app/data/network/requests.dart';
import 'package:e_commerce_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ResetPasswordResponse> reset(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ResetPasswordResponse> reset(
      ForgotPasswordRequest forgotPasswordRequest) async {
    return await _appServiceClient.reset(forgotPasswordRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        ""
        /*registerRequest.profilePicture*/);
  }
}

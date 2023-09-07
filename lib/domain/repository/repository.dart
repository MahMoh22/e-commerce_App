import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/data/network/requests.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, ResetPassword>> reset(
      ForgotPasswordRequest forgotPasswordRequest);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/data/network/requests.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/repository/repository.dart';
import 'package:e_commerce_app/domain/usecase/base_usecase.dart';

class LoginUsecase implements BaseUsecase<LoginUsecaseInput, Authentication> {
  final Repository _repository;
  LoginUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> excute(
      LoginUsecaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.passowrd));
  }
}

class LoginUsecaseInput {
  String email;
  String passowrd;
  LoginUsecaseInput(this.email, this.passowrd);
}

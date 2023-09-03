import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/data/network/requests.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/repository/repository.dart';
import 'package:e_commerce_app/domain/usecase/base_usecase.dart';

class ResetPasswordUsecase
    implements BaseUsecase<ResetPasswordUsecaseInputs, ResetPassword> {
  final Repository _repository;
  ResetPasswordUsecase(this._repository);

  @override
  Future<Either<Failure, ResetPassword>> excute(
      ResetPasswordUsecaseInputs input) async {
    return await _repository.reset(ForgotPasswordRequest(input.email));
  }
}

class ResetPasswordUsecaseInputs {
  String email;
  ResetPasswordUsecaseInputs(this.email);
}

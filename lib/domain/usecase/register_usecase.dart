import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/data/network/requests.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/repository/repository.dart';
import 'package:e_commerce_app/domain/usecase/base_usecase.dart';

class RegisterUsecase
    implements BaseUsecase<RegisterUsecaseInput, Authentication> {
  final Repository _repository;
  RegisterUsecase(this._repository);
  @override
  Future<Either<Failure, Authentication>> excute(
      RegisterUsecaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.userName,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
        input.profilePicture));
  }
}

class RegisterUsecaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterUsecaseInput(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.profilePicture);
}

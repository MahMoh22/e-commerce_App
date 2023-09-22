import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/repository/repository.dart';
import 'package:e_commerce_app/domain/usecase/base_usecase.dart';

class StoreDetailsUsecase implements BaseUsecase<void, StoreDetails> {
  final Repository _repository;
  StoreDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> excute(void input) async {
    return await _repository.getDetails();
  }
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/repository/repository.dart';
import 'package:e_commerce_app/domain/usecase/base_usecase.dart';

class HomeUsecase implements BaseUsecase<void, HomeObject> {
  final Repository _repository;
  HomeUsecase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> excute(void input) async {
    return await _repository.getHomeData();
  }
}

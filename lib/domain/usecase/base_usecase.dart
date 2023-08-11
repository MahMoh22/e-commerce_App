import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/network/failure.dart';

abstract class BaseUsecase<In, Out> {
  Future<Either<Failure, Out>> excute(In input);
}

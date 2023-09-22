import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/data_source/local_data_source.dart';
import 'package:e_commerce_app/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/data/mapper/mapper.dart';
import 'package:e_commerce_app/data/network/error_handler.dart';
import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/data/network/network_info.dart';
import 'package:e_commerce_app/data/network/requests.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        //it`s connected to the internet it`s safe to call API
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          //success
          return Right(response.toDomain());
        } else {
          //Business error
          return Left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handler(error).failure);
      }
    } else {
      //connection failure
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ResetPassword>> reset(
      ForgotPasswordRequest forgotPasswordRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        //it`s connected to the internet it`s safe to call API
        final response = await _remoteDataSource.reset(forgotPasswordRequest);
        if (response.status == ApiInternalStatus.success) {
          //success
          return Right(response.toDomain());
        } else {
          //Business error
          return Left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handler(error).failure);
      }
    } else {
      //connection failure
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        //it`s connected to the internet it`s safe to call API
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.success) {
          //success
          return Right(response.toDomain());
        } else {
          //Business error
          return Left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handler(error).failure);
      }
    } else {
      //connection failure
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      // get response from cache
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not exist or not valid
      // get data from API

      if (await _networkInfo.isConnected()) {
        try {
          //it`s connected to the internet it`s safe to call API
          final response = await _remoteDataSource.getHomeData();
          if (response.status == ApiInternalStatus.success) {
            //success
            // save home response to the cache
            _localDataSource.saveHomeCache(response);
            return Right(response.toDomain());
          } else {
            //Business error
            return Left(Failure(ApiInternalStatus.failure,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          print(error);
          return Left(ErrorHandler.handler(error).failure);
        }
      } else {
        //connection failure
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getDetails() async {
    try {
      // get response from cache
      final response = await _localDataSource.getDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected()) {
        // the internet is connected
        try {
          final response = await _remoteDataSource.getDetails();
          if (response.status == ApiInternalStatus.success) {
            // success
            // save home response to the cache
            _localDataSource.saveDetailsCache(response);
            return Right(response.toDomain());
          } else {
            // business error
            return Left(Failure(ApiInternalStatus.failure,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          print(error);
          return Left(ErrorHandler.handler(error).failure);
        }
      } else {
        // no internet connection
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}

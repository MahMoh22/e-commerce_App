import 'package:dio/dio.dart';
import 'package:e_commerce_app/app/app_prefs.dart';
import 'package:e_commerce_app/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/data/network/app_api.dart';
import 'package:e_commerce_app/data/network/dio_factory.dart';
import 'package:e_commerce_app/data/network/network_info.dart';
import 'package:e_commerce_app/data/repository/repository_impl.dart';
import 'package:e_commerce_app/domain/repository/repository.dart';
import 'package:e_commerce_app/domain/usecase/login_usecase.dart';
import 'package:e_commerce_app/domain/usecase/register_usecase.dart';
import 'package:e_commerce_app/domain/usecase/reset_password_usecase.dart';
import 'package:e_commerce_app/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:e_commerce_app/presentation/login/view_model/login_view_model.dart';
import 'package:e_commerce_app/presentation/register/view_model/regiter_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  // app module, its module where we put all generic dependencies

  // shared prefs inestance
  final sheredPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sheredPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();
  // app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

Future<void> initResetPasswordModule() async {
  if (!GetIt.I.isRegistered<ResetPasswordUsecase>()) {
    instance.registerFactory<ResetPasswordUsecase>(
        () => ResetPasswordUsecase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

Future<void> initRegisterModule() async {
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance
        .registerFactory<RegisterUsecase>(() => RegisterUsecase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

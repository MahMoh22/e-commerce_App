import 'dart:async';
import 'dart:ffi';

import 'package:e_commerce_app/domain/usecase/login_usecase.dart';
import 'package:e_commerce_app/presentation/base/base_view_model.dart';
import 'package:e_commerce_app/presentation/common/freezed_data_classes.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputDataValidStreamController =
      StreamController<void>.broadcast();
  var loginObject = LoginObject("", "");
  //final LoginUsecase _loginUsecase;
  LoginViewModel(/*this._loginUsecase*/);
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputDataValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  login() async {
    /*(await _loginUsecase.excute(
            LoginUsecaseInput(loginObject.username, loginObject.password)))
        .fold((failure) => {print(failure.message)},
            (data) => {print(data.customer?.name)});*/
  }

  @override
  setPassword(String password) {
    inputpassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject = loginObject.copyWith(username: username);
    inputAreAllInputsValid.add(null);
  }

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputpassword => _passwordStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputDataValidStreamController.sink;

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUserNameValid(username));

  @override
  Stream<bool> get outputIspasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputDataValidStreamController.stream
          .map((_) => _areAllInputsVlid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String username) {
    return username.isNotEmpty;
  }

  bool _areAllInputsVlid() {
    return _isUserNameValid(loginObject.username) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String username);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputpassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIspasswordValid;
  Stream<bool> get outputAreAllInputsValid;
}
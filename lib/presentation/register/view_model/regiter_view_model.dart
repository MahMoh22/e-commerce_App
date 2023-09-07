import 'dart:async';
import 'dart:io';

import 'package:e_commerce_app/app/functions.dart';
import 'package:e_commerce_app/domain/usecase/register_usecase.dart';
import 'package:e_commerce_app/presentation/base/base_view_model.dart';
import 'package:e_commerce_app/presentation/common/freezed_data_classes.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';

class RegisterViewModel
    implements
        BaseViewModel,
        RegisterViewModelInputs,
        RegisterViewModelOutputs {
  final StreamController _inputStreamControler =
      StreamController<FlowState>.broadcast();
  final StreamController _userNameStreamControler =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamControler =
      StreamController<String>.broadcast();
  final StreamController _emailStreamControler =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamControler =
      StreamController<String>.broadcast();
  final StreamController _profilePictureStreamControler =
      StreamController<File>.broadcast();
  final StreamController _areAllInputDataValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserRegisteredSuccessfullyStreamController =
      StreamController<bool>();
  var registerObject = RegisterObject("", "", "", "", "", "");
  final RegisterUsecase _registerUsecase;
  RegisterViewModel(this._registerUsecase);

  @override
  void dispose() {
    _inputStreamControler.close();
    _userNameStreamControler.close();
    _mobileNumberStreamControler.close();
    _emailStreamControler.close();
    _passwordStreamControler.close();
    _profilePictureStreamControler.close();
    _areAllInputDataValidStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputDataValidStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamControler.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamControler.sink;

  @override
  Sink get inputPassword => _passwordStreamControler.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamControler.sink;

  @override
  Sink get inputState => _inputStreamControler.sink;

  @override
  Sink get inputUserName => _userNameStreamControler.sink;

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputDataValidStreamController.stream
          .map((_) => _areAllInputDataValid());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamControler.stream.map((email) => _isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((emailValid) => emailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamControler.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.invalidMobile);

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamControler.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorUserPassword => outputIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.invalidPassword);

  @override
  Stream<File> get outputProfilePicture => _profilePictureStreamControler.stream
      .map((profilePicture) => profilePicture);

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamControler.stream
      .map((username) => _isUserNameValid(username));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserName) => isUserName ? null : AppStrings.userNameErrorText);

  @override
  Stream<FlowState> get outputState =>
      _inputStreamControler.stream.map((flowState) => flowState);

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUsecase.excute(RegisterUsecaseInput(
            registerObject.userName,
            registerObject.countryMobileCode,
            registerObject.mobileNumber,
            registerObject.email,
            registerObject.password,
            registerObject.profilePicture)))
        .fold(
            (failure) => {
                  // left (failure)
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message))
                }, (data) {
      // right (success)
      // content
      inputState.add(ContentState());
      // navigate to main screen
      isUserRegisteredSuccessfullyStreamController.add(true);
    });
  }

  @override
  setCountryMobileCode(String countryMobileCode) {
    
    if (countryMobileCode.isNotEmpty) {
      registerObject =
          registerObject.copyWith(countryMobileCode: countryMobileCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (_isUserNameValid(profilePicture.path)) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  bool _isUserNameValid(String username) {
    return username.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isEmailValid(String email) {
    return isEmailValid(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputDataValid() {
    return registerObject.userName.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty &&
        registerObject.email.isNotEmpty;
  }

  validate() {
    inputAreAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  setUserName(String userName);
  setCountryMobileCode(String countryMobileCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
  register();
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAreAllInputsValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorUserPassword;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllInputsValid;
}

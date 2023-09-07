import 'dart:async';

import 'package:e_commerce_app/app/constants.dart';
import 'package:e_commerce_app/app/functions.dart';
import 'package:e_commerce_app/domain/usecase/reset_password_usecase.dart';
import 'package:e_commerce_app/presentation/base/base_view_model.dart';
import 'package:e_commerce_app/presentation/common/freezed_data_classes.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';

import 'package:flutter/material.dart';

class ForgotPasswordViewModel
    implements
        BaseViewModel,
        ForgotPasswordViewModelInputs,
        ForgotPasswordViewModelOutputs {
  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputDataVaidStreamController =
      StreamController<void>.broadcast();
  var resetPasswordObject = ResetPasswordObject(Constants.empty);
  final ResetPasswordUsecase _resetPasswordUsecase;
  ForgotPasswordViewModel(this._resetPasswordUsecase);

  @override
  void dispose() {
    _inputStreamController.close();
    _emailStreamController.close();
    _areAllInputDataVaidStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputDataVaidStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputDataVaidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  reset(BuildContext context) async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _resetPasswordUsecase
            .excute(ResetPasswordUsecaseInputs(resetPasswordObject.email)))
        .fold(
            (failure) => {
                  // left (failure)
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message))
                }, (data) {
      // right (success)
      // navigate to login screen
      inputState.add(SuccessState(data.support));
      Navigator.of(context, rootNavigator: true).pop(true);
      Navigator.of(context, rootNavigator: true).pop(true);
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    resetPasswordObject = resetPasswordObject.copyWith(email: email);
    inputAreAllInputsValid.add(null);
  }

  bool _isEmailValid(String email) {
    return isEmailValid(email);
  }

  bool _areAllInputsValid() {
    return _isEmailValid(resetPasswordObject.email);
  }
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);
  reset(BuildContext context);
  Sink get inputEmail;
  Sink get inputAreAllInputsValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputAreAllInputsValid;
}

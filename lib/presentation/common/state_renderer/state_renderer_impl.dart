import 'package:e_commerce_app/app/constants.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// loading state (popup, fullscreen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (popup, fullscreen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// success state
class SuccessState extends FlowState {
  String message;

  SuccessState(
    this.message,
  );

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupSuccessState;
}

// empty state
class EmptytState extends FlowState {
  String message;

  EmptytState(this.message);

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

extension FlowStateExtention on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // show popup loading
            showpopup(
                context: context,
                stateRendererType: getStateRendererType(),
                message: getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            // full screen loading state
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // show popup error

            showpopup(
                context: context,
                stateRendererType: getStateRendererType(),
                message: getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            // full screen error state

            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptytState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case SuccessState:
        {
          // show popup success
          showpopup(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              title: AppStrings.success);
          // show content ui of the screen
          return contentScreenWidget;
        }
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  _isCurrentDialogShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showpopup(
      {required BuildContext context,
      required StateRendererType stateRendererType,
      required String message,
      String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
            message: message,
            title: title,
            stateRendererType: stateRendererType,
            retryActionFunction: () {})));
  }
}

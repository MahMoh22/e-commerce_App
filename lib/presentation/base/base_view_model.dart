import 'dart:async';

import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {
// shared variables and functions that will be used through any view model

  final StreamController _inputStreamControler =
      StreamController<FlowState>.broadcast();
  @override
  void dispose() {
    _inputStreamControler.close();
  }

  @override
  Sink get inputState => _inputStreamControler.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamControler.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start(); //start view model job
  void dispose(); //will be called when the view model dies
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

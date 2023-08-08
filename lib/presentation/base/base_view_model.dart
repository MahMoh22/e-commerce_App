abstract class BaseViewModel implements BaseViewModelInputs , BaseViewModelOutputs {
// shared variables and functions that will be used through any view model
}

abstract class BaseViewModelInputs {
  void start(); //start view model job
  void dispose(); //will be called when the view model dies
}

abstract class BaseViewModelOutputs {}

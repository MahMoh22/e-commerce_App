import 'dart:async';

import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/presentation/base/base_view_model.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';

class OnboardingViewModel
    implements
        BaseViewModel,
        OnboardingViewModelInputs,
        OnboardingViewModelOutputs {
  final StreamController<SilderViewObject> _streamController = StreamController();
  late final List<SliderObject> _list;
  int _currentIndex = 0;
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    if (_currentIndex == _list.length - 1) {
      return 0;
    } else {
      return ++_currentIndex;
    }
  }

  @override
  int goPrevious() {
    if (_currentIndex == 0) {
      return _list.length - 1;
    } else {
      return --_currentIndex;
    }
  }

  @override
  void inChangePage(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;
//onboarding viewModel outputs
  @override
  // TODO: implement outputSliderViewObject
  Stream<SilderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //onboarding private functions
  List<SliderObject> _getSliderData() {
    return [
      SliderObject(AppStrings.onboardingTitle1, AppStrings.onboardingSubTitle1,
          ImageAssets.onboardingLogo1),
      SliderObject(AppStrings.onboardingTitle2, AppStrings.onboardingSubTitle2,
          ImageAssets.onboardingLogo2),
      SliderObject(AppStrings.onboardingTitle3, AppStrings.onboardingSubTitle3,
          ImageAssets.onboardingLogo3),
      SliderObject(AppStrings.onboardingTitle4, AppStrings.onboardingSubTitle4,
          ImageAssets.onboardingLogo4),
    ];
  }

  void _postDataToView() {
    inputSliderViewObject.add(
        SilderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnboardingViewModelInputs {
  int goNext(); //when user clicks on right arrow
  int goPrevious(); //when user clicks on left arrow
  void inChangePage(int index);
  //stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnboardingViewModelOutputs {
// stream controller output
  Stream<SilderViewObject> get outputSliderViewObject;
}
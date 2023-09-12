import 'dart:async';
import 'dart:ffi';

import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/usecase/home_usecase.dart';
import 'package:e_commerce_app/presentation/base/base_view_model.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel
    implements BaseViewModel, HomeViewModelInputs, HomeViewModelOutputs {
  final StreamController _dataStreamController =
      BehaviorSubject<HomeViewObject>();
  final StreamController _inputsStreamController = BehaviorSubject<FlowState>();
  final HomeUsecase _homeUsecase;
  HomeViewModel(this._homeUsecase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _dataStreamController.close();
    _inputsStreamController.close();
  }

  @override
  Sink get inputState => _inputsStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputsStreamController.stream.map((flowState) => flowState);

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUsecase.excute(Void)).fold(
        (failure) => {
              // left (failure)
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (homeObject) {
      // right (success)
      // content
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.banners,
          homeObject.data.services, homeObject.data.stores));
          
    });
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<BannerAd> banners;
  List<Service> services;
  List<Store> stores;
  HomeViewObject(this.banners, this.services, this.stores);
}

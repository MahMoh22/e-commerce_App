import 'dart:async';
import 'dart:ffi';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/domain/usecase/store_details_usecase.dart';
import 'package:e_commerce_app/presentation/base/base_view_model.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel
    implements
        BaseViewModel,
        StoreDetailsViewModelInputs,
        StoreDetailsViewModelOutputs {
  final StreamController _inputsStreamController = BehaviorSubject<FlowState>();
  final StreamController _storeDetailsStreamController =
      BehaviorSubject<StoreDetails>();
  final StoreDetailsUsecase _storeDetailsUsecase;
  StoreDetailsViewModel(this._storeDetailsUsecase);

  @override
  void dispose() {
    _inputsStreamController.close();
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputState => _inputsStreamController.sink;

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputsStreamController.stream.map((flowState) => flowState);

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((details) => details);

  @override
  void start() {
    _getDetails();
  }

  _getDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeDetailsUsecase.excute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (storeDetails) {
      inputState.add(ContentState());
      inputStoreDetails.add(StoreDetails(
          storeDetails.image,
          storeDetails.id,
          storeDetails.title,
          storeDetails.details,
          storeDetails.services,
          storeDetails.about));
    });
  }
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}

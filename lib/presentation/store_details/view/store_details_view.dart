import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:e_commerce_app/presentation/store_details/view_model/store_details_view_model.dart';
import 'package:flutter/material.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _storeDetailsViewModel =
      instance<StoreDetailsViewModel>();

  _bind() {
    _storeDetailsViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Store Details",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
              stream: _storeDetailsViewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data
                        ?.getScreenWidget(context, _contentScreenWidget(), () {
                      _storeDetailsViewModel.start();
                    }) ??
                    _contentScreenWidget();
              }),
        ),
      ),
    );
  }

  Widget _contentScreenWidget() {
    return StreamBuilder(
        stream: _storeDetailsViewModel.outputStoreDetails,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getImageWidget(snapshot.data?.image),
              _getTitle(snapshot.data?.title),
              _getSectionName("Details"),
              _getSectionDetails(snapshot.data?.details),
              _getSectionName("Services"),
              _getSectionDetails(snapshot.data?.services),
              _getSectionName("About"),
              _getSectionDetails(snapshot.data?.about),
            ],
          );
        });
  }

  Widget _getImageWidget(String? image) {
    if (image != null) {
      return SizedBox(
        width: double.infinity,
        height: AppSizes.s200,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getTitle(String? title) {
    if (title != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSectionName(String name) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          right: AppPadding.p12,
          left: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        name,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _getSectionDetails(String? details) {
    if (details != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Text(
          details,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _storeDetailsViewModel.dispose();
    super.dispose();
  }
}

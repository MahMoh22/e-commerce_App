import 'package:e_commerce_app/app/app_prefs.dart';
import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/domain/model/models.dart';
import 'package:e_commerce_app/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/constants_manager.dart';
import 'package:e_commerce_app/presentation/resources/routes_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageControler = PageController();
  final OnboardingViewModel _viewModel = OnboardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _bind() {
    _appPreferences.setOnboardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SilderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SilderViewObject? silderViewObject) {
    if (silderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: AppSizes.s0,
          backgroundColor: ColorManager.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
            itemCount: silderViewObject.numberOfSlides,
            controller: _pageControler,
            onPageChanged: (index) {
              _viewModel.inChangePage(index);
            },
            itemBuilder: (context, index) {
              return OnboardingPage(silderViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              _getBottomSheetWidget(silderViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SilderViewObject silderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageControler.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds:
                            AppConstants.boardingPageAnimationDuration),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSizes.s20,
                width: AppSizes.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < silderViewObject.numberOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCercle(i, silderViewObject.currentIndex),
                )
            ],
          ),

          //right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageControler.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                        milliseconds:
                            AppConstants.boardingPageAnimationDuration),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSizes.s20,
                width: AppSizes.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getProperCercle(int index, currentIndex) {
    if (currentIndex == index) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(this._sliderObject, {super.key});
  final SliderObject _sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSizes.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}

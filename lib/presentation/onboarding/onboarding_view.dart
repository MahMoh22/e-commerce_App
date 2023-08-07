import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/constants_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
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
  // ignore: unused_field
  int _currentIndex = 0;
  late final List<SliderObject> _list = _getSliderData();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.wight,
      appBar: AppBar(
        elevation: AppSizes.s0,
        backgroundColor: ColorManager.wight,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.wight,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
          itemCount: _list.length,
          controller: _pageControler,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return OnboardingPage(_list[index]);
          }),
      bottomSheet: Container(
        color: ColorManager.wight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.skip,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomSheetWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
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
                _pageControler.animateToPage(_getPreviousPage(),
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
              for (int i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCercle(i),
                )
            ],
          ),

          //right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageControler.animateToPage(_getNextPage(),
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

  int _getPreviousPage() {
    if (_currentIndex == 0) {
      return _list.length - 1;
    } else {
      return --_currentIndex;
    }
  }

  int _getNextPage() {
    if (_currentIndex == _list.length - 1) {
      return 0;
    } else {
      return ++_currentIndex;
    }
  }

  Widget _getProperCercle(int index) {
    if (_currentIndex == index) {
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

class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

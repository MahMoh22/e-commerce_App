//onboarding models
class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class SilderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;
  SilderViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}

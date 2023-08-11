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

//login models
class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}

class Contact {
  String phone;
  String email;
  String link;
  Contact(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contact? contact;
  Authentication(this.customer, this.contact);
}

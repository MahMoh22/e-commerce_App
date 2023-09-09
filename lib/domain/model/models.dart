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

//auth models
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

// reset password model
class ResetPassword {
  String support;
  ResetPassword(this.support);
}

// home page model
class Service {
  String id;
  String title;
  String image;
  Service(this.id, this.title, this.image);
}

class BannerAd {
  String id;
  String title;
  String link;
  String image;
  BannerAd(this.id, this.title, this.link, this.image);
}

class Store {
  String id;
  String title;
  String image;
  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;
  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData data;
  HomeObject(this.data);
}

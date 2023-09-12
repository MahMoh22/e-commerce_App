import 'package:e_commerce_app/app/constants.dart';
import 'package:e_commerce_app/app/extentions.dart';
import 'package:e_commerce_app/data/response/responses.dart';
import 'package:e_commerce_app/domain/model/models.dart';

extension CustomerResponseMapper on CustomerResponse {
  Customer toDomain() {
    return Customer(id.orEmpty(), name.orEmpty(), numOfNotifications.orZerro());
  }
}

extension ContactResponseMapper on ContactResponse {
  Contact toDomain() {
    return Contact(phone.orEmpty(), email.orEmpty(), link.orEmpty());
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(customer?.toDomain(), contact?.toDomain());
  }
}

extension ResetPsswordResponseMapper on ResetPasswordResponse {
  ResetPassword toDomain() {
    return ResetPassword(support.orEmpty());
  }
}

extension ServiceResponseMapper on ServicesResponse? {
  Service toDomain() {
    return Service(
        this?.id.orZerro() ?? Constants.zerro,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension BannerResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
        this?.id.orZerro() ?? Constants.zerro,
        this?.title.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension StoresResponseMapper on StoresResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZerro() ?? Constants.zerro,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((sevicesResponse) => sevicesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();
    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannersResponse) => bannersResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();
    List<Store> stores = (this
                ?.data
                ?.stores
                ?.map((storesResponse) => storesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Store>()
        .toList();
    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

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

import 'package:flutter/foundation.dart';

enum AccountType {
  facebook,
  google,
  linkedin,
  microsoft,
  paypal,
  twitter,
  yahoo
}

extension AccountTypeX on AccountType {
  String get name => describeEnum(this)?.toUpperCase();
  static AccountType fromName(String name) {
    if (name == null) return null;
    return AccountType.values
        .firstWhere((element) => element.name == name, orElse: () => null);
  }
}

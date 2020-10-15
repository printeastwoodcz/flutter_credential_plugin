import 'package:flutter/foundation.dart';

import '../../flutter_credential_picker.dart';

class Config {
  final List<AccountType> accountType;
  final PickerType pickerType;
  const Config(
      {this.accountType = const [AccountType.google],
      this.pickerType = PickerType.phoneNumber});
  Map<String, dynamic> toMap() => <String, dynamic>{
        "accountType": accountType.map((e) => describeEnum(e)).toList(),
        "pickerType": describeEnum(pickerType),
      };
}

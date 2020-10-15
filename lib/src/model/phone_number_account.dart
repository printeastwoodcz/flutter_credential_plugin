// class PhoneNumberAccount extends Credential {
//   String get phoneNumber => id;
//   String get avatarUrl => profilePictureUri;
//   factory PhoneNumberAccount.map(LinkedHashMap<String, dynamic> value) =>
//       Credential.map(value: value) as PhoneNumberAccount;
// }
import 'package:flutter/foundation.dart';

import 'credential.dart';

class PhoneNumberAccount extends Credential {
  final String number;
  final CredentialBase credential;
  PhoneNumberAccount({@required this.number, @required this.credential});
  factory PhoneNumberAccount.map(CredentialBase c) {
    assert(c != null, "Missing credential");
    return PhoneNumberAccount(number: c.id, credential: c);
  }
}

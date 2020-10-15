import 'package:flutter/foundation.dart';
import 'package:flutter_credential_picker/flutter_credential_picker.dart';

import 'credential.dart';

class GoogleAccount extends Credential {
  final String email;
  final String avatar;
  final String fullName;
  final AccountType accountType;
  final CredentialBase credential;
  GoogleAccount(
      {@required this.email,
      @required this.fullName,
      @required this.avatar,
      @required this.accountType,
      @required this.credential});
  factory GoogleAccount.map(CredentialBase c) {
    assert(c != null, "Missing credential");
    return GoogleAccount(
        email: c.id,
        fullName: c.name,
        avatar: c.profilePictureUri,
        accountType: c.accountType,
        credential: c);
  }
}

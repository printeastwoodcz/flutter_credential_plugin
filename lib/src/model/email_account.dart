import 'package:flutter/cupertino.dart';

import 'credential.dart';

class EmailAccount extends Credential {
  final String email;
  final String avatar;
  final String fullName;
  final CredentialBase credential;
  EmailAccount(
      {@required this.email,
      @required this.fullName,
      @required this.avatar,
      @required this.credential});
  factory EmailAccount.map(CredentialBase c) {
    assert(c != null, "Missing credential");
    return EmailAccount(
        email: c.id,
        fullName: c.name,
        avatar: c.profilePictureUri,
        credential: c);
  }
}

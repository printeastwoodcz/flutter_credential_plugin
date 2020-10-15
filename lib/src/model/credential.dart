import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_credential_picker/flutter_credential_picker.dart';

abstract class Credential {}

class CredentialBase extends Credential {
  String id;
  String name;
  String profilePictureUri;
  List<IdToken> tokens;
  String password;
  AccountType accountType;
  String givenName;
  String familyName;
  CredentialBase({
    this.id,
    this.name,
    this.profilePictureUri,
    this.tokens,
    this.password,
    this.accountType,
    this.givenName,
    this.familyName,
  });
  factory CredentialBase.map(LinkedHashMap<String, dynamic> value) {
    assert(value != null, "Missing value for conversion");
    print('CredentialBase $value');
    var tokens = value["tokens"] as List<dynamic>;
    var t = tokens?.map((e) => Map<String, dynamic>.from(e))?.toList();
    return CredentialBase(
        id: value['id'] as String,
        name: value['name'] as String,
        profilePictureUri: value['profilePictureUri'] as String,
        tokens: t
                ?.map((e) => IdToken(
                    idToken: e["idToken"], accountType: e["accountType"]))
                ?.toList() ??
            [],
        password: value['password'] as String,
        accountType: AccountTypeX.fromName(value['accountType']),
        givenName: value['givenName'] as String,
        familyName: value['familyName'] as String);
  }
}

class IdToken {
  String idToken;
  String accountType;
  IdToken({@required this.idToken, this.accountType});
}

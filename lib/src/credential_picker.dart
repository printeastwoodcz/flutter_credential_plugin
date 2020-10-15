import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_credential_picker/src/exception/exception.dart';
import 'package:flutter_credential_picker/src/model/email_account.dart';
import 'package:flutter_credential_picker/src/model/phone_number_account.dart';

import 'enum/account_type.dart';
import 'model/credential.dart';
import 'model/google_account.dart';

class CredentialPicker {
  static const MethodChannel _channel = const MethodChannel(
      'cz.printeastwood.flutter_credential_picker/flutter_credential_picker');

  static Future<PhoneNumberAccount> pickPhoneNumber() async {
    if (Platform.isAndroid) {
      final result = await _channel.invokeMethod<dynamic>('pickPhoneNumber');
      if (result != null) {
        var response = Map<String, dynamic>.from(result);
        return PhoneNumberAccount.map(CredentialBase.map(response));
      }
      throw NotFoundException();
    } else {
      throw NotSupportedPlatform();
    }
  }

  static Future<EmailAccount> pickEmail() async {
    if (Platform.isAndroid) {
      final result = await _channel.invokeMethod<dynamic>('pickEmail');
      if (result != null) {
        var response = Map<String, dynamic>.from(result);
        return EmailAccount.map(CredentialBase.map(response));
      }
      throw NotFoundException();
    } else {
      throw NotSupportedPlatform();
    }
  }

  static Future<GoogleAccount> pickGoogleAccount(
      {List<AccountType> accountTypes = const [AccountType.google]}) async {
    var arguments = <String, List<String>>{
      "account_types": accountTypes.map((e) => e.name).toList()
    };
    if (Platform.isAndroid) {
      final result =
          await _channel.invokeMethod<dynamic>('pickGoogleAccount', arguments);
      if (result != null) {
        var response = Map<String, dynamic>.from(result);
        return GoogleAccount.map(CredentialBase.map(response));
      }
      throw NotFoundException();
    } else {
      throw NotSupportedPlatform();
    }
  }
}

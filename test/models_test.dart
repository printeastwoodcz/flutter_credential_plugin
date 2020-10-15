import 'dart:collection';

import 'package:flutter_credential_picker/flutter_credential_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final String phoneNumber = "42077788899";
  final String emailAddress = "a@b.com";
  final String fullName = "Full Name";

  final linkedHashData = LinkedHashMap.from({
    "id": phoneNumber,
    "name": fullName,
    "accountType": "GOOGLE",
    "givenName": "Full",
    "familyName": "Name"
  });

  /// Phone Number testing
  final PhoneNumberAccount phoneNumberAccount =
      PhoneNumberAccount.map(CredentialBase(
    id: phoneNumber,
  ));
  final PhoneNumberAccount wrongPhoneNumberAccount =
      PhoneNumberAccount.map(CredentialBase());

  /// Email model testing
  final EmailAccount emailAccount =
      EmailAccount.map(CredentialBase(id: emailAddress, name: fullName));
  final EmailAccount wrongEmailAccount = EmailAccount.map(CredentialBase());

  /// Google Account model testing
  final GoogleAccount account = GoogleAccount.map(CredentialBase(
      id: emailAddress, name: fullName, accountType: AccountType.google));
  final GoogleAccount wrongAccount = GoogleAccount.map(CredentialBase());

  setUp(() {});
  group('Enums', () {
    test('AccountType values', () {
      expect(AccountType.google.name, "google".toUpperCase());
      expect(AccountType.facebook.name, "facebook".toUpperCase());
      expect(AccountType.linkedin.name, "linkedin".toUpperCase());
      expect(AccountType.microsoft.name, "microsoft".toUpperCase());
      expect(AccountType.paypal.name, "paypal".toUpperCase());
      expect(AccountType.twitter.name, "twitter".toUpperCase());
    });
  });
  group('Phone number tests', () {
    test('phone number is not Empty', () {
      expect(phoneNumberAccount, isNotNull);
      expect(phoneNumberAccount.number.isNotEmpty, true);
      expect(phoneNumberAccount.number, phoneNumber);
    });
    test('phone number is wrong', () {
      expect(wrongPhoneNumberAccount, isNotNull);
      expect(wrongPhoneNumberAccount.number, null);
    });
  });
  group('EmailAccount tests', () {
    test('Email is not Empty', () {
      expect(emailAccount, isNotNull);
      expect(emailAccount.email.isNotEmpty, true);
      expect(emailAccount.email, emailAddress);

      expect(emailAccount.fullName.isNotEmpty, true);
      expect(emailAccount.fullName, fullName);
    });
    test('Email account is wrong', () {
      expect(wrongEmailAccount, isNotNull);
      expect(wrongEmailAccount.email, null);
      expect(wrongEmailAccount.fullName, null);
    });
  });
  group('Google account tests', () {
    test('Account is not Empty', () {
      expect(account, isNotNull);
      expect(account.email.isNotEmpty, true);
      expect(account.email, emailAddress);

      expect(account.fullName.isNotEmpty, true);
      expect(account.fullName, fullName);

      expect(account.accountType, AccountType.google);
    });
    test('Account is wrong', () {
      expect(wrongAccount, isNotNull);
      expect(wrongAccount.email, null);
      expect(wrongAccount.fullName, null);
      expect(wrongAccount.accountType, null);
    });
  });

  group('Conversion', () {
    test('Conversion from map', () {
      expect(CredentialBase.map(Map<String, dynamic>.from(linkedHashData)),
          isInstanceOf<CredentialBase>());
      expect(() => CredentialBase.map(null), throwsAssertionError);
    });
    test('Assertion Error test', () {
      expect(() => GoogleAccount.map(null), throwsAssertionError);
      expect(() => EmailAccount.map(null), throwsAssertionError);
      expect(() => PhoneNumberAccount.map(null), throwsAssertionError);
    });
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_credential_picker/flutter_credential_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel(
      'cz.printeastwood.flutter_credential_picker/flutter_credential_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
  group('test pickers', () {
    test('pickPhoneNumber', () async {
      expect(() async => await CredentialPicker.pickPhoneNumber(),
          throwsA(isInstanceOf<NotSupportedPlatform>()));
    });

    test('pickEmail', () async {
      expect(() async => await CredentialPicker.pickEmail(),
          throwsA(isInstanceOf<NotSupportedPlatform>()));
    });

    test('pickEmail', () async {
      expect(() async => await CredentialPicker.pickGoogleAccount(),
          throwsA(isInstanceOf<NotSupportedPlatform>()));
    });
  });
}

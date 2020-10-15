import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter picker', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final phoneNumberButton = find.byValueKey('__phoneNumberButton__');
    final emailButton = find.byValueKey('__emailButton__');
    final accountButton = find.byValueKey('__accountButton__');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      if (driver != null) {
        await driver.close();
        driver = null;
      }
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 0', () async {
      await driver.tap(phoneNumberButton);
      expect(await driver.checkHealth(timeout: Duration(seconds: 2)), true);
    });
  });
}

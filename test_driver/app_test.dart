// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Todo App -- ', () {
    final addField = find.byValueKey('addField');
    final addButton = find.byValueKey('addButton');

    FlutterDriver? driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('add a todo', () async {
      await driver?.tap(addField);
      await driver?.enterText("MTP is the best");
      await driver?.tap(addButton);

      await driver?.waitFor(
        find.text("MTP is the best"),
        timeout: const Duration(seconds: 3),
      );
      await driver?.tap(addField);
      await driver?.enterText(
        "sky foreversky foreversky foreversky foreversky foreversky forever",
        // "sky forever",
      );
      await driver?.tap(addButton);

      await driver?.waitFor(
        find.text(
          "sky foreversky foreversky foreversky foreversky foreversky forever",
          // "sky forever",
        ),
        timeout: const Duration(seconds: 3),
      );
    });
  });
}

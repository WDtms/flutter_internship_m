
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {

  group('Экран веток задач', () {

    final enterText = "test1";
    final createBranchButton = find.byValueKey('create branch');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try{
        await driver.waitFor(finder, timeout: timeout);
        return true;
      } catch (_) {
        return false;
      }
    }

    test('Создание и настройка ветки', () async {
      await driver.scrollUntilVisible(
        find.byValueKey('Branch list'),
        createBranchButton,
        dyScroll: -300.0,
      );
      await driver.tap(createBranchButton);
      await driver.tap(find.byValueKey('create branch TextField'));
      await driver.enterText(enterText);
      await driver.tap(find.byValueKey('Index: 3'));
      await driver.tap(find.text('СОЗДАТЬ'));

      //Проверка на то, появилась ли ветка
      driver.waitFor(find.text(enterText));
    });

    test('Удаление ветки задач', () async {
      await driver.scroll(find.text(enterText), 0, 0, Duration(milliseconds: 600));
      await driver.tap(find.text('УДАЛИТЬ'));

      //Проверка на то, удалилась ли ветка
      expect(await isPresent(find.text(enterText), driver), false);
    });


  });

}

import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {

  group('Экран списка задач', () {

    final createTaskTextField = find.byValueKey('Создание задачи');
    final createBranchButton = find.byValueKey('create branch');
    final taskName = 'test task';
    final branchName = 'Task tests';

    Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try{
        await driver.waitFor(finder, timeout: timeout);
        return true;
      } catch (_) {
        return false;
      }
    }

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
      await driver.scrollUntilVisible(
        find.byValueKey('Список веток'),
        createBranchButton,
        dyScroll: -300.0,
      );
      await driver.tap(createBranchButton);
      await driver.tap(find.byValueKey('create branch TextField'));
      await driver.enterText(branchName);
      await driver.tap(find.text('СОЗДАТЬ'));
      await driver.tap(find.text(branchName));
    });

    test('Создание и настройка задачи', () async {
      await driver.tap(find.byType('FloatingActionButton'));
      await driver.tap(createTaskTextField);
      await driver.enterText(taskName);
      await driver.tap(find.text('Напомнить'));
      await driver.tap(find.text('OK'));
      await driver.tap(find.text('OK'));
      await driver.tap(find.text('Дата выполнения'));
      await driver.tap(find.text('OK'));
      await driver.tap(find.text('СОЗДАТЬ'));

      //Проверка на то, создалась ли задача с заданными параметрами
      driver.waitFor(find.text(taskName));
    });

    test('Удаление задачи', () async {
      await driver.scroll(find.text(taskName), -300, 0, Duration(milliseconds: 400));

      //Проверка на то, удалилась ли задача
      expect(await isPresent(find.text(taskName), driver), false);
    });

    tearDownAll(() async {
      await driver.tap(find.pageBack());
      await driver.scroll(find.text(branchName), 0, 0, Duration(milliseconds: 600));
      await Future.delayed(const Duration(seconds: 1));
      await driver.tap(find.text('УДАЛИТЬ'));
      if (driver != null) {
        driver.close();
      }
    });

  });

}

import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {

  final createBranchButton = find.byValueKey('create branch');
  final taskName = 'test det';
  final branchName = 'Det test';

  FlutterDriver driver;

  Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver,
      {Duration timeout = const Duration(seconds: 1)}) async {
    try{
      await driver.waitFor(finder, timeout: timeout);
      return true;
    } catch (_) {
      return false;
    }
  }

  setUpAll(() async {
    driver = await FlutterDriver.connect();
    await driver.waitUntilFirstFrameRasterized();
    await driver.scrollUntilVisible(
      find.byValueKey('Branch list'),
      createBranchButton,
      dyScroll: -300.0,
    );
    await driver.tap(createBranchButton);
    await driver.tap(find.byValueKey('create branch TextField'));
    await driver.enterText(branchName);
    await driver.tap(find.text('СОЗДАТЬ'));
    await driver.tap(find.text(branchName));
    await driver.tap(find.byType('FloatingActionButton'));
    await driver.tap(find.byValueKey('Task creation'));
    await driver.enterText(taskName);
    await driver.tap(find.text('СОЗДАТЬ'));
    await driver.tap(find.text(taskName));
  });

  test('Изменение состояния чекбокса изнутри', () async {
    //Проверка на то, отображается ли иконка состояния "Не выполнена"
    driver.waitFor(find.byValueKey('Task uncompleted'));

    await driver.tap(find.byType('FloatingActionButton'));

    //Проверка на то, отображается ли иконка состояния "Выполнена"
    driver.waitFor(find.byValueKey('Task completed'));
  });
  
  test('Установка дэдлайна и создание уведомления', () async {
    await driver.tap(find.text('Напомнить'));
    await driver.tap(find.text('OK'));
    await driver.tap(find.text('OK'));
    await driver.tap(find.text('Добавить дату выполнения'));
    await driver.tap(find.text('Сегодня (18:00)'));

    //Проверка на то, изменились ли поля Напомнить и Добавить дату выполнения
    expect(await isPresent(find.text('Напомнить'), driver), false);
    expect(await isPresent(find.text('Добавить дату выполнения'), driver), false);
  });

  test('Удаление изнутри', () async {
    await driver.tap(find.byType('PopupMenuCurrentTask'));
    await driver.tap(find.text('Удалить'));
    await driver.tap(find.text('Удалить'));

    //Проверка на то, удалилась ли задача
    expect(await isPresent(find.text(taskName), driver), false);
  });

  tearDownAll(() async {
    await driver.tap(find.pageBack());
    await driver.scroll(find.text(branchName), 0, 0, Duration(milliseconds: 600));
    await driver.tap(find.text('УДАЛИТЬ'));
    if (driver != null) {
      driver.close();
    }
  });

}
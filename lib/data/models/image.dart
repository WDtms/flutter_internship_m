class Photo {

  //Поля, необходимые для создания url картинки
  final String id;
  final String secret;
  final int farm;
  final String server;
  final String title;

  //Конструктор
  Photo({this.server, this.farm, this.secret, this.title, this.id});

  /*
  Преобразование данных, полученных из фликра,
  в объект
   */
  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'] as String,
      secret: map['secret'] as String,
      farm: map['farm'] as int,
      server: map['server'] as String,
      title: map['title'] as String,
    );
  }

  //Получение url картинки
  String get photoURL => "https://farm$farm.staticflickr.com/$server/${id}_$secret.jpg";

}
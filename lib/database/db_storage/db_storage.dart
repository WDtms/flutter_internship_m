abstract class DBStorage{

  String get createTable;

  Future<void> deleteObject(String objectID);

  Future<void> insertObject(Map<String, dynamic> object);

  Future<void> updateObject(Map<String, dynamic> object);

  Future<List<Map>> getQuery();

}
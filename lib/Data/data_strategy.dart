import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseStrategy{

  static Database? _database;
  Future<Database?> get database async{
    if(_database == null){
      _database = await _initialisation();
      return _database;
    }else{
      return _database;
    }
  }


  //Initialisation
  Future<Database> _initialisation() async {
    //Create an empty database (without Tables)
    String pathDatabases = await getDatabasesPath();
    String pathMyDataBase = join(pathDatabases, "strategy.db");
    Database myDatabase = await openDatabase(pathMyDataBase, onCreate: _createDataBase, version: 1);
    return myDatabase;
  }

  Future<void> _createDataBase(Database db, int version) async {
    // Create Tables
    await db.execute('''
    CREATE TABLE "advises" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "type" INTEGER NOT NULL,
    "content" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE "matches" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "teams" TEXT NOT NULL,
    "sport" TEXT NOT NULL,
    "championship" TEXT NOT NULL,
    "scores" TEXT NOT NULL
    )
    ''');
  }
  //End Initialisation
  //-----------------Create && Read (table advises)-----------------
  Future<int> insertAdvise(String title, int type, String contents) async{
    Database? myDataBase = await database;
    Map<String, Object> values = {'title': title, 'type': type, 'contents': contents};
    int response = await myDataBase!.insert("advises", values);
    return response;
  }

  Future<List<Map>> getAdvisesData() async{
    Database? myDataBase = await database;
    List<Map> response = await myDataBase!.query("advises", groupBy: "type");
    return response;
  }

  Future<int> deleteAdvise(int id) async {
    Database? myDataBase = await database;
    int response = await myDataBase!.delete("advises", where: 'id = $id');
    return response;
  }
  //----------------------CRUD (table matches)-------------------------
  Future<int> insertMatch(String teams, String sport, String championship, String scores) async {
    Database? myDataBase = await database;
    Map<String, Object> values = {'teams': teams, 'sport': sport, 'championship': championship, 'scores': scores};
    int response = await myDataBase!.insert("matches", values);
    return response;
  }

  Future<List<Map>> getMatchesData() async{
    Database? myDataBase = await database;
    List<Map> response = await myDataBase!.query("matches", orderBy: "id");
    return response;
  }

  Future<int> updateMatch(int id, String teams, String sport, String championship, String scores) async {
    Database? myDataBase = await database;
    Map<String, Object> values = {'teams': teams, 'sport': sport, 'championship': championship, 'scores': scores};
    int response = await myDataBase!.update("matches", values, where: 'id = $id');
    return response;
  }

  Future<int> deleteMatch(int id) async {
    Database? myDataBase = await database;
    int response = await myDataBase!.delete("matches", where: 'id = $id');
    return response;
  }

  Future close() async {
    Database? myDataBase = await database;
    myDataBase!.close();
  }
}
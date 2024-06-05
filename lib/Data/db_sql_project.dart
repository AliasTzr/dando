import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projet0_strat/Models/matches_model.dart';
class DatabaseHelper {
  Database? _database;

  Future<void> initialisation() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'projet0_strat_basket.db');
    _database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE matchestable(id INTEGER PRIMARY KEY AUTOINCREMENT,sport TEXT, championship TEXT, nameteama TEXT, scoresteama TEXT, nameteamb TEXT, scoresteamb TEXT, datematch TEXT, timematch TEXT)');
        });
  }


  Future<int> insertMatch(Duel match) async {
    if (_database == null) {
      await initialisation();
    }
    return await _database!.insert('matchestable', match.toJSON(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Duel>> getMatches() async {
    if (_database == null) {
      await initialisation();
    }
    List<Map<String, dynamic>> maps = await _database!.query('matchestable', orderBy: 'id DESC');
    return List.generate(maps.length, (index) {
      return Duel(
        id: maps[index]['id'],
        sport: maps[index]['sport'],
        championship: maps[index]['championship'],
        nameTeamA: maps[index]['nameteama'],
        scoresTeamA: maps[index]['scoresteama'],
        nameTeamB: maps[index]['nameteamb'],
        scoresTeamB: maps[index]['scoresteamb'],
        dataMatch: maps[index]['datematch'],
        timeMatch: maps[index]['timematch'],
      );
    });
  }

  Future<Duel> getMatchById(int id) async {
    if (_database == null) {
      await initialisation();
    }
    List<Map<String, dynamic>> maps = await _database!.query('matchestable', where: 'id = ?', whereArgs: [id]);
    return Duel(
      id: maps[0]['id'],
      sport: maps[0]['sport'],
      championship: maps[0]['championship'],
      nameTeamA: maps[0]['nameteama'],
      scoresTeamA: maps[0]['scoresteama'],
      nameTeamB: maps[0]['nameteamb'],
      scoresTeamB: maps[0]['scoresteamb'],
      dataMatch: maps[0]['datematch'],
      timeMatch: maps[0]['timematch'],
    );
  }

  Future<int> deleteMatch(int? id) async {
    if (_database == null) {
      await initialisation();
    }
    return await _database!.delete('matchestable', where: 'id = ?', whereArgs: [id]);
    //return await _database!.insert('matches', match.toJSON(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateMatch(Duel match) async {
    if (_database == null) {
      await initialisation();
    }
    return await _database!.update('matchestable', match.toJSON(), where: 'id = ?', whereArgs: [match.id]);
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

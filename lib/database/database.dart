import 'package:crud_viacep/database/dao/person_dao.dart';
import 'package:crud_viacep/database/dao/user_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  static Database? _db;

  Future<Database?> createDB() async {
    if (_db != null) {
      return _db;
    }else{
      final String dbPath = await getDatabasesPath();
      final String pathName = join(dbPath,'app.db');
      _db = await openDatabase(pathName,onCreate: (db,version) {
        db.execute(PersonDao.tablePerson);
        db.execute(UserDao.tableUser);
      },version: 1);
      return _db;
    }
  }

}








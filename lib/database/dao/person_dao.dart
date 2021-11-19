import 'package:crud_viacep/database/database.dart';
import 'package:crud_viacep/models/person.dart';
import 'package:sqflite/sqflite.dart';

class PersonDao {
  static const String _tableName = 'person';
  static const String _tableParams = '(name,nickname) VALUES(?,?)';
  static const String _rowInsert = 'INSERT INTO $_tableName $_tableParams';

  static const String _colId = 'id';
  static const String _colName = 'name';
  static const String _colEmail = 'email';
  static const String _colLograd = 'logradouro';
  static const String _colDistrict = 'bairro';
  static const String _colCity = 'localidade';
  static const String _colUF = 'uf';
  static const String _colNickname = 'nickname';

  static const String tablePerson = '''
  CREATE TABLE $_tableName ( 
  $_colId INTEGER PRIMARY KEY NOT NULL ,
  $_colName TEXT(150) NOT NULL ,
  $_colEmail TEXT(100) ,
  $_colNickname TEXT(15) NOT NULL ,
  $_colLograd TEXT(120) ,
  $_colDistrict TEXT(30) ,
  $_colCity TEXT(50) ,
  $_colUF TEXT(2)
  )''';

  Future<int> save(Person person) async {
    Database? db = await DatabaseConnection().createDB();
    Map<String, dynamic> personMap = _toMap(person);
    if (db != null) {
      return db.rawInsert(_rowInsert, [personMap['name'],personMap['nickname']]);
    } else {
      throw Exception('Null database');
    }
  }

  Map<String, dynamic> _toMap(Person person) {
    final Map<String, dynamic> personMap = {};
    personMap[_colName] = person.name;
    personMap[_colNickname] = person.nickname;
    // personMap[_colNickname] = person.nickname;
    return personMap;
  }

  Future<List<Person>> get() async {
    Database? db = await DatabaseConnection().createDB();
    return db!.query(_tableName).then(
          (data) {
        final List<Person> personList = [];
        for (Map<String, dynamic> map in data) {
          final Person person = Person(
            name: map[_colName],
            email: map[_colEmail],
            nickname: map[_colNickname],
            logradouro: map[_colLograd],
            bairro: map[_colDistrict],
            localidade: map[_colCity],
            uf: map[_colUF],
          );
          personList.add(person);
        }
        return personList;
      },
    );
  }
}

// FOREIGN KEY ($userDao.) REFERENCES user($colNickname)

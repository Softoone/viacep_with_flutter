
class UserDao {
  static const String _tableName = 'user';

  static const String _colNickname = 'nickname';
  static const String _colPassword = 'password';


  static const String tableUser = '''
CREATE TABLE $_tableName(
$_colNickname TEXT(15) NOT NULL PRIMARY KEY,
$_colPassword TEXT(20) NOT NULL,
)
''';


}

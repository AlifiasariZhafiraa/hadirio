import 'package:mysql_client/mysql_client.dart';

class DbConnection {
  DbConnection();

  Future<MySQLConnection> pool() async {
    var conn = await MySQLConnection.createConnection(
      /// pake emulator android?
      /// terminal 'adb reverse tcp:3306 tcp:3306'
      /// ipconfig
      host: '127.0.0.1',
      port: 3306,
      // userName: 'root', // update user
      // password: '', // update password
      userName: 'anonim', // update user
      password: 'pass', // update password
      databaseName: 'hadirio',
      secure: false,
    );
    return conn;
  }
}

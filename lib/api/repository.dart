import 'dart:developer';

import 'package:hadirio/api/db_connection.dart';
import 'package:hadirio/enums/presence_type_enums.dart';
import 'package:hadirio/models/general_response.dart';
import 'package:hadirio/models/history_response.dart';
import 'package:hadirio/models/login_response.dart';
import 'package:hadirio/utils/extensions/date_format.dart';
import 'package:hadirio/utils/function.dart';
import 'package:mysql_client/mysql_client.dart';

abstract class Repository {
  static Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final connection = await DbConnection().pool();
      await connection.connect();
      final query = await connection.execute(
        "SELECT * FROM users WHERE username = '$username'",
      );
      await connection.close();
      log(
        query.rows.map((item) => item.assoc()).toList().toString(),
        name: 'QUERY',
      );

      if (query.rows.isEmpty) {
        return LoginResponse(
          errors: 'Username tidak ditemukan',
        );
      }
      final response = LoginResponse.fromJson(query.rows.first.assoc());

      if (password != response.password) {
        return LoginResponse(errors: 'Password salah');
      }

      return response;
    } catch (e) {
      log(e.toString(), name: 'ERROR');
      return LoginResponse(errors: 'Terjadi Kesalahan');
    }
  }

  static Future<List<LoginResponse>> getUser() async {
    try {
      final connection = await DbConnection().pool();
      await connection.connect();
      final query = await connection.execute(
        "SELECT * FROM users",
      );
      await connection.close();
      log(
        query.rows.map((item) => item.assoc()).toList().toString(),
        name: 'QUERY',
      );

      if (query.rows.isEmpty) {
        return [];
      }

      List<LoginResponse> list = [];

      for (final item in query.rows) {
        list.add(LoginResponse.fromJson(item.assoc()));
      }
      return list;
    } catch (e) {
      log(e.toString(), name: 'ERROR');
      return [];
    }
  }

  static Future<LoginResponse> updateProfile({
    required String id,
    required String gender,
    required String phone,
  }) async {
    try {
      final connection = await DbConnection().pool();
      await connection.connect();
      await connection.execute(
        """
        UPDATE users 
        SET
            gender = '$gender',
            phone = '$phone'
        WHERE id = '$id'
        """,
      );
      final query = await connection.execute(
        "SELECT * FROM users WHERE id = '$id'",
      );
      await connection.close();
      log(
        query.rows.map((item) => item.assoc()).toList().toString(),
        name: 'QUERY',
      );
      if (query.rows.isEmpty) {
        return LoginResponse(
          errors: 'Terjadi Kesalahan',
        );
      }
      final response = LoginResponse.fromJson(query.rows.first.assoc());
      return response;
    } catch (e) {
      log(e.toString(), name: 'ERROR');
      return LoginResponse(errors: 'Terjadi Kesalahan');
    }
  }

  static Future<GeneralResponse> doPresence({
    required PresenceTypeEnums type,
    required String date,
    String? userName,
    String? userId,
    String? file,
    String? reason,
  }) async {
    try {
      final connection = await DbConnection().pool();
      await connection.connect();
      if (type != PresenceTypeEnums.checkout) {
        final checkData = await connection.execute(
          """
          SELECT * 
          FROM history 
          WHERE DATE(checkin) = '${date.toShortDateParams()}' AND user_id = '$userId'
          """,
        );
        log(
          checkData.rows.map((item) => item.assoc()).toList().toString(),
          name: 'QUERY-CHECK',
        );
        if (checkData.rows.isNotEmpty) {
          connection.close();
          return GeneralResponse(
            errors: 'Anda sudah melakukan presensi hari ini',
          );
        }
        IResultSet query;
        if (file != null) {
          log(file, name: 'LOG-FILE');
          query = await connection.execute(
            """
            INSERT INTO
                history (checkin, status, user_id, user_name, file)
            VALUES
                ('$date', 'Sakit', '$userId', '$userName', '$file')
            """,
          );
        } else if (reason != null) {
          query = await connection.execute(
            """
            INSERT INTO
                history (checkin, status, user_id, user_name, reason)
            VALUES
                ('$date', 'Izin', '$userId', '$userName', '$reason')
            """,
          );
        } else {
          String status = isLate(date) ? 'Terlambat' : 'Masuk';
          query = await connection.execute(
            """
            INSERT INTO
                history (checkin, status, user_id, user_name)
            VALUES
                ('$date', '$status', '$userId', '$userName')
            """,
          );
        }
        query = await connection.execute(
          """
          SELECT * 
          FROM history 
          WHERE DATE(checkin) = '${date.toShortDateParams()}' AND user_id = '$userId'
          """,
        );
        connection.close();
        log(
          query.rows.map((item) => item.assoc()).toList().toString(),
          name: 'QUERY',
        );
        if (query.rows.isEmpty) {
          return GeneralResponse(
            errors: 'Terjadi Kesalahan',
          );
        }
      } else {
        /// checkout
        final checkData1 = await connection.execute(
          """
          SELECT * 
          FROM history 
          WHERE DATE(checkin) = '${date.toShortDateParams()}' AND user_id = '$userId'
          """,
        );
        if (checkData1.rows.isEmpty) {
          connection.close();
          return GeneralResponse(
            errors: 'Anda belum checkin hari ini',
          );
        }
        final checkData2 = await connection.execute(
          """
          SELECT * 
          FROM history 
          WHERE DATE(checkout) = '${date.toShortDateParams()}' AND user_id = '$userId'
          """,
        );
        if (checkData2.rows.isNotEmpty) {
          connection.close();
          return GeneralResponse(
            errors: 'Anda sudah melakukan checkout hari ini',
          );
        }

        final tempData = HistoryResponse(
          data: checkData1.rows
              .map((item) => HistoryData.fromJson(item.assoc()))
              .toList(),
        );

        IResultSet query = await connection.execute(
          """
          UPDATE history
          SET checkout = '$date'
          WHERE id = '${tempData.data?.first.id}'
          """,
        );
        query = await connection.execute(
          """
          SELECT * 
          FROM history 
          WHERE DATE(checkout) = '${date.toShortDateParams()}' AND user_id = '$userId'
          """,
        );
        connection.close();
        if (query.rows.isEmpty) {
          return GeneralResponse(
            errors: 'Terjadi Kesalahan',
          );
        }
      }

      final response = GeneralResponse(isSuccess: true);

      return response;
    } catch (e) {
      log(e.toString(), name: 'ERROR');
      return GeneralResponse(
        isSuccess: false,
        errors: e.toString(),
      );
    }
  }

  static Future<HistoryResponse> getTodayPresence({String? id}) async {
    try {
      final connection = await DbConnection().pool();
      await connection.connect();
      String date = DateTime.now().toShortDateParams();
      IResultSet query;
      if (id != null) {
        query = await connection.execute(
          """
          SELECT * 
          FROM history
          WHERE user_id = '$id' AND DATE(checkin) = '$date'
          """,
        );
      } else {
        query = await connection.execute(
          """
          SELECT 
              h.id,
              h.checkin, 
              h.checkout, 
              u.id AS user_id, 
              u.username AS user_name, 
              h.status, 
              h.file, 
              h.reason
          FROM users u
          LEFT JOIN history h ON u.id = h.user_id 
          AND DATE(h.checkin) = '$date';
          """,
        );
      }
      await connection.close();
      log(
        query.rows.map((item) => item.assoc()).toList().toString(),
        name: 'QUERY',
      );
      if (query.rows.isEmpty) {
        return HistoryResponse(
          data: [],
        );
      }
      return HistoryResponse(
        data: query.rows
            .map((item) => HistoryData.fromJson(item.assoc()))
            .toList(),
      );
    } catch (e) {
      log(e.toString(), name: 'ERROR');
      return HistoryResponse(errors: 'Terjadi Kesalahan');
    }
  }

  static Future<HistoryResponse> getHistory({
    required String? id,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final connection = await DbConnection().pool();
      await connection.connect();
      final query = await connection.execute(
        """
        SELECT 
            h.id,
            h.checkin, 
            h.checkout, 
            u.id AS user_id, 
            u.username AS user_name, 
            h.status, 
            h.file, 
            h.reason
        FROM users u
        INNER JOIN 
            history h ON u.id = h.user_id 
            AND h.checkin BETWEEN '$startDate' AND '$endDate'
        WHERE u.id = '$id'
        """,
      );

      await connection.close();
      log(
        query.rows.map((item) => item.assoc()).toList().toString(),
        name: 'QUERY',
      );
      if (query.rows.isEmpty) {
        return HistoryResponse(
          errors: 'Data Kosong',
        );
      }
      return HistoryResponse(
        data: query.rows
            .map((item) => HistoryData.fromJson(item.assoc()))
            .toList(),
      );
    } catch (e) {
      log(e.toString(), name: 'ERROR');
      return HistoryResponse(errors: 'Terjadi Kesalahan');
    }
  }
}

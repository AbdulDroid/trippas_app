import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trippas_app/model/trip.dart';

class DBHelper {
  static final _dbHelper = DBHelper._internal();

  String tblTrip = 'trip';
  String coldId = 'id';
  String colDeparture = 'departure';
  String colDepartureTime = 'departure_time';
  String colDepartureDate = 'departure_date';
  String colArrival = 'arrival';
  String colArrivalTime = 'arrival_time';
  String colArrivalDate = 'arrival_date';
  String colTripType = 'trip_type';

  DBHelper._internal();

  factory DBHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}trip.db';
    var dbTrip = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTrip;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "create table $tblTrip($coldId integer primary key, $colDeparture text not null, $colDepartureDate text not null, $colDepartureTime text not null," +
            "$colArrival text not null, $colArrivalDate text not null, $colArrivalTime text not null, $colTripType text not null)");
  }

  Future<int> insertTrip(Trip trip) async {
    Database db = await this.db;
    var result = await db.insert(
      tblTrip,
      trip.toMap(),
    );
    return result;
  }

  Future<List> getTrips() async {
    Database db = await this.db;
    var result =
        await db.rawQuery('select * from $tblTrip order by $coldId desc');
    return result;
  }

  Future<int> getTripCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery('select count (*) from $tblTrip'));
    return result;
  }

  Future<int> updateTrip(Trip trip) async {
    Database db = await this.db;
    var result = await db.update(
      tblTrip,
      trip.toMap(),
      where: '$coldId = ?',
      whereArgs: [trip.id],
    );
    return result;
  }

  Future<int> deleteTrip(int id) async {
    Database db = await this.db;
    var result = await db.delete(
      tblTrip,
      where: '$coldId = ?',
      whereArgs: [id],
    );

    return result;
  }
}

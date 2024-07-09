import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/model/user_model.dart';
import 'package:test_app/view/screens/login.dart';

dynamic database;

Future<void> dbConnection() async {
  try {
    database = await openDatabase(
      join(await getDatabasesPath(), "testDB.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""CREATE TABLE signup(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT, 
          password TEXT
        )""");
      },
    );

    //get data from signUp table
    signlist = await getSignUpData();
  } catch (e) {
    log('Error initializing database: $e');
    // Handle error (e.g., show a message to the user)
  }
}

//insert data in signup table

Future<void> insertSignupData(UserModel obj) async {
  try {
    final localDb = await database;

    await localDb.insert('signup', obj.userMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    signlist = await getSignUpData();
  } catch (e) {
    log('Error inserting data: $e');
    // Handle error (e.g., show a message to the user)
  }
}

//fetchData from signup table

Future<List<UserModel>> getSignUpData() async {
  try {
    final localDb = await database;

    List<Map<String, dynamic>> signuplist = await localDb.query("signup");
    return List.generate(signuplist.length, (i) {
      return UserModel(
        id: signuplist[i]['id'],
        name: signuplist[i]['name'],
        email: signuplist[i]['email'],
        password: signuplist[i]['password'],
      );
    });
  } catch (e) {
    log('Error fetching data: $e');
    // Handle error (e.g., return an empty list or show a message to the user)
    return [];
  }
}

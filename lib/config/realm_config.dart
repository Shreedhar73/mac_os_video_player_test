import 'dart:developer';

import 'package:flutter_realm_test/models/person.dart';
import 'package:realm/realm.dart';

class RealmConfig {
  // private constructor which cannot be called from outside the library. Used to return the same instance of the class.
  RealmConfig._();
  late App app;
  late Realm realmHelper;
  User? loggedInUser;

  static final _instance = RealmConfig._();

  // static variable
  static RealmConfig get instance => _instance;

  localConfiguration() {
    final config = Configuration.local([Person.schema]);
    realmHelper = Realm(config);
  }

  User? getRealmuser() {
    loggedInUser = app.currentUser;
    return app.currentUser;
  }

  Future<User> userLogin(
      {required String email, required String password}) async {
    try {
      final user = await app.logIn(Credentials.emailPassword(email, password));
      return user;
    } on RealmError catch (e) {
      log("Error: $e");
      throw Exception(e);
    }
  }

  userRegister({required String email, required String password}) async {
    try {
      EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
      authProvider.registerUser(email, password);
    } on RealmError catch (e) {
      log("Error: $e");
      throw Exception(e);
    }
  }

  Future<void> subscription() async {
    realmHelper.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realmHelper.all<Person>());
    });
    await realmHelper.subscriptions.waitForSynchronization();
  }
}

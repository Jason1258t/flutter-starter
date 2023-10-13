import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/services/api/token_model.dart';

const String _tokenKey = 'token';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class PreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future saveToken(Token token) async {
    // _prefs.then(
    //     (prefs) => prefs.setString(_tokenKey, jsonEncode(token.toJson())));
    storage.write(key: _tokenKey, value: jsonEncode(token.toJson()));
  }

  Future<Token> getToken() async {
    // final prefs = await _prefs;
    //
    // final res = prefs.getString(_tokenKey);
    final res = await storage.read(key: _tokenKey);
    if (res != null) {
      return Token.fromJson(jsonDecode(res));
    } else {
      return Token.zero();
    }
  }

  Future logout() async => storage.deleteAll();
}

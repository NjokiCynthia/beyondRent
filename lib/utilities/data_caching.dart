import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataCacheManager {
  static const String KEY_DATA = 'cachedData';

  static Future<void> saveDataToCache(String key, dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(data));
  }

  static Future<dynamic> loadDataFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      // If data is found in the cache, parse and return it
      return json.decode(cachedData);
    } else {
      // If no data is found in the cache, return null
      return null;
    }
  }

  static Future<void> clearCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

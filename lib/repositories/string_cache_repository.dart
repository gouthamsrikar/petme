import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for caching and loading strings
class StringCacheRepository {
  /// Saves the list of strings to local storage
  Future<void> saveStrings(List<String> strings, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, strings);
  }

  /// Loads the cached list of strings from local storage
  Future<List<String>> loadStrings(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
}

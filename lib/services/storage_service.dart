import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _key = 'mood_entries_v1';

  static Future<Map<String, dynamic>> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return {};
    try { return jsonDecode(raw) as Map<String, dynamic>; } catch (_) { return {}; }
  }

  static Future<void> saveEntry(String dateKey, String mood, String note) async {
    final prefs = await SharedPreferences.getInstance();
    final map = await _loadAll();
    map[dateKey] = { 'mood': mood, 'note': note };
    await prefs.setString(_key, jsonEncode(map));
  }

  static Future<Map<String, dynamic>> getAllEntries() async => await _loadAll();

  static Future<Map<String, String>> getEntry(String dateKey) async {
    final map = await _loadAll();
    final v = map[dateKey];
    if (v == null) return {};
    return { 'mood': v['mood'] ?? '', 'note': v['note'] ?? '' };
  }
}

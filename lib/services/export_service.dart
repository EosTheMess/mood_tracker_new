import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'storage_service.dart';

class ExportService {
  static Future<String> exportToCsv() async {
    final all = await StorageService.getAllEntries();
    final List<List<String>> rows = [['Date','Mood','Note']];
    all.forEach((key, val) {
      rows.add([key, val['mood'] ?? '', val['note'] ?? '']);
    });
    final csv = const ListToCsvConverter().convert(rows);
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/mood_entries.csv';
    final file = File(path);
    await file.writeAsString(csv);
    return path;
  }
}

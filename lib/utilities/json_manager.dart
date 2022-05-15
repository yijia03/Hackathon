import 'dart:convert';
import 'dart:io';
import 'package:papyrus/utilities/brain.dart';
import 'package:path_provider/path_provider.dart';

class JSONManager {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/save.json');
  }

  static Future<File> save(Brain b) async {
    final file = await _localFile;
    return file.writeAsString(b.toJSON());
  }

  static Future<Brain> load() async {
    final file = await _localFile;
    String json = await file.readAsString();
    dynamic data = jsonDecode(json);
    return Brain.fromJSON(data);
  }
}

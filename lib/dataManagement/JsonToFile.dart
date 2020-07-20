import 'dart:convert';
import 'dart:io';
import 'package:in_search_of_the_lost_chord/dataManagement/IDataManager.dart';
import 'package:path_provider/path_provider.dart';

class JsonToFile<T> implements IDataManager<T> {
  final String filePath;
  final File file;

  JsonToFile(this.filePath, this.file);

  static Future<JsonToFile> asyncFactory<T>() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    path += "savedData.json";
    File file = File(path);
    if (!await file.exists()) file.create(recursive: true);
    return JsonToFile<T>(path, file);
  }

  @override
  void save(T data) async {
    String dataEncoded = jsonEncode(data);
    //File file = File('$directoryPath/savedData.json');
    file.writeAsString(dataEncoded);
  }

  Future<List<Map<String, dynamic>>> load() async {
    String data = await file.readAsString();
    List<Map<String, dynamic>> decodedData = jsonDecode(data);
    return decodedData;
  }
}

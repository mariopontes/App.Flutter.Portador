import 'package:get_it/get_it.dart';

final app = GetIt.instance;

class LocalStorageService {
  static LocalStorageService _instance;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    return _instance;
  }
}

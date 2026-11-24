
import 'package:hive_ce/hive.dart';

class CacheService {
  static const String boxName = 'servers_cache';

  Future<void> saveServers(List<Map<String, dynamic>> servers) async {
    final box = await Hive.openBox(boxName);

    await box.put('servers', servers);
  }

  Future<List<Map<String, dynamic>>> getServers() async {
    final box = await Hive.openBox(boxName);

    final data = box.get('servers');

    if (data == null) {
      return [];
    }

    return List<Map<String, dynamic>>.from(
      (data as List).map(
        (item) => Map<String, dynamic>.from(item),
      ),
    );
  }
}

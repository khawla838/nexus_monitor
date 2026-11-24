import 'package:hive_ce_flutter/hive_flutter.dart';

import '../network/models/server_model.dart';

class ServerCacheService {
  static const String boxName = 'serversBox';

  // Sauvegarder les serveurs
  static Future<void> saveServers(List<ServerModel> servers) async {
    final box = Hive.box(boxName);

    final data = servers.map((server) {
      return {
        'id': server.id,
        'name': server.name,
        'description': server.description,
      };
    }).toList();

    await box.put('servers', data);
  }

  // Récupérer les serveurs sauvegardés
  static List<ServerModel> getCachedServers() {
    final box = Hive.box(boxName);
    final data = box.get('servers');

    if (data == null) {
      return [];
    }

    return (data as List).map((item) {
      return ServerModel.fromJson(
        Map<String, dynamic>.from(item),
      );
    }).toList();
  }

  // Supprimer le cache
  static Future<void> clearCache() async {
    final box = Hive.box(boxName);
    await box.delete('servers');
  }
}
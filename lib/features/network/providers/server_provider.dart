import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api_service.dart';
import '../models/server_model.dart';
import '../../services/server_cache_service.dart';

final serverProvider = FutureProvider<List<ServerModel>>((ref) async {
  final apiService = ApiService();

  try {
    // 1. Récupérer les données depuis l'API
    final response = await apiService.fetchServers();

    // 2. Convertir les données JSON en ServerModel
    final servers = response
        .map((json) => ServerModel.fromJson(json))
        .toList();

    // 3. Sauvegarder les données dans Hive
    await ServerCacheService.saveServers(servers);

    // 4. Retourner les données de l'API
    return servers;
  } catch (e) {
    // 5. En cas d'erreur, récupérer les données locales
    final cachedServers = ServerCacheService.getCachedServers();

    if (cachedServers.isNotEmpty) {
      return cachedServers;
    }

    // 6. Si API et cache échouent
    throw Exception('Impossible de charger les serveurs');
  }
});

import 'package:dio/dio.dart';

import 'network_interceptor.dart';
import 'cache_service.dart';

class ApiService {
  late final Dio _dio;
  final CacheService _cacheService = CacheService();

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Ajout de notre Interceptor
    _dio.interceptors.add(NetworkInterceptor());
  }

  Future<List<dynamic>> fetchServers() async {
    try {
      // 1. Récupérer les données depuis l'API
      final response = await _dio.get('/posts');

      final List<Map<String, dynamic>> servers =
          List<Map<String, dynamic>>.from(
        (response.data as List).map(
          (item) => Map<String, dynamic>.from(item),
        ),
      );

      // 2. Sauvegarder les données dans le cache local
      await _cacheService.saveServers(servers);

      // 3. Retourner les données récupérées
      return servers;
    } catch (e) {
      // 4. En cas d'échec, essayer le cache local
      final cachedServers = await _cacheService.getServers();

      if (cachedServers.isNotEmpty) {
        return cachedServers;
      }

      // 5. Aucun cache disponible
      throw Exception(
        'Impossible de charger les données : $e',
      );
    }
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NexusMonitorApp(),
    ),
  );
}

class NexusMonitorApp extends ConsumerWidget {
  const NexusMonitorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'NEXUS MONITOR',
      routerConfig: router,
    );
  }
}

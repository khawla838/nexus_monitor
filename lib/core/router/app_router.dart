
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/pin_screen.dart';
import '../../dashboard/dashboard_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final status = ref.read(authProvider);
      final location = state.matchedLocation;

      if (status == AuthStatus.loggedOut &&
          location != '/login') {
        return '/login';
      }

      if (status == AuthStatus.awaitingPin &&
          location != '/pin') {
        return '/pin';
      }

      if (status == AuthStatus.authenticated &&
          (location == '/login' || location == '/pin')) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/pin',
        builder: (context, state) => const PinScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );

  ref.listen<AuthStatus>(authProvider, (previous, next) {
    router.refresh();
  });

  ref.onDispose(router.dispose);

  return router;
});

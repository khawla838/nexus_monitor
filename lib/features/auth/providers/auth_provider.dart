
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  loggedOut,
  awaitingPin,
  authenticated,
}

class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    return AuthStatus.loggedOut;
  }

  // Vérification temporaire des identifiants (mode démonstration)
  bool login(String email, String password) {
    if (email == 'admin@nexus.com' && password == '123456') {
      state = AuthStatus.awaitingPin;
      return true;
    }

    return false;
  }

  // Vérification temporaire du code PIN
  bool verifyPin(String pin) {
    if (pin == '1234') {
      state = AuthStatus.authenticated;
      return true;
    }

    return false;
  }

  void logout() {
    state = AuthStatus.loggedOut;
  }
}

final authProvider =
    NotifierProvider<AuthController, AuthStatus>(
  AuthController.new,
);

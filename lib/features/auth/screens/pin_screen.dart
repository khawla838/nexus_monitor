
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class PinScreen extends ConsumerStatefulWidget {
  const PinScreen({super.key});

  @override
  ConsumerState<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends ConsumerState<PinScreen> {
  final pinController = TextEditingController();
  String? errorMessage;

  void verifyPin() {
    final success = ref
        .read(authProvider.notifier)
        .verifyPin(pinController.text.trim());

    if (success) {
      context.go('/dashboard');
    } else {
      setState(() {
        errorMessage = 'Code PIN incorrect. Réessayez.';
      });
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.verified_user,
                  color: Colors.blueAccent,
                  size: 65,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Vérification en deux étapes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Veuillez saisir votre code PIN pour continuer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    counterText: '',
                    labelText: 'Code PIN',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: verifyPin,
                    child: const Text('Vérifier'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_monitor/main.dart';

void main() {
  // Les 3 largeurs demandées par la consigne de l'atelier 01.
  const sizes = <String, Size>{
    'smartphone': Size(360, 800),
    'tablette': Size(700, 900),
    'grand écran': Size(1200, 800),
  };

  sizes.forEach((name, size) {
    testWidgets('Dashboard affiché sans débordement - $name', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const NexusMonitorApp());

      // Aucune erreur de layout (overflow) pendant le rendu.
      expect(tester.takeException(), isNull);

      // Titres principaux
      expect(find.text('NEXUS MONITOR'), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('System Overview'), findsOneWidget);
      expect(find.text('Server Status'), findsOneWidget);

      // Cartes de métriques
      expect(find.text('CPU Usage'), findsOneWidget);
      expect(find.text('RAM Usage'), findsOneWidget);
      expect(find.text('Active Servers'), findsOneWidget);
    });
  });

  testWidgets('Affiche les serveurs et leurs statuts', (tester) async {
    await tester.pumpWidget(const NexusMonitorApp());

    expect(find.text('Production Server'), findsOneWidget);
    expect(find.text('Database Server'), findsOneWidget);
    expect(find.text('Backup Server'), findsOneWidget);

    expect(find.text('Online'), findsNWidgets(2));
    expect(find.text('Warning'), findsOneWidget);
  });

  testWidgets('Affiche la bannière d\'alerte quand un serveur est en Warning',
      (tester) async {
    await tester.pumpWidget(const NexusMonitorApp());

    expect(find.text('Attention required'), findsOneWidget);
  });
}
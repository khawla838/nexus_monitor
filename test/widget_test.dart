
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_monitor/main.dart';

void main() {
  testWidgets('Nexus Monitor application starts', (WidgetTester tester) async {
    await tester.pumpWidget(const NexusMonitorApp());

    expect(find.text('NEXUS MONITOR'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_monitor/main.dart';

void main() {
  testWidgets('Nexus Monitor dashboard displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NexusMonitorApp());

    expect(find.text('NEXUS MONITOR'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('System Overview'), findsOneWidget);
    expect(find.text('CPU Usage'), findsOneWidget);
    expect(find.text('RAM Usage'), findsOneWidget);
    expect(find.text('Server Status'), findsOneWidget);
    expect(find.text('Production Server'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';

void main() {
  runApp(const NexusMonitorApp());
}

class NexusMonitorApp extends StatelessWidget {
  const NexusMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.dns_rounded,
                color: Colors.white,
                size: 23,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'NEXUS MONITOR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final cardWidth = width >= 1000
              ? (width - 64) / 3
              : width >= 650
              ? (width - 16) / 2
              : width;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width >= 900 ? 32 : 20,
              vertical: 28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dashboard header
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF172033),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Monitor your server infrastructure',
                            style: TextStyle(
                              color: Color(0xFF7B8495),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.circle, color: Color(0xFF16A34A), size: 9),
                          SizedBox(width: 7),
                          Text(
                            'Live Demo',
                            style: TextStyle(
                              color: Color(0xFF15803D),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Statistics section
                const Text(
                  'System Overview',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 16),

                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    MetricCard(
                      title: 'CPU Usage',
                      value: '42%',
                      subtitle: 'Processor load',
                      icon: Icons.memory_rounded,
                      color: const Color(0xFF2563EB),
                      width: cardWidth,
                      progress: 0.42,
                    ),
                    MetricCard(
                      title: 'RAM Usage',
                      value: '68%',
                      subtitle: 'Memory consumption',
                      icon: Icons.storage_rounded,
                      color: const Color(0xFF8B5CF6),
                      width: cardWidth,
                      progress: 0.68,
                    ),
                    MetricCard(
                      title: 'Active Servers',
                      value: '08',
                      subtitle: 'Servers monitored',
                      icon: Icons.dns_rounded,
                      color: const Color(0xFF0D9488),
                      width: cardWidth,
                      progress: null,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Server status header
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Server Status',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF172033),
                      ),
                    ),
                    Text(
                      '3 servers displayed',
                      style: TextStyle(color: Color(0xFF7B8495), fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const ServerTile(
                  name: 'Production Server',
                  address: '192.168.1.101',
                  status: 'Online',
                  color: Color(0xFF16A34A),
                  icon: Icons.cloud_done_rounded,
                ),

                const ServerTile(
                  name: 'Database Server',
                  address: '192.168.1.102',
                  status: 'Warning',
                  color: Color(0xFFF59E0B),
                  icon: Icons.storage_rounded,
                ),

                const ServerTile(
                  name: 'Backup Server',
                  address: '192.168.1.103',
                  status: 'Online',
                  color: Color(0xFF16A34A),
                  icon: Icons.backup_rounded,
                ),

                const SizedBox(height: 24),

                // Information panel
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFDBEAFE)),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF2563EB),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Demo mode: displayed monitoring values are simulated.',
                          style: TextStyle(
                            color: Color(0xFF1E40AF),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Reusable statistics card
class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double width;
  final double? progress;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.width,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE8ECF3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF687386),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Icon(icon, color: color, size: 23),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                subtitle,
                style: const TextStyle(color: Color(0xFF929BAB), fontSize: 12),
              ),

              if (progress != null) ...[
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFEDF0F5),
                    color: color,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable server status component
class ServerTile extends StatelessWidget {
  final String name;
  final String address;
  final String status;
  final Color color;
  final IconData icon;

  const ServerTile({
    super.key,
    required this.name,
    required this.address,
    required this.status,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE8ECF3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF475569)),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF172033),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Color(0xFF929BAB),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: color),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

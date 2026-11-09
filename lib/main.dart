import 'package:flutter/material.dart';

void main() {
  runApp(const NexusMonitorApp());
}

class NexusMonitorApp extends StatelessWidget {
  const NexusMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nexus Monitor',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF176B87),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
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
        title: const Text(
          'NEXUS MONITOR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final cardWidth = width >= 900
              ? (width - 48) / 3
              : width >= 600
              ? (width - 24) / 2
              : width;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Overview of your server infrastructure',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    StatCard(
                      title: 'CPU Usage',
                      value: '42%',
                      icon: Icons.memory,
                      width: cardWidth,
                    ),
                    StatCard(
                      title: 'RAM Usage',
                      value: '68%',
                      icon: Icons.storage,
                      width: cardWidth,
                    ),
                    StatCard(
                      title: 'Active Servers',
                      value: '08',
                      icon: Icons.dns,
                      width: cardWidth,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  'Server Status',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                const ServerTile(
                  name: 'Server 01',
                  status: 'Online',
                  color: Colors.green,
                ),
                const ServerTile(
                  name: 'Server 02',
                  status: 'Warning',
                  color: Colors.orange,
                ),
                const ServerTile(
                  name: 'Server 03',
                  status: 'Online',
                  color: Colors.green,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double width;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.blue, size: 30),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServerTile extends StatelessWidget {
  final String name;
  final String status;
  final Color color;

  const ServerTile({
    super.key,
    required this.name,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Icons.dns),
        title: Text(name),
        trailing: Text(
          status,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

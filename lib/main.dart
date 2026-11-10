import 'package:flutter/material.dart';

void main() => runApp(const NexusMonitorApp());

// ───────────────────────── Couleurs (un seul endroit) ─────────────────────────
class AppColors {
  AppColors._();

  static const primary = Color(0xFF2563EB);
  static const violet = Color(0xFF8B5CF6);
  static const teal = Color(0xFF0D9488);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFDC2626);

  static const background = Color(0xFFF5F7FB);
  static const border = Color(0xFFE8ECF3);
  static const textPrimary = Color(0xFF172033);
  static const textSecondary = Color(0xFF7B8495);
}

// ───────────────────────── Modèle + données simulées ─────────────────────────
enum ServerStatus {
  online('Online', AppColors.success),
  warning('Warning', AppColors.warning),
  offline('Offline', AppColors.danger);

  const ServerStatus(this.label, this.color);
  final String label;
  final Color color;
}

class Server {
  const Server({
    required this.name,
    required this.address,
    required this.status,
    required this.icon,
  });

  final String name;
  final String address;
  final ServerStatus status;
  final IconData icon;
}

const _servers = <Server>[
  Server(
    name: 'Production Server',
    address: '192.168.1.101',
    status: ServerStatus.online,
    icon: Icons.cloud_done_rounded,
  ),
  Server(
    name: 'Database Server',
    address: '192.168.1.102',
    status: ServerStatus.warning,
    icon: Icons.storage_rounded,
  ),
  Server(
    name: 'Backup Server',
    address: '192.168.1.103',
    status: ServerStatus.online,
    icon: Icons.backup_rounded,
  ),
];

// Historique simulé pour les mini-graphes
const _cpuHistory = <double>[0.30, 0.38, 0.33, 0.47, 0.41, 0.52, 0.44, 0.42];
const _ramHistory = <double>[0.55, 0.58, 0.61, 0.59, 0.64, 0.66, 0.67, 0.68];

// ───────────────────────── Application ─────────────────────────
class NexusMonitorApp extends StatelessWidget {
  const NexusMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

// ───────────────────────── Page principale ─────────────────────────
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final warningCount =
        _servers.where((s) => s.status == ServerStatus.warning).length;

    return Scaffold(
      appBar: AppBar(
        title: const _Brand(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.border),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          // Sur grand écran, le contenu reste centré et lisible.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeaderBanner(),
                  if (warningCount > 0) ...[
                    const SizedBox(height: 16),
                    _AlertBanner(count: warningCount),
                  ],
                  const SizedBox(height: 28),
                  const _SectionTitle('System Overview'),
                  const SizedBox(height: 16),
                  const _ResponsiveWrap(
                    children: [
                      MetricCard(
                        title: 'CPU Usage',
                        value: '42%',
                        subtitle: 'Processor load',
                        icon: Icons.memory_rounded,
                        color: AppColors.primary,
                        progress: 0.42,
                        history: _cpuHistory,
                      ),
                      MetricCard(
                        title: 'RAM Usage',
                        value: '68%',
                        subtitle: 'Memory consumption',
                        icon: Icons.storage_rounded,
                        color: AppColors.violet,
                        progress: 0.68,
                        history: _ramHistory,
                      ),
                      MetricCard(
                        title: 'Active Servers',
                        value: '08',
                        subtitle: 'Servers monitored',
                        icon: Icons.dns_rounded,
                        color: AppColors.teal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const Expanded(child: _SectionTitle('Server Status')),
                      const SizedBox(width: 12),
                      Text(
                        '${_servers.length} servers',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  for (final server in _servers) ServerTile(server: server),
                  const SizedBox(height: 12),
                  const _InfoPanel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Petits blocs ─────────────────────────
class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.violet],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.dns_rounded, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text(
            'NEXUS MONITOR',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
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
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Monitor your server infrastructure',
                  style: TextStyle(color: Color(0xFFDBEAFE), fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: Color(0xFF4ADE80), size: 9),
                SizedBox(width: 7),
                Text(
                  'Live Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertBanner extends StatelessWidget {
  const _AlertBanner({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Attention required',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$count server(s) in warning state.',
                  style: const TextStyle(
                    color: Color(0xFFB45309),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Demo mode: displayed monitoring values are simulated.',
              style: TextStyle(color: Color(0xFF1E40AF), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Grille responsive ─────────────────────────
// Calcule le nombre de colonnes d'après la place RÉELLE disponible.
// Plus de largeur passée à la main : le parent décide, l'enfant s'adapte.
class _ResponsiveWrap extends StatelessWidget {
  const _ResponsiveWrap({required this.children});

  final List<Widget> children;
  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        final columns = available >= 900
            ? 3
            : available >= 560
                ? 2
                : 1;
        final itemWidth = (available - _spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

// ───────────────────────── Carte de métrique ─────────────────────────
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.progress,
    this.history,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double? progress;
  final List<double>? history;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
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
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF687386),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 23),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF929BAB),
                fontSize: 12,
              ),
            ),
            if (history != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: CustomPaint(
                  painter: _SparklinePainter(data: history!, color: color),
                ),
              ),
            ],
            if (progress != null) ...[
              const SizedBox(height: 14),
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
    );
  }
}

// Mini-graphe dessiné à la main (aucun package nécessaire).
class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({required this.data, required this.color});

  final List<double> data;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final stepX = size.width / (data.length - 1);
    final points = [
      for (var i = 0; i < data.length; i++)
        Offset(i * stepX, size.height - data[i].clamp(0.0, 1.0) * size.height),
    ];

    final line = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      line.lineTo(p.dx, p.dy);
    }

    // Zone colorée sous la courbe
    final area = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.25),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(Offset.zero & size),
    );

    // Courbe
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Point final
    canvas.drawCircle(points.last, 3.5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.data != data || old.color != color;
}

// ───────────────────────── Ligne de serveur ─────────────────────────
class ServerTile extends StatelessWidget {
  const ServerTile({super.key, required this.server});

  final Server server;

  @override
  Widget build(BuildContext context) {
    final status = server.status;

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
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
              child: Icon(server.icon, color: const Color(0xFF475569)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    server.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    server.address,
                    style: const TextStyle(
                      color: Color(0xFF929BAB),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _StatusChip(status: status),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ServerStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: status.color),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: TextStyle(
              color: status.color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
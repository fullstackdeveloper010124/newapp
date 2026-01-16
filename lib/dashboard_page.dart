import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Sample data
  final int totalTasks = 42;
  final int closedTasks = 18;
  final int inProgressTasks = 12;
  final int noActionYetTasks = 12;

  double get percentageClosed =>
      totalTasks > 0 ? (closedTasks / totalTasks) * 100 : 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome
            const Text(
              'Welcome back!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            // Stats row 1
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    'Total Tasks',
                    totalTasks.toString(),
                    Icons.list_alt,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _statCard(
                    'Closed',
                    closedTasks.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Stats row 2
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    'In Progress',
                    inProgressTasks.toString(),
                    Icons.hourglass_bottom,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _statCard(
                    'No Action',
                    noActionYetTasks.toString(),
                    Icons.access_time,
                    Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Percentage closed
            _percentageCard(),

            const SizedBox(height: 24),

            const Text(
              'Status Breakdown',
              style: TextStyle(
                color: Color(0xFF4FD1C5),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _statusRow('Closed', closedTasks, Colors.green),
            _statusRow('In Progress', inProgressTasks, Colors.orange),
            _statusRow('No Action', noActionYetTasks, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _percentageCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Percentage Closed',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: percentageClosed / 100,
            backgroundColor: Colors.grey.shade800,
            valueColor:
                const AlwaysStoppedAnimation(Color(0xFF4FD1C5)),
            minHeight: 10,
          ),
          const SizedBox(height: 8),
          Text(
            '${percentageClosed.toStringAsFixed(1)}%',
            style: const TextStyle(
              color: Color(0xFF4FD1C5),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusRow(String label, int value, Color color) {
    final double percent =
        totalTasks > 0 ? (value / totalTasks) : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white))),
          Text('$value', style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey.shade800,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Data models
class CompletionTrendData {
  final String month;
  final int completed;
  final int inProgress;

  CompletionTrendData(this.month, this.completed, this.inProgress);
}

class TeamMemberData {
  final String name;
  final int closed;
  final int inProgress;

  TeamMemberData(this.name, this.closed, this.inProgress);
}

class StatusInsightsPage extends StatefulWidget {
  const StatusInsightsPage({super.key});

  @override
  State<StatusInsightsPage> createState() => _StatusInsightsPageState();
}

class _StatusInsightsPageState extends State<StatusInsightsPage> {
  String _selectedDateRange = 'Last 30 Days';

  final List<CompletionTrendData> completionTrendData = [
    CompletionTrendData('Jan', 12, 8),
    CompletionTrendData('Feb', 15, 10),
    CompletionTrendData('Mar', 18, 12),
    CompletionTrendData('Apr', 20, 14),
    CompletionTrendData('May', 22, 16),
    CompletionTrendData('Jun', 25, 18),
  ];

  final List<TeamMemberData> teamMemberData = [
    TeamMemberData('John Doe', 24, 6),
    TeamMemberData('Jane Smith', 18, 8),
    TeamMemberData('Robert Johnson', 15, 10),
    TeamMemberData('Emily Davis', 12, 5),
    TeamMemberData('Michael Wilson', 9, 7),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track and analyze task completion trends and team performance',
              style: TextStyle(color: Colors.grey.shade300, fontSize: 16),
            ),

            const SizedBox(height: 24),

            _sectionTitle('Completion Trend Over Time'),
            _card(_completionChart()),

            const SizedBox(height: 24),

            _sectionTitle('Closed vs In Progress by Team Member'),
            _card(_teamChart()),

            const SizedBox(height: 24),

            _sectionTitle('Summary Statistics'),
            _statsGrid(),
          ],
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF4FD1C5),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _completionChart() {
    return SfCartesianChart(
      plotAreaBorderColor: Colors.transparent,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 30, interval: 5),
      legend: Legend(isVisible: true),
      series: [
        LineSeries<CompletionTrendData, String>(
          dataSource: completionTrendData,
          xValueMapper: (d, _) => d.month,
          yValueMapper: (d, _) => d.completed,
          name: 'Completed',
          color: const Color(0xFF4FD1C5),
          width: 3,
        ),
        LineSeries<CompletionTrendData, String>(
          dataSource: completionTrendData,
          xValueMapper: (d, _) => d.month,
          yValueMapper: (d, _) => d.inProgress,
          name: 'In Progress',
          color: Colors.orange,
          width: 3,
        ),
      ],
    );
  }

  Widget _teamChart() {
    return SfCartesianChart(
      plotAreaBorderColor: Colors.transparent,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 30, interval: 5),
      legend: Legend(isVisible: true),
      series: [
        ColumnSeries<TeamMemberData, String>(
          dataSource: teamMemberData,
          xValueMapper: (d, _) => d.name.split(' ')[0],
          yValueMapper: (d, _) => d.closed,
          name: 'Closed',
          color: const Color(0xFF4FD1C5),
        ),
        ColumnSeries<TeamMemberData, String>(
          dataSource: teamMemberData,
          xValueMapper: (d, _) => d.name.split(' ')[0],
          yValueMapper: (d, _) => d.inProgress,
          name: 'In Progress',
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _statsGrid() {
    final totalClosed = teamMemberData.fold(0, (s, e) => s + e.closed);
    final totalInProgress = teamMemberData.fold(0, (s, e) => s + e.inProgress);
    final total = totalClosed + totalInProgress;
    final rate = total > 0 ? (totalClosed / total) * 100 : 0;

    return _card(
      Column(
        children: [
          Row(
            children: [
              Expanded(child: _stat('Total Tasks', total.toString())),
              const SizedBox(width: 12),
              Expanded(child: _stat('Closed', totalClosed.toString())),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _stat('In Progress', totalInProgress.toString())),
              const SizedBox(width: 12),
              Expanded(child: _stat('Completion', '${rate.toStringAsFixed(1)}%')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

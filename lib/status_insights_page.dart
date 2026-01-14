import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';

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
  List<CompletionTrendData> completionTrendData = [
    CompletionTrendData('Jan', 12, 8),
    CompletionTrendData('Feb', 15, 10),
    CompletionTrendData('Mar', 18, 12),
    CompletionTrendData('Apr', 20, 14),
    CompletionTrendData('May', 22, 16),
    CompletionTrendData('Jun', 25, 18),
  ];
  
  List<TeamMemberData> teamMemberData = [
    TeamMemberData('John Doe', 24, 6),
    TeamMemberData('Jane Smith', 18, 8),
    TeamMemberData('Robert Johnson', 15, 10),
    TeamMemberData('Emily Davis', 12, 5),
    TeamMemberData('Michael Wilson', 9, 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: 'Status Insights',
        onMenuPressed: () {
          Scaffold.of(context).openDrawer();
        },
        onNotificationPressed: () {
          // Handle notification tap
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notifications tapped')),
          );
        },
        onProfilePressed: () {
          // Handle profile tap
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile tapped')),
          );
        },
        actions: [
          // Date range dropdown
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              value: _selectedDateRange,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF4FD1C5),
              ),
              underline: Container(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              dropdownColor: const Color(0xFF2D3748),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDateRange = newValue!;
                });
              },
              items: <String>['Last 7 Days', 'Last 30 Days', 'Last 90 Days', 'Custom Range']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Download PDF button
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Color(0xFF4FD1C5),
            ),
            onPressed: () {
              _downloadPDF();
            },
          ),
        ],
      ),
      drawer: AppDrawer(
        userName: 'John Doe',
        userEmail: 'john.doe@example.com',
        onLogout: () {
          // Handle logout
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page subtitle
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Track and analyze task completion trends and team performance',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 16,
                  ),
                ),
              ),
              
              // Completion Trend Over Time Chart
              _buildSectionHeader('Completion Trend Over Time'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3748),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SfCartesianChart(
                  plotAreaBorderColor: Colors.transparent,
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 30,
                    interval: 5,
                  ),
                  series: <CartesianSeries>[
                    // Completed tasks series
                    LineSeries<CompletionTrendData, String>(
                      dataSource: completionTrendData,
                      xValueMapper: (CompletionTrendData data, _) => data.month,
                      yValueMapper: (CompletionTrendData data, _) => data.completed,
                      name: 'Completed',
                      color: const Color(0xFF4FD1C5),
                      width: 3,
                    ),
                    // In Progress tasks series
                    LineSeries<CompletionTrendData, String>(
                      dataSource: completionTrendData,
                      xValueMapper: (CompletionTrendData data, _) => data.month,
                      yValueMapper: (CompletionTrendData data, _) => data.inProgress,
                      name: 'In Progress',
                      color: Colors.orange,
                      width: 3,
                    ),
                  ],
                  legend: Legend(isVisible: true),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Closed vs In Progress by Team Member Chart
              _buildSectionHeader('Closed vs In Progress by Team Member'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3748),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SfCartesianChart(
                  plotAreaBorderColor: Colors.transparent,
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 30,
                    interval: 5,
                  ),
                  series: <CartesianSeries>[
                    // Closed tasks series
                    ColumnSeries<TeamMemberData, String>(
                      dataSource: teamMemberData,
                      xValueMapper: (TeamMemberData data, _) => data.name.split(' ')[0], // First name only
                      yValueMapper: (TeamMemberData data, _) => data.closed,
                      name: 'Closed',
                      color: const Color(0xFF4FD1C5),
                      width: 0.7,
                    ),
                    // In Progress tasks series
                    ColumnSeries<TeamMemberData, String>(
                      dataSource: teamMemberData,
                      xValueMapper: (TeamMemberData data, _) => data.name.split(' ')[0], // First name only
                      yValueMapper: (TeamMemberData data, _) => data.inProgress,
                      name: 'In Progress',
                      color: Colors.orange,
                      width: 0.7,
                    ),
                  ],
                  legend: Legend(isVisible: true),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Summary statistics
              _buildSectionHeader('Summary Statistics'),
              const SizedBox(height: 16),
              _buildStatsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF4FD1C5),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStatsGrid() {
    int totalClosed = teamMemberData.fold(0, (sum, item) => sum + item.closed);
    int totalInProgress = teamMemberData.fold(0, (sum, item) => sum + item.inProgress);
    int totalTasks = totalClosed + totalInProgress;
    double completionRate = totalTasks > 0 ? (totalClosed / totalTasks) * 100 : 0;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Total Tasks', totalTasks.toString(), Icons.list_alt),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatItem('Closed', totalClosed.toString(), Icons.check_circle),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('In Progress', totalInProgress.toString(), Icons.hourglass_bottom),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatItem('Completion Rate', '${completionRate.toStringAsFixed(1)}%', Icons.trending_up),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF4FD1C5), size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadPDF() {
    // Show a snackbar indicating the PDF download
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generating PDF report...'),
        duration: Duration(seconds: 2),
      ),
    );
    
    // In a real implementation, this would generate and download the PDF
    // For now, we're just showing a notification
  }
}
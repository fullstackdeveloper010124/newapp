import 'package:flutter/material.dart';
import 'task_list_page.dart'; // Import the task list page
import 'status_insights_page.dart'; // Import the status insights page
import 'timeline_page.dart'; // Import the timeline page
import 'team_view_page.dart'; // Import the team view page
import 'remarks_page.dart'; // Import the remarks page
import 'reports_page.dart'; // Import the reports page
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Sample data for demonstration
  int totalTasks = 42;
  int closedTasks = 18;
  int inProgressTasks = 12;
  int noActionYetTasks = 12;
  
  // Calculate percentage closed
  double get percentageClosed => totalTasks > 0 ? (closedTasks / totalTasks) * 100 : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: 'Dashboard',
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
              // Welcome message
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              // Stats Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Tasks',
                      totalTasks.toString(),
                      Icons.list_alt,
                      Colors.blue.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Closed',
                      closedTasks.toString(),
                      Icons.check_circle,
                      Colors.green.shade600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'In Progress',
                      inProgressTasks.toString(),
                      Icons.hourglass_bottom,
                      Colors.orange.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'No Action Yet',
                      noActionYetTasks.toString(),
                      Icons.access_time,
                      Colors.red.shade600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Percentage Closed Card
              _buildPercentageCard(),
              
              const SizedBox(height: 24),
              
              // Status Breakdown Section
              _buildSectionHeader('Status Breakdown'),
              const SizedBox(height: 12),
              _buildStatusBreakdownChart(),
              
              const SizedBox(height: 24),
              
              // Tasks by Priority Section
              _buildSectionHeader('Tasks by Priority'),
              const SizedBox(height: 12),
              _buildPriorityChart(),
              
              const SizedBox(height: 24),
              
              // Leaderboard Section
              _buildSectionHeader('Leaderboard (Completions)'),
              const SizedBox(height: 12),
              _buildLeaderboard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Percentage Closed',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: LinearProgressIndicator(
                  value: percentageClosed / 100,
                  backgroundColor: Colors.grey.shade800,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4FD1C5)),
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '${percentageClosed.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: Color(0xFF4FD1C5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
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

  Widget _buildStatusBreakdownChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildStatusRow('Closed', closedTasks, Colors.green.shade600),
          const Divider(height: 20, color: Colors.grey),
          _buildStatusRow('In Progress', inProgressTasks, Colors.orange.shade600),
          const Divider(height: 20, color: Colors.grey),
          _buildStatusRow('No Action Yet', noActionYetTasks, Colors.red.shade600),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, int value, Color color) {
    double percentage = totalTasks > 0 ? (value / totalTasks) * 100 : 0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(flex: 2, child: Text(label, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text('$value', style: const TextStyle(color: Colors.white))),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade800,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          Text('${percentage.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPriorityChart() {
    // Sample priority data
    final priorityData = [
      {'label': 'High', 'value': 10, 'color': Colors.red.shade600},
      {'label': 'Medium', 'value': 20, 'color': Colors.orange.shade600},
      {'label': 'Low', 'value': 12, 'color': Colors.green.shade600},
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: priorityData.map((data) {
          double percentage = totalTasks > 0 ? (data['value'] as int) / totalTasks * 100 : 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: data['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(flex: 2, child: Text(data['label'].toString(), style: const TextStyle(color: Colors.white))),
                Expanded(child: Text(data['value'].toString(), style: const TextStyle(color: Colors.white))),
                Expanded(
                  flex: 3,
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey.shade800,
                    valueColor: AlwaysStoppedAnimation<Color>(data['color'] as Color),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${percentage.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLeaderboard() {
    // Sample leaderboard data
    final leaderboardData = [
      {'name': 'John Doe', 'completions': 24, 'avatar': 'JD'},
      {'name': 'Jane Smith', 'completions': 18, 'avatar': 'JS'},
      {'name': 'Robert Johnson', 'completions': 15, 'avatar': 'RJ'},
      {'name': 'Emily Davis', 'completions': 12, 'avatar': 'ED'},
      {'name': 'Michael Wilson', 'completions': 9, 'avatar': 'MW'},
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: leaderboardData.asMap().entries.map((entry) {
          int index = entry.key;
          var item = entry.value;
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FD1C5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '#${index + 1}',
                      style: const TextStyle(
                        color: Color(0xFF1A1F26),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      item['avatar'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item['name'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  '${item['completions']} completions',
                  style: const TextStyle(
                    color: Color(0xFF4FD1C5),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';

// Task model for team view
class TeamTask {
  final String id;
  final String item;
  final String priority;
  final String status;
  final DateTime dueDate;
  final String responsible;

  TeamTask({
    required this.id,
    required this.item,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.responsible,
  });
}

class TeamMember {
  final String name;
  final int totalTasks;
  final int closedTasks;
  final int inProgressTasks;
  final double percentComplete;

  TeamMember({
    required this.name,
    required this.totalTasks,
    required this.closedTasks,
    required this.inProgressTasks,
    required this.percentComplete,
  });
}

class TeamViewPage extends StatefulWidget {
  const TeamViewPage({super.key});

  @override
  State<TeamViewPage> createState() => _TeamViewPageState();
}

class _TeamViewPageState extends State<TeamViewPage> {
  String _selectedTeamMember = 'Alice Johnson';
  
  // Sample team members data
  List<TeamMember> teamMembers = [
    TeamMember(name: 'Alice Johnson', totalTasks: 24, closedTasks: 18, inProgressTasks: 4, percentComplete: 75.0),
    TeamMember(name: 'Bob Smith', totalTasks: 18, closedTasks: 12, inProgressTasks: 3, percentComplete: 66.7),
    TeamMember(name: 'Carol Davis', totalTasks: 30, closedTasks: 22, inProgressTasks: 6, percentComplete: 73.3),
    TeamMember(name: 'David Wilson', totalTasks: 15, closedTasks: 10, inProgressTasks: 2, percentComplete: 66.7),
    TeamMember(name: 'Emma Thompson', totalTasks: 22, closedTasks: 16, inProgressTasks: 4, percentComplete: 72.7),
  ];
  
  // Sample tasks data
  List<TeamTask> allTasks = [
    TeamTask(id: '1', item: 'Complete project proposal', priority: 'High', status: 'Closed', dueDate: DateTime.now().subtract(const Duration(days: 2)), responsible: 'Alice Johnson'),
    TeamTask(id: '2', item: 'Review quarterly reports', priority: 'Medium', status: 'In Progress', dueDate: DateTime.now().add(const Duration(days: 3)), responsible: 'Alice Johnson'),
    TeamTask(id: '3', item: 'Prepare client presentation', priority: 'High', status: 'In Progress', dueDate: DateTime.now().add(const Duration(days: 1)), responsible: 'Alice Johnson'),
    TeamTask(id: '4', item: 'Update documentation', priority: 'Low', status: 'Pending', dueDate: DateTime.now().add(const Duration(days: 7)), responsible: 'Alice Johnson'),
    TeamTask(id: '5', item: 'Fix critical bug', priority: 'High', status: 'Closed', dueDate: DateTime.now().subtract(const Duration(days: 1)), responsible: 'Alice Johnson'),
    TeamTask(id: '6', item: 'Conduct user testing', priority: 'Medium', status: 'In Progress', dueDate: DateTime.now().add(const Duration(days: 5)), responsible: 'Bob Smith'),
    TeamTask(id: '7', item: 'Deploy to production', priority: 'High', status: 'Pending', dueDate: DateTime.now().add(const Duration(days: 10)), responsible: 'Carol Davis'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: 'Team View',
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
              // Team member dropdown
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3748),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedTeamMember,
                  decoration: const InputDecoration(
                    labelText: 'Select Team Member',
                    labelStyle: TextStyle(color: Color(0xFF4FD1C5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    filled: true,
                    fillColor: Color(0xFF1A1F26),
                  ),
                  dropdownColor: const Color(0xFF2D3748),
                  style: const TextStyle(color: Colors.white),
                  items: teamMembers.map((TeamMember member) {
                    return DropdownMenuItem<String>(
                      value: member.name,
                      child: Text(member.name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTeamMember = newValue!;
                    });
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Team member stats
              _buildStatsCard(),
              
              const SizedBox(height: 24),
              
              // Tasks for selected team member
              _buildSectionHeader('Tasks for $_selectedTeamMember'),
              const SizedBox(height: 12),
              _buildTasksList(),
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

  Widget _buildStatsCard() {
    final member = teamMembers.firstWhere(
      (member) => member.name == _selectedTeamMember,
      orElse: () => TeamMember(
        name: 'Unknown',
        totalTasks: 0,
        closedTasks: 0,
        inProgressTasks: 0,
        percentComplete: 0.0,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Stats row 1
          Row(
            children: [
              Expanded(
                child: _buildStatBox('Total Tasks', member.totalTasks.toString(), Colors.blue.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatBox('Closed', member.closedTasks.toString(), Colors.green.shade600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row 2
          Row(
            children: [
              Expanded(
                child: _buildStatBox('In Progress', member.inProgressTasks.toString(), Colors.orange.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPercentBox('Complete', member.percentComplete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentBox(String title, double value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            '${value.toStringAsFixed(1)}%',
            style: const TextStyle(
              color: Color(0xFF4FD1C5),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    final tasksForMember = allTasks.where(
      (task) => task.responsible == _selectedTeamMember,
    ).toList();

    if (tasksForMember.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2D3748),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'No tasks assigned to this team member',
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasksForMember.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFF1A1F26)),
        itemBuilder: (context, index) {
          final task = tasksForMember[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(
              task.item,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    'Due: ${_formatDate(task.dueDate)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(task.priority),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.priority,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(task.status),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                task.status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Closed':
        return Colors.green.shade600;
      case 'In Progress':
        return Colors.orange.shade600;
      case 'Pending':
        return Colors.grey.shade600;
      default:
        return Colors.blue.shade600;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red.shade600;
      case 'Medium':
        return Colors.orange.shade600;
      case 'Low':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
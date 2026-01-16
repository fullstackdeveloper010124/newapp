import 'package:flutter/material.dart';

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

  final List<TeamMember> teamMembers = [
    TeamMember(name: 'Alice Johnson', totalTasks: 24, closedTasks: 18, inProgressTasks: 4, percentComplete: 75),
    TeamMember(name: 'Bob Smith', totalTasks: 18, closedTasks: 12, inProgressTasks: 3, percentComplete: 66.7),
    TeamMember(name: 'Carol Davis', totalTasks: 30, closedTasks: 22, inProgressTasks: 6, percentComplete: 73.3),
    TeamMember(name: 'David Wilson', totalTasks: 15, closedTasks: 10, inProgressTasks: 2, percentComplete: 66.7),
    TeamMember(name: 'Emma Thompson', totalTasks: 22, closedTasks: 16, inProgressTasks: 4, percentComplete: 72.7),
  ];

  final List<TeamTask> allTasks = [
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
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 👤 Team member dropdown
          _memberDropdown(),
          const SizedBox(height: 24),

          // 📊 Stats
          _statsCard(),
          const SizedBox(height: 24),

          // 📋 Tasks
          _sectionTitle('Tasks for $_selectedTeamMember'),
          const SizedBox(height: 12),
          _taskList(),
        ]),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF4FD1C5),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _memberDropdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedTeamMember,
        dropdownColor: const Color(0xFF2D3748),
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Select Team Member',
          labelStyle: TextStyle(color: Color(0xFF4FD1C5)),
          filled: true,
          fillColor: Color(0xFF1A1F26),
          border: OutlineInputBorder(),
        ),
        items: teamMembers
            .map((m) => DropdownMenuItem(value: m.name, child: Text(m.name)))
            .toList(),
        onChanged: (val) => setState(() => _selectedTeamMember = val!),
      ),
    );
  }

  Widget _statsCard() {
    final m = teamMembers.firstWhere((e) => e.name == _selectedTeamMember);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Row(children: [
          _statBox('Total', m.totalTasks.toString()),
          const SizedBox(width: 16),
          _statBox('Closed', m.closedTasks.toString()),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _statBox('In Progress', m.inProgressTasks.toString()),
          const SizedBox(width: 16),
          _statBox('Complete', '${m.percentComplete.toStringAsFixed(1)}%'),
        ]),
      ]),
    );
  }

  Widget _statBox(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F26),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(children: [
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ]),
      ),
    );
  }

  Widget _taskList() {
    final tasks =
        allTasks.where((t) => t.responsible == _selectedTeamMember).toList();

    if (tasks.isEmpty) {
      return _emptyBox('No tasks assigned');
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasks.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Color(0xFF1A1F26)),
        itemBuilder: (_, i) => _taskTile(tasks[i]),
      ),
    );
  }

  Widget _taskTile(TeamTask task) {
    return ListTile(
      title: Text(task.item,
          style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        'Due: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _badge(task.priority, _priorityColor(task.priority)),
          const SizedBox(height: 4),
          _badge(task.status, _statusColor(task.status)),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }

  Widget _emptyBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(text,
            style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  Color _priorityColor(String p) =>
      p == 'High' ? Colors.red :
      p == 'Medium' ? Colors.orange :
      Colors.green;

  Color _statusColor(String s) =>
      s == 'Closed' ? Colors.green :
      s == 'In Progress' ? Colors.orange :
      Colors.grey;
}

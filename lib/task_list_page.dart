import 'package:flutter/material.dart';

// Task model
class Task {
  final String id;
  final String item;
  final String priority;
  final String status;
  final String responsible;
  final DateTime dueDate;
  final String priorityColor;

  Task({
    required this.id,
    required this.item,
    required this.priority,
    required this.status,
    required this.responsible,
    required this.dueDate,
    required this.priorityColor,
  });
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // Sample tasks data
  List<Task> tasks = [
    Task(
      id: '1',
      item: 'Complete project proposal',
      priority: 'High',
      status: 'In Progress',
      responsible: 'John Doe',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priorityColor: 'red',
    ),
    Task(
      id: '2',
      item: 'Review quarterly reports',
      priority: 'Medium',
      status: 'Pending',
      responsible: 'Jane Smith',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      priorityColor: 'orange',
    ),
    Task(
      id: '3',
      item: 'Team meeting preparation',
      priority: 'Low',
      status: 'Completed',
      responsible: 'Robert Johnson',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      priorityColor: 'green',
    ),
  ];

  String? _priorityFilter;
  String? _statusFilter;
  String? _responsibleFilter;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF2D3748),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF4FD1C5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          // 📋 Task list
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                return _taskCard(_filteredTasks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HELPERS ----------------

  List<Task> get _filteredTasks {
    return tasks.where((task) {
      final search = _searchController.text.toLowerCase();

      final matchSearch = search.isEmpty ||
          task.item.toLowerCase().contains(search) ||
          task.responsible.toLowerCase().contains(search);

      final matchPriority = _priorityFilter == null || task.priority == _priorityFilter;
      final matchStatus = _statusFilter == null || task.status == _statusFilter;
      final matchResponsible =
          _responsibleFilter == null || task.responsible == _responsibleFilter;

      return matchSearch && matchPriority && matchStatus && matchResponsible;
    }).toList();
  }

  Widget _taskCard(Task task) {
    final color = _priorityColor(task.priorityColor);

    return Card(
      color: const Color(0xFF2D3748),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.item,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              _badge(task.priority, color),
            ],
          ),
          const SizedBox(height: 12),
          _infoRow('Status', task.status),
          _infoRow('Responsible', task.responsible),
          _infoRow(
            'Due',
            '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
          ),
        ]),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Color _priorityColor(String key) {
    switch (key) {
      case 'red':
        return Colors.red.shade600;
      case 'orange':
        return Colors.orange.shade600;
      case 'green':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

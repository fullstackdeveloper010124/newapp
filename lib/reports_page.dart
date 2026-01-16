import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
class TaskReport {
  final String id;
  final String taskName;
  final String assignedTo;
  final String priority;
  final String status;
  final DateTime dueDate;
  final double progress;

  TaskReport({
    required this.id,
    required this.taskName,
    required this.assignedTo,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.progress,
  });
}

class ReportMetrics {
  final int totalTasks;
  final int completed;
  final int inProgress;
  final int overdue;
  final double completionRate;

  ReportMetrics({
    required this.totalTasks,
    required this.completed,
    required this.inProgress,
    required this.overdue,
    required this.completionRate,
  });
}

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String _reportType = 'Summary Report';
  String _statusFilter = 'All Statuses';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  ReportMetrics reportMetrics = ReportMetrics(
    totalTasks: 42,
    completed: 28,
    inProgress: 10,
    overdue: 4,
    completionRate: 66.7,
  );

  List<TaskReport> taskDetails = [
    TaskReport(
      id: 'T001',
      taskName: 'Project Planning',
      assignedTo: 'Alice Johnson',
      priority: 'High',
      status: 'Completed',
      dueDate: DateTime.now().subtract(const Duration(days: 5)),
      progress: 100,
    ),
    TaskReport(
      id: 'T002',
      taskName: 'UI Design',
      assignedTo: 'Bob Smith',
      priority: 'High',
      status: 'In Progress',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      progress: 75,
    ),
    TaskReport(
      id: 'T003',
      taskName: 'API Development',
      assignedTo: 'David Wilson',
      priority: 'High',
      status: 'Overdue',
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      progress: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Report Filters'),
            _filterSection(),
            const SizedBox(height: 24),

            _sectionTitle('Report Metrics'),
            _metricsSection(),
            const SizedBox(height: 24),

            _sectionTitle('Task Details Report'),
            _taskTable(),
          ],
        ),
      ),
    );
  }

  // ---------------- UI PARTS ----------------

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

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _filterSection() {
    return _card(
      Column(
        children: [
          _dropdown('Report Type', _reportType,
              ['Summary Report', 'Detailed Analysis', 'Team Performance'],
              (v) => setState(() => _reportType = v)),
          const SizedBox(height: 12),
          _dropdown('Status Filter', _statusFilter,
              ['All Statuses', 'Completed', 'In Progress', 'Overdue'],
              (v) => setState(() => _statusFilter = v)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _dateField('Start Date', _startDate, _pickStart)),
              const SizedBox(width: 12),
              Expanded(child: _dateField('End Date', _endDate, _pickEnd)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, Function(String) onChange) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: const Color(0xFF2D3748),
      style: const TextStyle(color: Colors.white),
      decoration: _input(label),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => onChange(v!),
    );
  }

  Widget _dateField(String label, DateTime date, VoidCallback onTap) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: DateFormat('dd/MM/yyyy').format(date)),
      decoration: _input(label, icon: Icons.calendar_today),
      onTap: onTap,
    );
  }

  Widget _metricsSection() {
    return _card(
      Column(
        children: [
          Row(
            children: [
              Expanded(child: _metric('Total', reportMetrics.totalTasks, Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _metric('Completed', reportMetrics.completed, Colors.green)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: reportMetrics.completionRate / 100,
            minHeight: 8,
            backgroundColor: Colors.grey.shade800,
            valueColor: const AlwaysStoppedAnimation(Color(0xFF4FD1C5)),
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, int value, Color color) {
    return Column(
      children: [
        Text('$value', style: const TextStyle(color: Colors.white, fontSize: 20)),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _taskTable() {
    return _card(
      Column(
        children: taskDetails.map((t) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(child: Text(t.id, style: _cell())),
                Expanded(flex: 2, child: Text(t.taskName, style: _cell())),
                Expanded(child: Text(t.status, style: _cell())),
                Expanded(child: Text('${t.progress.toInt()}%', style: _cell())),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  TextStyle _cell() => const TextStyle(color: Colors.white, fontSize: 12);

  InputDecoration _input(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF4FD1C5)),
      prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF4FD1C5)) : null,
      filled: true,
      fillColor: const Color(0xFF1A1F26),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  // ---------------- DATE PICKERS ----------------

  void _pickStart() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (d != null) setState(() => _startDate = d);
  }

  void _pickEnd() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d != null) setState(() => _endDate = d);
  }
}

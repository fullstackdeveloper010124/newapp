import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';

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
  
  // Sample report metrics
  ReportMetrics reportMetrics = ReportMetrics(
    totalTasks: 42,
    completed: 28,
    inProgress: 10,
    overdue: 4,
    completionRate: 66.7,
  );
  
  // Sample task details
  List<TaskReport> taskDetails = [
    TaskReport(
      id: 'T001',
      taskName: 'Project Planning',
      assignedTo: 'Alice Johnson',
      priority: 'High',
      status: 'Completed',
      dueDate: DateTime.now().subtract(const Duration(days: 5)),
      progress: 100.0,
    ),
    TaskReport(
      id: 'T002',
      taskName: 'UI Design',
      assignedTo: 'Bob Smith',
      priority: 'High',
      status: 'In Progress',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      progress: 75.0,
    ),
    TaskReport(
      id: 'T003',
      taskName: 'Database Setup',
      assignedTo: 'Carol Davis',
      priority: 'Medium',
      status: 'In Progress',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      progress: 40.0,
    ),
    TaskReport(
      id: 'T004',
      taskName: 'API Development',
      assignedTo: 'David Wilson',
      priority: 'High',
      status: 'Overdue',
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      progress: 30.0,
    ),
    TaskReport(
      id: 'T005',
      taskName: 'Testing',
      assignedTo: 'Emma Thompson',
      priority: 'Medium',
      status: 'Completed',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      progress: 100.0,
    ),
    TaskReport(
      id: 'T006',
      taskName: 'Documentation',
      assignedTo: 'Frank Miller',
      priority: 'Low',
      status: 'In Progress',
      dueDate: DateTime.now().add(const Duration(days: 10)),
      progress: 15.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: 'Reports',
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
          IconButton(
            icon: const Icon(
              Icons.picture_as_pdf,
              color: Color(0xFF4FD1C5),
            ),
            onPressed: () {
              _exportPDF();
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
              // Report Filters
              _buildSectionHeader('Report Filters'),
              const SizedBox(height: 16),
              _buildFilterSection(),
              
              const SizedBox(height: 24),
              
              // Report Metrics
              _buildSectionHeader('Report Metrics'),
              const SizedBox(height: 16),
              _buildReportMetrics(),
              
              const SizedBox(height: 24),
              
              // Task Details Report
              _buildSectionHeader('Task Details Report'),
              const SizedBox(height: 16),
              _buildTaskDetailsReport(),
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

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Report Type Dropdown
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: DropdownButtonFormField<String>(
              initialValue: _reportType,
              decoration: const InputDecoration(
                labelText: 'Report Type',
                labelStyle: TextStyle(color: Color(0xFF4FD1C5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                filled: true,
                fillColor: Color(0xFF1A1F26),
              ),
              dropdownColor: const Color(0xFF2D3748),
              style: const TextStyle(color: Colors.white),
              items: ['Summary Report', 'Detailed Analysis', 'Team Performance']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _reportType = newValue!;
                });
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Status Filter Dropdown
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: DropdownButtonFormField<String>(
              initialValue: _statusFilter,
              decoration: const InputDecoration(
                labelText: 'Status Filter',
                labelStyle: TextStyle(color: Color(0xFF4FD1C5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                filled: true,
                fillColor: Color(0xFF1A1F26),
              ),
              dropdownColor: const Color(0xFF2D3748),
              style: const TextStyle(color: Colors.white),
              items: ['All Statuses', 'Closed', 'In Progress', 'No Action Yet', 'Overdue']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _statusFilter = newValue!;
                });
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Date Range Picker
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  'Start Date',
                  _startDate,
                  _selectStartDate,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateField(
                  'End Date',
                  _endDate,
                  _selectEndDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime date, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        readOnly: true,
        controller: TextEditingController(text: DateFormat('dd/MM/yyyy').format(date)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF4FD1C5)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          filled: true,
          fillColor: const Color(0xFF1A1F26),
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: Color(0xFF4FD1C5),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildReportMetrics() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Metrics row 1
          Row(
            children: [
              Expanded(
                child: _buildMetricCard('Total Tasks', reportMetrics.totalTasks.toString(), Colors.blue.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard('Completed', reportMetrics.completed.toString(), Colors.green.shade600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Metrics row 2
          Row(
            children: [
              Expanded(
                child: _buildMetricCard('In Progress', reportMetrics.inProgress.toString(), Colors.orange.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard('Overdue', reportMetrics.overdue.toString(), Colors.red.shade600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Completion Rate
          _buildCompletionRateCard(),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
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

  Widget _buildCompletionRateCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            '${reportMetrics.completionRate.toStringAsFixed(1)}%',
            style: const TextStyle(
              color: Color(0xFF4FD1C5),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Completion Rate',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: reportMetrics.completionRate / 100,
            backgroundColor: Colors.grey.shade800,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4FD1C5)),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDetailsReport() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1F26),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(flex: 1, child: _buildTableHeaderText('ID')),
                Expanded(flex: 2, child: _buildTableHeaderText('Task Name')),
                Expanded(flex: 2, child: _buildTableHeaderText('Assigned To')),
                Expanded(flex: 1, child: _buildTableHeaderText('Priority')),
                Expanded(flex: 1, child: _buildTableHeaderText('Status')),
                Expanded(flex: 1, child: _buildTableHeaderText('Due Date')),
                Expanded(flex: 1, child: _buildTableHeaderText('Progress')),
              ],
            ),
          ),
          // Table rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskDetails.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFF1A1F26)),
            itemBuilder: (context, index) {
              final task = taskDetails[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: _buildTableCellText(task.id)),
                    Expanded(flex: 2, child: _buildTableCellText(task.taskName)),
                    Expanded(flex: 2, child: _buildTableCellText(task.assignedTo)),
                    Expanded(flex: 1, child: _buildPriorityBadge(task.priority)),
                    Expanded(flex: 1, child: _buildStatusBadge(task.status)),
                    Expanded(flex: 1, child: _buildTableCellText(DateFormat('dd/MM').format(task.dueDate))),
                    Expanded(flex: 1, child: _buildProgressIndicator(task.progress)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF4FD1C5),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }

  Widget _buildTableCellText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.red.shade600;
        break;
      case 'Medium':
        color = Colors.orange.shade600;
        break;
      case 'Low':
        color = Colors.green.shade600;
        break;
      default:
        color = Colors.grey.shade600;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Completed':
        color = Colors.green.shade600;
        break;
      case 'In Progress':
        color = Colors.orange.shade600;
        break;
      case 'Overdue':
        color = Colors.red.shade600;
        break;
      case 'No Action Yet':
        color = Colors.grey.shade600;
        break;
      default:
        color = Colors.blue.shade600;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(double progress) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Container(
            width: 40,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            width: 40 * (progress / 100),
            height: 10,
            decoration: BoxDecoration(
              color: progress >= 100 ? Colors.green.shade600 : const Color(0xFF4FD1C5),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  void _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _exportPDF() {
    // Show a snackbar indicating the PDF export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exporting PDF report...'),
        duration: Duration(seconds: 2),
      ),
    );
    
    // In a real implementation, this would generate and export the PDF
    // For now, we're just showing a notification
  }
}
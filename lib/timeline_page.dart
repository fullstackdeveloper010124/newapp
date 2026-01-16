import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// Task model for timeline
class TimelineTask {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String priority;
  final String assignee;

  TimelineTask({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.priority,
    required this.assignee,
  });
}

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final List<TimelineTask> timelineTasks = [
    TimelineTask(
      id: '1',
      title: 'Project Kickoff',
      description: 'Initial meeting',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().subtract(const Duration(days: 4)),
      status: 'Completed',
      priority: 'High',
      assignee: 'John Doe',
    ),
    TimelineTask(
      id: '2',
      title: 'Design Phase',
      description: 'UI/UX design',
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      endDate: DateTime.now().add(const Duration(days: 7)),
      status: 'In Progress',
      priority: 'High',
      assignee: 'Jane Smith',
    ),
    TimelineTask(
      id: '3',
      title: 'Development',
      description: 'Development work',
      startDate: DateTime.now().add(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 20)),
      status: 'Scheduled',
      priority: 'Medium',
      assignee: 'Robert Johnson',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 📅 Calendar
          _calendar(),

          const SizedBox(height: 24),

          _sectionTitle('This Week'),
          const SizedBox(height: 12),
          _taskList(_thisWeekTasks()),

          const SizedBox(height: 24),

          _sectionTitle('Upcoming'),
          const SizedBox(height: 12),
          _taskList(_upcomingTasks()),
        ]),
      ),
    );
  }

  // ---------------- UI ----------------

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

  Widget _calendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2020),
        lastDay: DateTime.utc(2030),
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (d, f) => setState(() {
          _selectedDay = d;
          _focusedDay = f;
        }),
        onFormatChanged: (f) => setState(() => _calendarFormat = f),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Color(0xFF4FD1C5),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: TextStyle(color: Colors.white),
          weekendTextStyle: TextStyle(color: Colors.white70),
        ),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(color: Colors.white),
          leftChevronIcon:
              Icon(Icons.chevron_left, color: Color(0xFF4FD1C5)),
          rightChevronIcon:
              Icon(Icons.chevron_right, color: Color(0xFF4FD1C5)),
        ),
      ),
    );
  }

  Widget _taskList(List<TimelineTask> tasks) {
    if (tasks.isEmpty) {
      return _emptyBox('No tasks found');
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
        itemBuilder: (_, i) {
          final t = tasks[i];
          return ListTile(
            title: Text(t.title,
                style: const TextStyle(color: Colors.white)),
            subtitle: Text(
              '${_fmt(t.startDate)} - ${_fmt(t.endDate)} | ${t.assignee}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: _badge(t.status, _statusColor(t.status)),
          );
        },
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 11)),
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

  // ---------------- DATA ----------------

  List<TimelineTask> _thisWeekTasks() {
    final now = DateTime.now();
    return timelineTasks
        .where((t) =>
            t.startDate.isBefore(now.add(const Duration(days: 7))) &&
            t.endDate.isAfter(now))
        .toList();
  }

  List<TimelineTask> _upcomingTasks() {
    return timelineTasks
        .where((t) => t.startDate.isAfter(DateTime.now()))
        .toList();
  }

  Color _statusColor(String s) =>
      s == 'Completed'
          ? Colors.green
          : s == 'In Progress'
              ? Colors.orange
              : Colors.blue;

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
}

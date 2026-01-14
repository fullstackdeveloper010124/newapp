import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';

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
  // Calendar state
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  
  // Sample timeline tasks
  List<TimelineTask> timelineTasks = [
    TimelineTask(
      id: '1',
      title: 'Project Kickoff',
      description: 'Initial project meeting and planning',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().subtract(const Duration(days: 4)),
      status: 'Completed',
      priority: 'High',
      assignee: 'John Doe',
    ),
    TimelineTask(
      id: '2',
      title: 'Design Phase',
      description: 'UI/UX design and prototyping',
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      endDate: DateTime.now().add(const Duration(days: 7)),
      status: 'In Progress',
      priority: 'High',
      assignee: 'Jane Smith',
    ),
    TimelineTask(
      id: '3',
      title: 'Development',
      description: 'Backend and frontend development',
      startDate: DateTime.now().add(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 20)),
      status: 'Scheduled',
      priority: 'Medium',
      assignee: 'Robert Johnson',
    ),
    TimelineTask(
      id: '4',
      title: 'Testing',
      description: 'Quality assurance and bug fixes',
      startDate: DateTime.now().add(const Duration(days: 18)),
      endDate: DateTime.now().add(const Duration(days: 25)),
      status: 'Scheduled',
      priority: 'Medium',
      assignee: 'Emily Davis',
    ),
    TimelineTask(
      id: '5',
      title: 'Deployment',
      description: 'Production deployment',
      startDate: DateTime.now().add(const Duration(days: 24)),
      endDate: DateTime.now().add(const Duration(days: 26)),
      status: 'Scheduled',
      priority: 'High',
      assignee: 'Michael Wilson',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: 'Timeline & Schedule',
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
              // Month/Year selector with calendar view
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3748),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF4FD1C5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1F26),
                    ),
                    defaultTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Color(0xFF4FD1C5),
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Color(0xFF4FD1C5),
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: TextStyle(
                      color: Colors.white38,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // This Week Section
              _buildSectionHeader('This Week'),
              const SizedBox(height: 12),
              _buildThisWeekTasks(),
              
              const SizedBox(height: 24),
              
              // Upcoming Section
              _buildSectionHeader('Upcoming'),
              const SizedBox(height: 12),
              _buildUpcomingTasks(),
              
              const SizedBox(height: 24),
              
              // Overdue Section
              _buildSectionHeader('Overdue'),
              const SizedBox(height: 12),
              _buildOverdueTasks(),
              
              const SizedBox(height: 24),
              
              // Upcoming Deadlines Section
              _buildSectionHeader('Upcoming Deadlines'),
              const SizedBox(height: 12),
              _buildUpcomingDeadlines(),
              
              const SizedBox(height: 24),
              
              // Task Timeline (Gantt) Section
              _buildSectionHeader('Task Timeline (Gantt)'),
              const SizedBox(height: 12),
              _buildGanttChart(),
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

  Widget _buildThisWeekTasks() {
    final thisWeekTasks = timelineTasks.where((task) {
      final now = DateTime.now();
      final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
      final endOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day + 6);
      return (task.startDate.isAfter(startOfWeek) || isSameDay(task.startDate, startOfWeek)) &&
             (task.startDate.isBefore(endOfWeek) || isSameDay(task.startDate, endOfWeek));
    }).toList();

    if (thisWeekTasks.isEmpty) {
      return _buildEmptySection('No tasks scheduled for this week');
    }

    return _buildTaskList(thisWeekTasks);
  }

  Widget _buildUpcomingTasks() {
    final upcomingTasks = timelineTasks.where((task) {
      return task.startDate.isAfter(DateTime.now());
    }).toList();

    if (upcomingTasks.isEmpty) {
      return _buildEmptySection('No upcoming tasks');
    }

    return _buildTaskList(upcomingTasks);
  }

  Widget _buildOverdueTasks() {
    final overdueTasks = timelineTasks.where((task) {
      return task.endDate.isBefore(DateTime.now()) && task.status != 'Completed';
    }).toList();

    if (overdueTasks.isEmpty) {
      return _buildEmptySection('No overdue tasks');
    }

    return _buildTaskList(overdueTasks);
  }

  Widget _buildUpcomingDeadlines() {
    final deadlineTasks = timelineTasks.where((task) {
      final nextWeek = DateTime.now().add(const Duration(days: 7));
      return task.endDate.isAfter(DateTime.now()) && 
             (task.endDate.isBefore(nextWeek) || isSameDay(task.endDate, nextWeek)) &&
             task.status != 'Completed';
    }).toList();

    if (deadlineTasks.isEmpty) {
      return _buildEmptySection('No upcoming deadlines');
    }

    return _buildTaskList(deadlineTasks);
  }

  Widget _buildTaskList(List<TimelineTask> tasks) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasks.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFF1A1F26)),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              task.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '${_formatDate(task.startDate)} - ${_formatDate(task.endDate)} | ${task.assignee}',
              style: const TextStyle(
                color: Colors.grey,
              ),
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

  Widget _buildEmptySection(String message) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildGanttChart() {
    // Simple representation of a Gantt chart
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: timelineTasks.map((task) {
          final duration = task.endDate.difference(task.startDate).inDays;
          final progress = task.status == 'Completed' ? 1.0 : 
                           task.status == 'In Progress' ? 0.6 : 0.0;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
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
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        _formatDate(task.startDate),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.6 * progress,
                            decoration: BoxDecoration(
                              color: _getPriorityColor(task.priority),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        _formatDate(task.endDate),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green.shade600;
      case 'In Progress':
        return Colors.orange.shade600;
      case 'Overdue':
        return Colors.red.shade600;
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
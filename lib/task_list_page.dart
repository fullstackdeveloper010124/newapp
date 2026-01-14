import 'package:flutter/material.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';

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
    Task(
      id: '4',
      item: 'Client presentation',
      priority: 'High',
      status: 'Blocked',
      responsible: 'Emily Davis',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      priorityColor: 'red',
    ),
    Task(
      id: '5',
      item: 'Software update',
      priority: 'Medium',
      status: 'In Review',
      responsible: 'Michael Wilson',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priorityColor: 'orange',
    ),
  ];

  // Filter values
  String? _priorityFilter;
  String? _statusFilter;
  String? _responsibleFilter;

  // Controllers
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: 'Task List',
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
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF2D3748),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF4FD1C5),
                  ),
                ),
                onChanged: (value) {
                  // Handle search filtering
                },
              ),
            ),
            
            // Task list
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Simulate refresh
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: _filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = _filteredTasks[index];
                    return _buildTaskCard(task);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddTaskModal();
        },
        backgroundColor: const Color(0xFF4FD1C5),
        foregroundColor: const Color(0xFF1A1F26),
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<Task> get _filteredTasks {
    return tasks.where((task) {
      bool matchesPriority = _priorityFilter == null || task.priority == _priorityFilter;
      bool matchesStatus = _statusFilter == null || task.status == _statusFilter;
      bool matchesResponsible = _responsibleFilter == null || task.responsible == _responsibleFilter;
      
      return matchesPriority && matchesStatus && matchesResponsible;
    }).toList();
  }

  Widget _buildTaskCard(Task task) {
    Color priorityColor;
    switch (task.priorityColor) {
      case 'red':
        priorityColor = Colors.red.shade600;
        break;
      case 'orange':
        priorityColor = Colors.orange.shade600;
        break;
      case 'green':
        priorityColor = Colors.green.shade600;
        break;
      default:
        priorityColor = Colors.grey.shade600;
    }

    return Card(
      color: const Color(0xFF2D3748),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: priorityColor,
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.item,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.priority,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoRow('Status', task.status),
                ),
                Expanded(
                  child: _buildInfoRow('Responsible', task.responsible),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildInfoRow('Due Date', '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}'),
                ),
                _buildActionButtons(task),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Task task) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Color(0xFF4FD1C5)),
      onSelected: (String result) {
        if (result == 'edit') {
          _showEditTaskModal(task);
        } else if (result == 'delete') {
          _deleteTask(task);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit'),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2D3748),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Filters',
                              style: TextStyle(
                                color: Color(0xFF4FD1C5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Priority filter
                        const Text(
                          'Priority',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _priorityFilter,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF1A1F26),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          dropdownColor: const Color(0xFF1A1F26),
                          style: const TextStyle(color: Colors.white),
                          hint: const Text('Select priority', style: TextStyle(color: Colors.grey)),
                          items: ['High', 'Medium', 'Low']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _priorityFilter = newValue;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Status filter
                        const Text(
                          'Status',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _statusFilter,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF1A1F26),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          dropdownColor: const Color(0xFF1A1F26),
                          style: const TextStyle(color: Colors.white),
                          hint: const Text('Select status', style: TextStyle(color: Colors.grey)),
                          items: ['Pending', 'In Progress', 'In Review', 'Completed', 'Blocked']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _statusFilter = newValue;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Responsible filter
                        const Text(
                          'Responsible',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _responsibleFilter,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF1A1F26),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          dropdownColor: const Color(0xFF1A1F26),
                          style: const TextStyle(color: Colors.white),
                          hint: const Text('Select responsible', style: TextStyle(color: Colors.grey)),
                          items: ['All', 'John Doe', 'Jane Smith', 'Robert Johnson', 'Emily Davis', 'Michael Wilson']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value == 'All' ? null : value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _responsibleFilter = newValue == 'All' ? null : newValue;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Apply filters button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4FD1C5),
                            foregroundColor: const Color(0xFF1A1F26),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Apply Filters',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        // Reset filters button
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _priorityFilter = null;
                              _statusFilter = null;
                              _responsibleFilter = null;
                            });
                          },
                          child: const Text(
                            'Reset Filters',
                            style: TextStyle(
                              color: Color(0xFF4FD1C5),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddTaskModal() {
    // For now, just show a simple dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D3748),
          title: const Text(
            'Add New Task',
            style: TextStyle(color: Color(0xFF4FD1C5)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This is where you would add a new task.',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Here you would typically navigate to a task creation form
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4FD1C5),
                  foregroundColor: const Color(0xFF1A1F26),
                ),
                child: const Text('Create Task'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskModal(Task task) {
    // For now, just show a simple dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D3748),
          title: const Text(
            'Edit Task',
            style: TextStyle(color: Color(0xFF4FD1C5)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Editing task: ${task.item}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Here you would typically navigate to a task editing form
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4FD1C5),
                  foregroundColor: const Color(0xFF1A1F26),
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D3748),
          title: const Text(
            'Delete Task',
            style: TextStyle(color: Color(0xFF4FD1C5)),
          ),
          content: Text(
            'Are you sure you want to delete "${task.item}"?',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.remove(task);
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';

// Models
class Remark {
  final String id;
  final String user;
  final String content;
  final DateTime timestamp;
  final String status;
  final List<String> contributors;

  Remark({
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
    required this.status,
    required this.contributors,
  });
}

class Contributor {
  final String name;
  final int contributionCount;

  Contributor({
    required this.name,
    required this.contributionCount,
  });
}

class RemarksPage extends StatefulWidget {
  const RemarksPage({super.key});

  @override
  State<RemarksPage> createState() => _RemarksPageState();
}

class _RemarksPageState extends State<RemarksPage> {
  String _selectedUser = 'All Users';
  String _searchQuery = '';
  
  // Sample remarks data
  List<Remark> remarks = [
    Remark(
      id: '1',
      user: 'Alice Johnson',
      content: 'The initial design needs some adjustments based on client feedback',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'Active',
      contributors: ['Alice Johnson', 'Bob Smith'],
    ),
    Remark(
      id: '2',
      user: 'Bob Smith',
      content: 'Fixed the login issue reported yesterday',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      status: 'Resolved',
      contributors: ['Bob Smith'],
    ),
    Remark(
      id: '3',
      user: 'Carol Davis',
      content: 'Need to optimize the database queries for better performance',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Active',
      contributors: ['Carol Davis', 'David Wilson', 'Emma Thompson'],
    ),
    Remark(
      id: '4',
      user: 'David Wilson',
      content: 'Updated the documentation for the new API endpoints',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Resolved',
      contributors: ['David Wilson', 'Alice Johnson'],
    ),
    Remark(
      id: '5',
      user: 'Emma Thompson',
      content: 'Consider implementing caching mechanism for faster response times',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      status: 'Active',
      contributors: ['Emma Thompson', 'Bob Smith', 'Carol Davis'],
    ),
  ];
  
  // Sample contributors data
  List<Contributor> contributors = [
    Contributor(name: 'Alice Johnson', contributionCount: 12),
    Contributor(name: 'Bob Smith', contributionCount: 8),
    Contributor(name: 'Carol Davis', contributionCount: 15),
    Contributor(name: 'David Wilson', contributionCount: 6),
    Contributor(name: 'Emma Thompson', contributionCount: 10),
  ];

  // Controllers
  final TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: 'Remarks',
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
              // Add New Remark section
              _buildAddRemarkSection(),
              
              const SizedBox(height: 24),
              
              // Stats section
              _buildStatsSection(),
              
              const SizedBox(height: 24),
              
              // Filters and search
              _buildFiltersSection(),
              
              const SizedBox(height: 24),
              
              // Communication Timeline
              _buildSectionHeader('Communication Timeline'),
              const SizedBox(height: 12),
              _buildCommunicationTimeline(),
              
              const SizedBox(height: 24),
              
              // Contribution Overview
              _buildSectionHeader('Contribution Overview'),
              const SizedBox(height: 12),
              _buildContributionOverview(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddRemarkSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TextField(
            controller: _remarkController,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Add a new remark...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF1A1F26),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                _addNewRemark();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FD1C5),
                foregroundColor: const Color(0xFF1A1F26),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add Remark',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    int totalRemarks = remarks.length;
    int activeTasks = remarks.where((remark) => remark.status == 'Active').length;
    int resolved = remarks.where((remark) => remark.status == 'Resolved').length;
    int totalContributors = contributors.length;

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
                child: _buildStatItem('Total Remarks', totalRemarks.toString(), Colors.blue.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatItem('Active', activeTasks.toString(), Colors.orange.shade600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Resolved', resolved.toString(), Colors.green.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatItem('Contributors', totalContributors.toString(), Colors.purple.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // User filter dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<String>(
              initialValue: _selectedUser,
              decoration: const InputDecoration(
                labelText: 'Filter by User',
                labelStyle: TextStyle(color: Color(0xFF4FD1C5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                filled: true,
                fillColor: Color(0xFF1A1F26),
              ),
              dropdownColor: const Color(0xFF2D3748),
              style: const TextStyle(color: Colors.white),
              items: ['All Users', 'Alice Johnson', 'Bob Smith', 'Carol Davis', 'David Wilson', 'Emma Thompson']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUser = newValue!;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          // Search remarks
          TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search remarks...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF1A1F26),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF4FD1C5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationTimeline() {
    final filteredRemarks = _getFilteredRemarks();

    if (filteredRemarks.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2D3748),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'No remarks found',
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
        itemCount: filteredRemarks.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFF1A1F26)),
        itemBuilder: (context, index) {
          final remark = filteredRemarks[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF4FD1C5),
              child: Text(
                remark.user.substring(0, 1),
                style: const TextStyle(
                  color: Color(0xFF1A1F26),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Row(
              children: [
                Text(
                  remark.user,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(remark.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    remark.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  remark.content,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDateTime(remark.timestamp),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: Text(
              '${remark.contributors.length} contributors',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContributionOverview() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: contributors.map((contributor) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4FD1C5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      contributor.name.substring(0, 1),
                      style: const TextStyle(
                        color: Color(0xFF1A1F26),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    contributor.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  '${contributor.contributionCount} remarks',
                  style: const TextStyle(
                    color: Color(0xFF4FD1C5),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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

  Widget _buildStatItem(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12.0),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<Remark> _getFilteredRemarks() {
    return remarks.where((remark) {
      bool matchesUser = _selectedUser == 'All Users' || remark.user == _selectedUser;
      bool matchesSearch = _searchQuery.isEmpty || 
          remark.content.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          remark.user.toLowerCase().contains(_searchQuery.toLowerCase());
      
      return matchesUser && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.orange.shade600;
      case 'Resolved':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  void _addNewRemark() {
    if (_remarkController.text.trim().isEmpty) return;

    setState(() {
      remarks.insert(0, Remark(
        id: (remarks.length + 1).toString(),
        user: 'Current User', // In a real app, this would be the logged-in user
        content: _remarkController.text.trim(),
        timestamp: DateTime.now(),
        status: 'Active',
        contributors: ['Current User'],
      ));
      _remarkController.clear();
    });
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }
}
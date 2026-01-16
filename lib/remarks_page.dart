import 'package:flutter/material.dart';

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

  final TextEditingController _remarkController = TextEditingController();

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
  ];

  List<Contributor> contributors = [
    Contributor(name: 'Alice Johnson', contributionCount: 12),
    Contributor(name: 'Bob Smith', contributionCount: 8),
    Contributor(name: 'Carol Davis', contributionCount: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F26),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddRemarkSection(),
              const SizedBox(height: 24),

              _buildStatsSection(),
              const SizedBox(height: 24),

              _buildFiltersSection(),
              const SizedBox(height: 24),

              _buildSectionHeader('Communication Timeline'),
              const SizedBox(height: 12),
              _buildCommunicationTimeline(),

              const SizedBox(height: 24),
              _buildSectionHeader('Contribution Overview'),
              const SizedBox(height: 12),
              _buildContributionOverview(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- UI SECTIONS ----------------

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

  Widget _buildAddRemarkSection() {
    return _card(
      Column(
        children: [
          TextField(
            controller: _remarkController,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Add a new remark...'),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _addNewRemark,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FD1C5),
                foregroundColor: const Color(0xFF1A1F26),
              ),
              child: const Text('Add Remark'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return _card(
      Row(
        children: [
          Expanded(child: _stat('Total', remarks.length, Colors.blue)),
          const SizedBox(width: 12),
          Expanded(child: _stat('Active', remarks.where((e) => e.status == 'Active').length, Colors.orange)),
          const SizedBox(width: 12),
          Expanded(child: _stat('Resolved', remarks.where((e) => e.status == 'Resolved').length, Colors.green)),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return _card(
      Column(
        children: [
          DropdownButtonFormField<String>(
            value: _selectedUser,
            dropdownColor: const Color(0xFF2D3748),
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Filter by User'),
            items: ['All Users', 'Alice Johnson', 'Bob Smith']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _selectedUser = v!),
          ),
          const SizedBox(height: 12),
          TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Search remarks', icon: Icons.search),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationTimeline() {
    final list = _getFilteredRemarks();

    if (list.isEmpty) {
      return _card(
        const Center(
          child: Text(
            'No remarks found',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return _card(
      Column(
        children: list.map((r) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF4FD1C5),
              child: Text(r.user[0], style: const TextStyle(color: Colors.black)),
            ),
            title: Text(r.user, style: const TextStyle(color: Colors.white)),
            subtitle: Text(r.content, style: const TextStyle(color: Colors.white70)),
            trailing: Text(
              r.status,
              style: TextStyle(color: _getStatusColor(r.status)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContributionOverview() {
    return _card(
      Column(
        children: contributors.map((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF4FD1C5),
                  child: Text(c.name[0], style: const TextStyle(color: Colors.black)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(c.name, style: const TextStyle(color: Colors.white)),
                ),
                Text(
                  '${c.contributionCount}',
                  style: const TextStyle(color: Color(0xFF4FD1C5)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _stat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF4FD1C5)) : null,
      filled: true,
      fillColor: const Color(0xFF1A1F26),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  List<Remark> _getFilteredRemarks() {
    return remarks.where((r) {
      final userOk = _selectedUser == 'All Users' || r.user == _selectedUser;
      final searchOk =
          _searchQuery.isEmpty || r.content.toLowerCase().contains(_searchQuery.toLowerCase());
      return userOk && searchOk;
    }).toList();
  }

  Color _getStatusColor(String status) {
    return status == 'Active' ? Colors.orange : Colors.green;
  }

  void _addNewRemark() {
    if (_remarkController.text.isEmpty) return;

    setState(() {
      remarks.insert(
        0,
        Remark(
          id: DateTime.now().toString(),
          user: 'Current User',
          content: _remarkController.text,
          timestamp: DateTime.now(),
          status: 'Active',
          contributors: ['Current User'],
        ),
      );
      _remarkController.clear();
    });
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }
}

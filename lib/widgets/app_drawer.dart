import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onLogout;
  final String userName;
  final String userEmail;

  const AppDrawer({
    Key? key,
    required this.onLogout,
    this.userName = 'User',
    this.userEmail = 'user@example.com',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1F26),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF2D3748),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FD1C5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                    color: Color(0xFF1A1F26),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userEmail,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation items
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          _buildDrawerItem(
            icon: Icons.list_alt,
            title: 'Task List',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/task-list');
            },
          ),
          _buildDrawerItem(
            icon: Icons.insights,
            title: 'Status Insights',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/status-insights');
            },
          ),
          _buildDrawerItem(
            icon: Icons.timeline,
            title: 'Timeline',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/timeline');
            },
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: 'Team View',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/team-view');
            },
          ),
          _buildDrawerItem(
            icon: Icons.comment,
            title: 'Remarks',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/remarks');
            },
          ),
          _buildDrawerItem(
            icon: Icons.bar_chart,
            title: 'Reports',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/reports');
            },
          ),
          
          const Divider(
            color: Color(0xFF2D3748),
            thickness: 1,
          ),
          
          // Logout option
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF4FD1C5),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
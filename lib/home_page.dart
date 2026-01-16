import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'task_list_page.dart';
import 'status_insights_page.dart';
import 'timeline_page.dart';
import 'reports_page.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/app_drawer.dart';
import 'widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    TaskListPage(),
    StatusInsightsPage(),
    TimelinePage(),
    ReportsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1A1F26),
      appBar: CustomAppBar(
        title: _getTitle(_selectedIndex),
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      drawer: AppDrawer(
        userName: 'John Doe',
        userEmail: 'john.doe@example.com',
        onLogout: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        },
      ),
      body: _pages[_selectedIndex], // ✅ NO Center()
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Task List';
      case 2:
        return 'Status Insights';
      case 3:
        return 'Timeline';
      case 4:
        return 'Reports';
      default:
        return 'Dashboard';
    }
  }
}

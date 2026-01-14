import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A1F26),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Color(0xFF4FD1C5),
          size: 28,
        ),
        onPressed: onMenuPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF4FD1C5),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        // Additional actions passed in as a parameter
        if (actions != null) ...actions!,
        // Notification icon
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Color(0xFF4FD1C5),
            size: 24,
          ),
          onPressed: onNotificationPressed ?? () {},
        ),
        // Profile icon
        IconButton(
          icon: const Icon(
            Icons.account_circle,
            color: Color(0xFF4FD1C5),
            size: 28,
          ),
          onPressed: onProfilePressed ?? () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
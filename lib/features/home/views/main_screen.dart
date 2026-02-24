import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/features/chat/views/chat_screen.dart';
import 'package:docai_assistant/features/document/views/empty_document_screen.dart';
import 'package:docai_assistant/features/home/views/home_screen.dart';
import 'package:docai_assistant/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    EmptyDocumentsScreen(),
    ChatScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(child: _screens[_currentIndex]),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },

        height: 72,
        // backgroundColor: const Color(0xFF171A21),
        backgroundColor: AppColors.textLight,
        // dark card
        indicatorColor: AppColors.primary.withOpacity(0.15),

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.document_scanner),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Document',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.stars),
            label: 'AI Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

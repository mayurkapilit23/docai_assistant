import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/features/chat/bloc/chat_bloc.dart';
import 'package:docai_assistant/features/chat/data/repo/chat_repo.dart';
import 'package:docai_assistant/features/chat/views/chat_screen.dart';
import 'package:docai_assistant/features/document/views/empty_document_screen.dart';
import 'package:docai_assistant/features/home/views/home_screen.dart';
import 'package:docai_assistant/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    EmptyDocumentsScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // body: SafeArea(child: _screens[_currentIndex]),
      body: IndexedStack(index: _currentIndex, children: _screens),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },

        height: 72,
        backgroundColor: Theme.of(context).cardColor,
        // backgroundColor: AppColors.textLight,
        indicatorColor: AppColors.primary.withOpacity(0.15),

        destinations: [
          const NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: AppColors.primary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedDocumentAttachment),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedDocumentAttachment,
              color: AppColors.primary,
            ),
            label: 'Document',
          ),
          const NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedStars),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedStars,
              color: AppColors.primary,
            ),
            label: 'AI Chat',
          ),
          const NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedSettings01),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedSettings01,
              color: AppColors.primary,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

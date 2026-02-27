import 'package:docai_assistant/core/theme/app_theme.dart';
import 'package:docai_assistant/features/chat/data/repo/chat_repo.dart';
import 'package:docai_assistant/features/home/views/main_screen.dart';
import 'package:docai_assistant/features/theme/bloc/theme_bloc.dart';
import 'package:docai_assistant/features/theme/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/chat/bloc/chat_bloc.dart';
import 'features/theme/bloc/theme_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChatBloc(ChatRepo())),
        BlocProvider(create: (_) => ThemeBloc()..add(LoadThemeEvent())),
      ],
      child: const AppView(),
    );
  }
}

// Separate widget for rebuild optimization
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,

          home: const MainScreen(),
        );
      },
    );
  }
}

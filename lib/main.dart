import 'package:docai_assistant/features/onboarding/views/doc_ai_loading_screen.dart';
import 'package:flutter/material.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized(); // ✅ REQUIRED
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),

      home: const DocAiLoadingScreen(),
    );
  }
}

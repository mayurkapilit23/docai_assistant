import 'dart:async';
import 'package:docai_assistant/features/home/views/main_screen.dart';
import 'package:flutter/material.dart';

class DocAiLoadingScreen extends StatefulWidget {
  const DocAiLoadingScreen({super.key});

  @override
  State<DocAiLoadingScreen> createState() => _DocAiLoadingScreenState();
}

class _DocAiLoadingScreenState extends State<DocAiLoadingScreen> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (_progress >= 1.0) {
        timer.cancel();
        _onLoadingComplete();
      } else {
        setState(() {
          _progress += 0.01; // speed control
        });
      }
    });
  }

  void _onLoadingComplete() {
    // TODO: Navigate to next screen
    debugPrint("Loading Completed");

    // Example navigation
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F7FF), Color(0xFFE9F0FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),

              /// Icon
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2AFF),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "D",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: -5,
                    right: -5,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.auto_awesome,
                        size: 16,
                        color: Color(0xFF1F2AFF),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Title
              const Text(
                "DocAI Assistant",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 6),

              const Text(
                "Intelligent Document Intelligence",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const Spacer(),

              /// Status + %
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Initializing AI engine...",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Preparing your workspace",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),

                    /// Percentage
                    Text(
                      "${(_progress * 100).toInt()}%",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2AFF),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: _progress,
                    backgroundColor: Colors.blue.shade100,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF1F2AFF)),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

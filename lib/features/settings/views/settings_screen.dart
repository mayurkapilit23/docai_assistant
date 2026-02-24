import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/core/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedModel = "Llama 3 (Performance)";
  bool smartExtraction = true;
  bool lightTheme = false;

  final List<String> models = [
    "Llama 3 (Performance)",
    "GPT-4 Turbo",
    "Claude 3",
    "Gemini Pro",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CommonAppBar(title: "Settings", showBack: false),

      /// AppBar
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     "Settings",
      //     style: TextStyle(
      //       color: Colors.blue,
      //       fontWeight: FontWeight.w600,
      //       fontSize: 22,
      //     ),
      //   ),
      //   centerTitle: false,
      // ),

      /// Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// AI INTELLIGENCE
            _sectionTitle("AI INTELLIGENCE"),

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// AI Model
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "AI Model Selection",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      const Icon(Icons.auto_awesome, color: Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedModel,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),

                        items: models
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),

                        onChanged: (val) {
                          setState(() => selectedModel = val!);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Smart Extraction
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Smart Extraction",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Context-aware document parsing",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),

                      Switch(
                        value: smartExtraction,
                        activeColor: Colors.blue,
                        onChanged: (v) {
                          setState(() => smartExtraction = v);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// APP APPEARANCE
            _sectionTitle("APP APPEARANCE"),

            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.wb_sunny, color: Colors.blue),
                      ),

                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Light Theme",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Standard bright interface",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Switch(
                    value: lightTheme,
                    activeColor: Colors.blue,
                    onChanged: (v) {
                      setState(() => lightTheme = v);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// Footer Text
            Center(
              child: Text(
                "ULTRA MINIMAL INTERFACE",
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  color: Colors.blue.withOpacity(.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Header
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          letterSpacing: 1.5,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Card Wrapper
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
        ],
      ),
      child: child,
    );
  }
}

import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/core/utils/helperMethods/logger.dart';
import 'package:docai_assistant/core/widgets/app_button.dart';
import 'package:docai_assistant/core/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/bloc/theme_bloc.dart';
import '../../theme/bloc/theme_event.dart';
import '../../theme/bloc/theme_state.dart';
import '../data/repo/api_services.dart';

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
      appBar: CommonAppBar(title: "Settings", showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // /// AI INTELLIGENCE
            // _sectionTitle("AI INTELLIGENCE"),
            //
            // _card(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       /// AI Model
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           const Text(
            //             "AI Model Selection",
            //             style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w600,
            //               color: AppColors.primary,
            //             ),
            //           ),
            //           const Icon(Icons.auto_awesome, color: AppColors.primary),
            //         ],
            //       ),
            //
            //       const SizedBox(height: 14),
            //
            //       /// Dropdown
            //       Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 16),
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade100,
            //           borderRadius: BorderRadius.circular(14),
            //         ),
            //         child: DropdownButtonHideUnderline(
            //           child: DropdownButton<String>(
            //             value: selectedModel,
            //             isExpanded: true,
            //             icon: const Icon(Icons.keyboard_arrow_down),
            //
            //             items: models
            //                 .map(
            //                   (e) => DropdownMenuItem(value: e, child: Text(e)),
            //                 )
            //                 .toList(),
            //
            //             onChanged: (val) {
            //               setState(() => selectedModel = val!);
            //             },
            //           ),
            //         ),
            //       ),
            //
            //       const SizedBox(height: 20),
            //
            //       /// Smart Extraction
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: const [
            //               Text(
            //                 "Smart Extraction",
            //                 style: TextStyle(fontWeight: FontWeight.w600),
            //               ),
            //               SizedBox(height: 4),
            //               Text(
            //                 "Context-aware document parsing",
            //                 style: TextStyle(fontSize: 12, color: Colors.grey),
            //               ),
            //             ],
            //           ),
            //
            //           Switch(
            //             value: smartExtraction,
            //             activeColor: AppColors.primary,
            //             onChanged: (v) {
            //               setState(() => smartExtraction = v);
            //             },
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            //
            // const SizedBox(height: 30),

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
                          color: AppColors.primary.withOpacity(.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.wb_sunny,
                          color: AppColors.primary,
                        ),
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
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      final isLight = state.themeMode == ThemeMode.light;

                      return Switch(
                        value: isLight,
                        activeThumbColor: AppColors.primary,

                        onChanged: (v) {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(
                              v ? ThemeMode.light : ThemeMode.dark,
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Switch(
                  //   value: lightTheme,
                  //   activeThumbColor: AppColors.primary,
                  //   onChanged: (v) {
                  //     setState(() => lightTheme = v);
                  //   },
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            AppButton(
              onPressed: () async {
                final msg = await ApiService.testApi();

                showLog("TestApi", msg);
              },
              label: "Health Check API",
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
        ],
      ),
      child: child,
    );
  }
}

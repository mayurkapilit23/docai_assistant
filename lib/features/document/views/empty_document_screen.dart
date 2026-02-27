import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/core/widgets/app_button.dart';
import 'package:docai_assistant/core/widgets/common_app_bar.dart';
import 'package:docai_assistant/features/document/views/upload_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme_colors.dart';

class EmptyDocumentsScreen extends StatelessWidget {
  const EmptyDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Documents", showBack: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Big Circle + Icon
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.blue.withOpacity(0.15), Colors.transparent],
                  ),
                ),

                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.folder,
                        size: 70,
                        color: AppColors.primary,
                      ),

                      Positioned(
                        right: 45,
                        bottom: 45,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 22,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Title
              const Text(
                "No documents uploaded yet",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              /// Description
              const Text(
                "Start by uploading your first document to get AI-powered insights, summaries, and instant answers.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
              ),

              const SizedBox(height: 30),

              /// Upload Button
              ///
              AppButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UploadScreen()),
                  );
                },
                label: "Upload First Document",
                icon: Icons.add,
              ),

              const SizedBox(height: 18),

              /// Learn More
              TextButton(
                onPressed: () {},
                child: Text(
                  "Learn how it works",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).extension<AppThemeColors>()?.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

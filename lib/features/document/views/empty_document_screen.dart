import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/core/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class EmptyDocumentsScreen extends StatelessWidget {
  const EmptyDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      appBar: CommonAppBar(title: "Documents", showBack: false),

      /// AppBar
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   title: const Text(
      //     "Documents",
      //     style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      //   ),

      //   leading: IconButton(
      //     icon: const Icon(Icons.menu, color: Colors.black),
      //     onPressed: () {},
      //   ),

      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.search, color: Colors.black),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),

      /// Body
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

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
                      const Icon(Icons.folder, size: 70, color: Colors.blue),

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
                            color: Colors.blue,
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
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, size: 22),
                  label: const Text(
                    "Upload First Document",
                    style: TextStyle(fontSize: 16),
                  ),

                  onPressed: () {
                    // TODO: Open File Picker
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E33F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Learn More
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Learn how it works",
                  style: TextStyle(
                    color: Color(0xFF1E33F3),
                    fontWeight: FontWeight.w500,
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

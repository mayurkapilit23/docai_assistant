import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/core/utils/app_shadows.dart';
import 'package:docai_assistant/features/upload/views/upload_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _header(),

              // const SizedBox(height: 24),

              _uploadCard(context),

              const SizedBox(height: 24),

              _actionCards(),

              const SizedBox(height: 28),

              _recentTitle(),

              const SizedBox(height: 16),

              _recentItem(
                "Q3_Revenue_Report.pdf",
                "AI summarized 4 key financial trends...",
                "12M AGO",
                Colors.red.shade100,
                Icons.picture_as_pdf,
                Colors.red,
              ),

              _recentItem(
                "Product_Spec_v2.docx",
                "Extracted technical requirements...",
                "2H AGO",
                Colors.blue.shade100,
                Icons.description,
                Colors.blue,
              ),

              _recentItem(
                "Legal_Brief_Final.pdf",
                "Identified compliance issues...",
                "YESTERDAY",
                Colors.green.shade100,
                Icons.picture_as_pdf,
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* ---------------- WIDGETS ---------------- */

  Widget _header() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFFFE0C7),
          child: Icon(Icons.person, color: Colors.brown),
        ),
        const SizedBox(width: 12),

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good morning,", style: TextStyle(color: Colors.grey)),
            Text(
              "Alex Sterling",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const Spacer(),

        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 28),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _uploadCard(context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UploadScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2AFF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppShadows.strong,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.blue.withOpacity(0.3),
          //     blurRadius: 15,
          //     offset: const Offset(0, 8),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.upload_file,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Document",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Analyze PDF, Word, or Text files",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _actionCards() {
    return Row(
      children: [
        _smallCard(Icons.psychology, "Ask AI", "Query intelligence"),
        const SizedBox(width: 16),
        _smallCard(Icons.history, "History", "Past interactions"),
      ],
    );
  }

  Widget _smallCard(IconData icon, String title, String sub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Icon(icon, color: Colors.blue),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _recentTitle() {
    return Row(
      children: [
        const Text(
          "Recent Activity",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(onPressed: () {}, child: const Text("View All")),
      ],
    );
  }

  Widget _recentItem(
    String title,
    String desc,
    String time,
    Color bg,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navigation bar at the top
      appBar: const UnionNavbar(),
      // Custom drawer
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 32, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  const Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.deepPurple, thickness: 1),

              // Content Section
              const SizedBox(height: 16),
              _buildSection(
                title: 'Purpose',
                content:
                    'This app is a coursework recreation of the UPSU Union Shop website for the University of Portsmouth. '
                    'It is not the real shop and is used only for learning and assessment.',
              ),
              const SizedBox(height: 16),
              _buildSection(
                title: 'Goals',
                content:
                    'The goal of this project is to practice Flutter, app architecture, state management, testing, and using external '
                    'services while working with a realistic e-commerce style interface.',
              ),
              const SizedBox(height: 16),
              _buildSection(
                title: 'Disclaimer',
                content:
                    'Any products, prices, and images shown in this app may be dummy data or simplified examples and should not be treated '
                    'as real shop information.',
              ),
            ],
          ),
        ),
      ),
      // Custom footer at the bottom
      bottomNavigationBar: const UnionFooter(),
    );
  }

  // Helper method to build structured sections
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

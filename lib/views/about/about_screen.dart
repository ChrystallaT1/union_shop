import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/union_footer.dart';

// Screen displaying information about the app and its purpose
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // navigation bar at the top
      appBar: const UnionNavbar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'This app is a coursework recreation of the UPSU Union Shop '
                'website for the University of Portsmouth. It is not the real '
                'shop and is used only for learning and assessment.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              SizedBox(height: 16),
              Text(
                'The goal of this project is to practise Flutter, app '
                'architecture, state management, testing and using external '
                'services such as Firebase while working with a realistic '
                'e-commerce style interface.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              SizedBox(height: 16),
              Text(
                'Any products, prices and images shown in this app may be '
                'dummy data or simplified examples and should not be treated '
                'as real shop information.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
      ),
      // Custom footer at the bottom
      bottomNavigationBar: const UnionFooter(),
    );
  }
}

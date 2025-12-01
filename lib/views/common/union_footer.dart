import 'package:flutter/material.dart';

class UnionFooter extends StatelessWidget {
  const UnionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('© 2025 UPSU Union Shop'),
          SizedBox(height: 8),
          Text('This is a coursework project, not the real shop.'),
          SizedBox(height: 8),
          Text('Privacy · Terms · Contact'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';

class PrintShackAboutScreen extends StatelessWidget {
  const PrintShackAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildContent(context),
            const UnionFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF4d2963), Colors.purple[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.info_outline, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            'About Print Shack',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Everything you need to know about our personalization service',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            icon: Icons.edit,
            title: 'What is Print Shack?',
            content:
                'Print Shack is our personalization service that allows you to add custom text to selected products. '
                'Whether it\'s a name, message, or quote, we can print it on your merchandise to make it uniquely yours.',
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            icon: Icons.shopping_bag,
            title: 'Available Products',
            content:
                'Currently, we offer personalization on the following items:\n\n'
                '• T-Shirts (£19.99)\n'
                '• Hoodies (£39.99)\n'
                '• Mugs (£9.99)\n'
                '• Tote Bags (£14.99)\n'
                '• Water Bottles (£12.99)\n\n'
                'All products can be personalized with up to 50 characters of text.',
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            icon: Icons.palette,
            title: 'Customization Options',
            content: 'Choose from multiple font styles including:\n'
                '• Arial - Clean and modern\n'
                '• Times New Roman - Classic and elegant\n'
                '• Comic Sans - Fun and casual\n'
                '• Courier - Retro typewriter style\n'
                '• Georgia - Sophisticated serif\n\n'
                'Available colors:\n'
                'Black, White, Red, Blue, Green, Gold, and Silver\n\n'
                'Note: Not all color combinations work on all products. '
                'Our team will contact you if adjustments are needed.',
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            icon: Icons.monetization_on,
            title: 'Pricing',
            content: 'Personalization costs an additional £5.00 per item.\n\n'
                'This fee covers:\n'
                '• Professional printing\n'
                '• Quality assurance\n'
                '• Durable, long-lasting text\n'
                '• Satisfaction guarantee\n\n'
                'Quantity discounts are not available for personalized items.',
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            icon: Icons.access_time,
            title: 'Processing Time',
            content:
                'Personalized items require additional processing time:\n\n'
                '• Standard items: 3-5 business days\n'
                '• Personalized items: 5-7 business days\n\n'
                'Rush processing is available for an additional fee. '
                'Contact customer service for rush order pricing.',
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            icon: Icons.help_outline,
            title: 'Important Notes',
            content: '• Character limit: 50 characters maximum\n'
                '• Personalized items cannot be returned unless defective\n'
                '• Please double-check your text for spelling and accuracy\n'
                '• We reserve the right to refuse inappropriate text\n'
                '• Preview is approximate - actual product may vary slightly\n'
                '• Allow 24 hours for personalization approval',
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            icon: Icons.live_help,
            title: 'Have Questions?',
            content:
                'If you have any questions about our personalization service, please contact:\n\n'
                '📧 Email: printshack@upsu.net\n'
                '📞 Phone: (023) 9284 3000\n'
                '💬 Live Chat: Available Mon-Fri 9am-5pm\n\n'
                'We\'re here to help make your custom products perfect!',
          ),
          const SizedBox(height: 48),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/print-shack'),
              icon: const Icon(Icons.edit),
              label: const Text('Start Personalizing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF4d2963), size: 32),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4d2963),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
        ),
      ],
    );
  }
}

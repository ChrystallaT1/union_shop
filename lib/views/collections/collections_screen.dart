import 'package:flutter/material.dart';
import 'package:union_shop/views/collection/collection_detail_screen.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final List<Map<String, String>> collections = [
    {
      'id': 'hoodies',
      'name': 'Hoodies',
      'description': 'Comfortable hoodies for all occasions',
    },
    {
      'id': 'tshirts',
      'name': 'T-Shirts',
      'description': 'Classic t-shirts with UPSU branding',
    },
    {
      'id': 'accessories',
      'name': 'Accessories',
      'description': 'Complete your look with our accessories',
    },
    {
      'id': 'stationery',
      'name': 'Stationery',
      'description': 'Essential stationery for students',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: UnionNavbar(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            color: const Color(0xFF4d2963),
            child: Column(
              children: [
                const Text(
                  'Collections',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Browse our product collections',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Collections Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 16 : 32),
              child: Center(
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: collections.map((collection) {
                    return SizedBox(
                      width: isMobile ? double.infinity : 300,
                      height: 250,
                      child: _buildCollectionCard(collection),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          const UnionFooter(),
        ],
      ),
    );
  }

  Widget _buildCollectionCard(Map<String, String> collection) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          print('🔍 Navigating to collection: ${collection['id']}');
          print('🔍 Collection name: ${collection['name']}');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectionDetailScreen(
                collectionName: collection['id']!,
                collectionDisplayName: collection['name']!,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF4d2963).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  size: 40,
                  color: Color(0xFF4d2963),
                ),
              ),
              const SizedBox(height: 16),

              // Collection Name
              Text(
                collection['name']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                collection['description']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),

              // Browse Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectionDetailScreen(
                        collectionName: collection['id']!,
                        collectionDisplayName: collection['name']!,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Browse Collection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

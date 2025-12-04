import 'package:flutter/material.dart';
import 'package:union_shop/models/collection_model.dart';
import 'package:union_shop/services/collections_service.dart';
import 'package:union_shop/utils/screen_size_helper.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/collection/collection_detail_screen.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final CollectionsService _collectionsService = CollectionsService();

  String _sortBy = 'name';
  bool _sortAscending = true;
  String _filterCategory = 'all';
  int _currentPage = 0;
  final int _itemsPerPage = 6;

  final List<Map<String, String>> collections = [
    {
      'id': 'hoodies',
      'name': 'Hoodies',
      'description': 'Comfortable hoodies for all occasions',
      'image': 'assets/images/collections/hoodies.png',
    },
    {
      'id': 'tshirts',
      'name': 'T-Shirts',
      'description': 'Classic t-shirts with UPSU branding',
      'image': 'assets/images/collections/tshirts.png',
    },
    {
      'id': 'accessories',
      'name': 'Accessories',
      'description': 'Complete your look with our accessories',
      'image': 'assets/images/collections/accessories.png',
    },
    {
      'id': 'sportswear',
      'name': 'Sportswear',
      'description': 'Performance wear for active lifestyles',
      'image': 'assets/images/collections/sportswear.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildFiltersAndSorting(),
            _buildCollectionsGrid(),
            const UnionFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'Collections',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse our product collections',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSorting() {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _filterCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All')),
                DropdownMenuItem(value: 'clothing', child: Text('Clothing')),
                DropdownMenuItem(
                    value: 'accessories', child: Text('Accessories')),
                DropdownMenuItem(
                    value: 'stationery', child: Text('Stationery')),
              ],
              onChanged: (value) {
                setState(() {
                  _filterCategory = value!;
                  _currentPage = 0;
                });
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _sortBy,
                    decoration: const InputDecoration(
                      labelText: 'Sort',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'name', child: Text('Name')),
                      DropdownMenuItem(value: 'dateAdded', child: Text('Date')),
                      DropdownMenuItem(
                          value: 'productCount', child: Text('Count')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _sortBy = value!;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
                  onPressed: () {
                    setState(() {
                      _sortAscending = !_sortAscending;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _filterCategory,
              decoration: const InputDecoration(
                labelText: 'Filter by Category',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Categories')),
                DropdownMenuItem(value: 'clothing', child: Text('Clothing')),
                DropdownMenuItem(
                    value: 'accessories', child: Text('Accessories')),
                DropdownMenuItem(
                    value: 'stationery', child: Text('Stationery')),
              ],
              onChanged: (value) {
                setState(() {
                  _filterCategory = value!;
                  _currentPage = 0;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _sortBy,
              decoration: const InputDecoration(
                labelText: 'Sort by',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'name', child: Text('Name')),
                DropdownMenuItem(value: 'dateAdded', child: Text('Date Added')),
                DropdownMenuItem(
                    value: 'productCount', child: Text('Product Count')),
              ],
              onChanged: (value) {
                setState(() {
                  _sortBy = value!;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() {
                _sortAscending = !_sortAscending;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionsGrid() {
    return Padding(
      padding: ScreenSize.getPagePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final collection = collections[index];
              return _buildCollectionCard(collection);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionCard(Map<String, String> collection) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // ✅ DEBUG: Print what we're passing
          print('Collection clicked: ${collection['id']}');
          print('Collection name: ${collection['name']}');

          // Navigate
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
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                collection['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 64),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    collection['name']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    collection['description']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed:
                _currentPage > 0 ? () => setState(() => _currentPage--) : null,
          ),
          ...List.generate(totalPages, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                onPressed: () => setState(() => _currentPage = index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentPage == index
                      ? const Color(0xFF4d2963)
                      : Colors.grey[300],
                  foregroundColor:
                      _currentPage == index ? Colors.white : Colors.black,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                ),
                child: Text('${index + 1}'),
              ),
            );
          }),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < totalPages - 1
                ? () => setState(() => _currentPage++)
                : null,
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 1;
    if (width < 900) return 2;
    return 3;
  }
}

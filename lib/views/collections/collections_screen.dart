import 'package:flutter/material.dart';
import 'package:union_shop/models/collection_model.dart';
import 'package:union_shop/services/collections_service.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
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
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCollectionCard(
            title: 'Hoodies',
            subtitle: 'Comfortable hoodies for all occasions',
            imageUrl:
                'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
            collectionId: 'hoodies',
          ),
          _buildCollectionCard(
            title: 'T-Shirts',
            subtitle: 'Classic t-shirts with university branding',
            imageUrl:
                'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
            collectionId: 't-shirts',
          ),
          _buildCollectionCard(
            title: 'Accessories',
            subtitle: 'Bags, caps, and more',
            imageUrl:
                'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
            collectionId: 'accessories',
          ),
          _buildCollectionCard(
            title: 'Stationery',
            subtitle: 'Notebooks, pens, and study supplies',
            imageUrl:
                'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
            collectionId: 'stationery',
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionCard({
    required String title,
    required String subtitle,
    required String imageUrl,
    required String collectionId,
  }) {
    return GestureDetector(
      onTap: () {
        print('🔍 Navigating to collection: $collectionId');
        Navigator.pushNamed(
          context,
          '/collection-detail',
          arguments: collectionId,
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
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
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
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

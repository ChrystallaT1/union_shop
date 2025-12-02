import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_navbar.dart';

// Screen showing products within a specific collection
class CollectionDetailScreen extends StatefulWidget {
  final String collectionName;

  const CollectionDetailScreen({
    super.key,
    required this.collectionName,
  });

  @override
  State<CollectionDetailScreen> createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen> {
  String _selectedSort = 'Featured';
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Collection header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 32 : 48,
                horizontal: isMobile ? 16 : 24,
              ),
              color: Colors.grey[100],
              child: Column(
                children: [
                  Text(
                    widget.collectionName,
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_getDummyProducts().length} products',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Filters and sorting bar
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: isMobile
                  ? Column(
                      children: [
                        _buildFilterDropdown(isMobile),
                        const SizedBox(height: 12),
                        _buildSortDropdown(isMobile),
                      ],
                    )
                  : Row(
                      children: [
                        _buildFilterDropdown(isMobile),
                        const SizedBox(width: 16),
                        _buildSortDropdown(isMobile),
                        const Spacer(),
                        Text(
                          '${_getDummyProducts().length} Results',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),

            // Products grid
            Padding(
              padding:
                  EdgeInsets.all(isMobile ? 16.0 : (isTablet ? 32.0 : 40.0)),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
                  crossAxisSpacing: isMobile ? 12 : 24,
                  mainAxisSpacing: isMobile ? 16 : 32,
                  childAspectRatio: isMobile ? 0.7 : 0.75,
                ),
                itemCount: _getDummyProducts().length,
                itemBuilder: (context, index) {
                  final product = _getDummyProducts()[index];
                  return ProductCard(
                    title: product['title']!,
                    price: product['price']!,
                    imageUrl: product['imageUrl']!,
                  );
                },
              ),
            ),

            // Footer
            const UnionFooter(),
          ],
        ),
      ),
    );
  }

  // Filter dropdown widget
  Widget _buildFilterDropdown(bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : 200,
      child: DropdownButtonFormField<String>(
        value: _selectedFilter,
        decoration: InputDecoration(
          labelText: 'Filter by',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        items: const [
          DropdownMenuItem(value: 'All', child: Text('All')),
          DropdownMenuItem(value: 'New', child: Text('New Arrivals')),
          DropdownMenuItem(value: 'Sale', child: Text('On Sale')),
          DropdownMenuItem(value: 'Popular', child: Text('Most Popular')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedFilter = value!;
          });
        },
      ),
    );
  }

  // Sort dropdown widget
  Widget _buildSortDropdown(bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : 200,
      child: DropdownButtonFormField<String>(
        value: _selectedSort,
        decoration: InputDecoration(
          labelText: 'Sort by',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        items: const [
          DropdownMenuItem(value: 'Featured', child: Text('Featured')),
          DropdownMenuItem(
              value: 'Price: Low to High', child: Text('Price: Low to High')),
          DropdownMenuItem(
              value: 'Price: High to Low', child: Text('Price: High to Low')),
          DropdownMenuItem(value: 'Newest', child: Text('Newest')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedSort = value!;
          });
        },
      ),
    );
  }

  // Dummy product data for the collection
  List<Map<String, String>> _getDummyProducts() {
    return [
      {
        'title': '${widget.collectionName} Item 1',
        'price': '£19.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': '${widget.collectionName} Item 2',
        'price': '£24.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': '${widget.collectionName} Item 3',
        'price': '£14.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': '${widget.collectionName} Item 4',
        'price': '£29.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': '${widget.collectionName} Item 5',
        'price': '£34.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': '${widget.collectionName} Item 6',
        'price': '£17.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': '${widget.collectionName} Item 7',
        'price': '£22.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': '${widget.collectionName} Item 8',
        'price': '£39.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
    ];
  }
}

// Product card widget for collection detail page
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Card(
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 48,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Product details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_footer.dart';

// Screen products, specific collection
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
      body: CustomScrollView(
        slivers: [
          // Navbar
          SliverToBoxAdapter(
            child: Material(
              color: Theme.of(context).primaryColor,
              elevation: 4,
              child: SafeArea(
                bottom: false,
                child: _buildNavbarContent(context),
              ),
            ),
          ),

          //content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // header
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

                // grid
                Padding(
                  padding: EdgeInsets.all(
                      isMobile ? 16.0 : (isTablet ? 32.0 : 40.0)),
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
        ],
      ),
    );
  }

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
          DropdownMenuItem(value: 'All', child: Text('All Products')),
          DropdownMenuItem(value: 'Price', child: Text('By Price')),
          DropdownMenuItem(value: 'Size', child: Text('By Size')),
          DropdownMenuItem(value: 'Color', child: Text('By Color')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedFilter = value!;
          });
        },
      ),
    );
  }

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
          DropdownMenuItem(value: 'Name: A-Z', child: Text('Name: A-Z')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedSort = value!;
          });
        },
      ),
    );
  }

  // Dummy product data
  List<Map<String, String>> _getDummyProducts() {
    return [
      {
        'title': 'Portsmouth T-Shirt',
        'price': '£15.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'UPSU Hoodie',
        'price': '£29.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': 'University Cap',
        'price': '£12.50',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'UPSU Backpack',
        'price': '£24.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': 'Portsmouth Mug',
        'price': '£8.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'University Notebook',
        'price': '£5.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': 'UPSU Water Bottle',
        'price': '£9.99',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'Portsmouth Keychain',
        'price': '£3.50',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
    ];
  }

  Widget _buildNavbarContent(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'UPSU Union Shop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/collections');
            },
            child: const Text('Collections',
                style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sale');
            },
            child: const Text('Sale', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            child:
                const Text('About Us', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Account', style: TextStyle(color: Colors.white)),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Widget individual product cards
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
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
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

import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_navbar.dart';

// Screen displaying sale products with discounted prices
class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
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
            // Promotional banner
            _buildPromotionalBanner(isMobile),

            // Sale header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 24 : 32,
                horizontal: isMobile ? 16 : 24,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'SALE',
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Save up to 50% on selected items',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_getSaleProducts().length} products on sale',
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
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
                          '${_getSaleProducts().length} Results',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),

            // Sale products grid
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
                  childAspectRatio: isMobile ? 0.65 : 0.7,
                ),
                itemCount: _getSaleProducts().length,
                itemBuilder: (context, index) {
                  final product = _getSaleProducts()[index];
                  return SaleProductCard(
                    title: product['title']!,
                    originalPrice: product['originalPrice']!,
                    salePrice: product['salePrice']!,
                    discount: product['discount']!,
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

  // Promotional banner at the top
  Widget _buildPromotionalBanner(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 16 : 20,
        horizontal: isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[700]!, Colors.red[500]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            '🔥 WINTER SALE - UP TO 50% OFF 🔥',
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Limited time offer - Shop now before it\'s gone!',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
          DropdownMenuItem(value: 'All', child: Text('All Products')),
          DropdownMenuItem(value: 'Discount', child: Text('By Discount')),
          DropdownMenuItem(value: 'Price', child: Text('By Price')),
          DropdownMenuItem(value: 'Category', child: Text('By Category')),
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
              value: 'Discount: High to Low',
              child: Text('Discount: High to Low')),
          DropdownMenuItem(
              value: 'Price: Low to High', child: Text('Price: Low to High')),
          DropdownMenuItem(
              value: 'Price: High to Low', child: Text('Price: High to Low')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedSort = value!;
          });
        },
      ),
    );
  }

  // Dummy sale product data
  List<Map<String, String>> _getSaleProducts() {
    return [
      {
        'title': 'Portsmouth T-Shirt',
        'originalPrice': '£19.99',
        'salePrice': '£14.99',
        'discount': '25% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'UPSU Hoodie',
        'originalPrice': '£39.99',
        'salePrice': '£29.99',
        'discount': '25% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': 'University Cap',
        'originalPrice': '£14.99',
        'salePrice': '£9.99',
        'discount': '33% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'UPSU Backpack',
        'originalPrice': '£34.99',
        'salePrice': '£24.99',
        'discount': '29% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': 'Portsmouth Mug',
        'originalPrice': '£10.99',
        'salePrice': '£5.99',
        'discount': '45% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'University Notebook',
        'originalPrice': '£7.99',
        'salePrice': '£3.99',
        'discount': '50% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': 'UPSU Water Bottle',
        'originalPrice': '£12.99',
        'salePrice': '£8.99',
        'discount': '31% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'Portsmouth Keychain',
        'originalPrice': '£4.99',
        'salePrice': '£2.99',
        'discount': '40% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
      {
        'title': 'UPSU Scarf',
        'originalPrice': '£16.99',
        'salePrice': '£11.99',
        'discount': '29% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      },
      {
        'title': 'Portsmouth Pen Set',
        'originalPrice': '£8.99',
        'salePrice': '£4.99',
        'discount': '44% OFF',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      },
    ];
  }
}

// Widget for displaying sale product cards with original and discounted prices
class SaleProductCard extends StatelessWidget {
  final String title;
  final String originalPrice;
  final String salePrice;
  final String discount;
  final String imageUrl;

  const SaleProductCard({
    super.key,
    required this.title,
    required this.originalPrice,
    required this.salePrice,
    required this.discount,
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
            // Product image with discount badge
            Expanded(
              child: Stack(
                children: [
                  Container(
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
                  // Discount badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        discount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
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
                  const SizedBox(height: 6),
                  // Original price (crossed out)
                  Text(
                    originalPrice,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Sale price
                  Text(
                    salePrice,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
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

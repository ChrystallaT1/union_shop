import 'package:flutter/material.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/services/products_service.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductsService _productsService = ProductsService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    // Get featured products (top 4 by popularity)
    final featuredProducts = _productsService.getAllProducts().take(4).toList();

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context, isMobile, isTablet),
            _buildProductsSection(
                context, isMobile, isTablet, featuredProducts),
            const UnionFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile, bool isTablet) {
    return SizedBox(
      height: isMobile ? 300 : (isTablet ? 350 : 400),
      width: double.infinity,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          // Content overlay
          Positioned(
            left: isMobile ? 16 : 24,
            right: isMobile ? 16 : 24,
            top: isMobile ? 40 : 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to UPSU Shop',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 12 : 16),
                Text(
                  "Official merchandise and essentials for Portsmouth students",
                  style: TextStyle(
                    fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/collections'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d2963),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 32,
                      vertical: isMobile ? 12 : 16,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'BROWSE PRODUCTS',
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    List<ProductModel> products,
  ) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16.0 : (isTablet ? 32.0 : 40.0)),
        child: Column(
          children: [
            Text(
              'FEATURED PRODUCTS',
              style: TextStyle(
                fontSize: isMobile ? 18 : 20,
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 24 : 48),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
                crossAxisSpacing: isMobile ? 12 : 24,
                mainAxisSpacing: isMobile ? 12 : 24,
                childAspectRatio: isMobile ? 0.7 : (isTablet ? 0.75 : 0.8),
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(products[index]);
              },
            ),
            SizedBox(height: isMobile ? 24 : 32),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/collections'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 12 : 16,
                ),
              ),
              child: const Text('VIEW ALL PRODUCTS'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
        print('🔍 Clicking product from home: ${product.id} - ${product.name}');
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'id': product.id,
            'name': product.name,
            'price': '£${product.displayPrice.toStringAsFixed(2)}',
            'image': product.imageUrl,
          },
        );
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child:
                              const Icon(Icons.image_not_supported, size: 64),
                        );
                      },
                    ),
                  ),
                  // Sale badge
                  if (product.isOnSale)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.discountPercentage,
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (product.isOnSale) ...[
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '£${product.displayPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                  ] else
                    Text(
                      '£${product.displayPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
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

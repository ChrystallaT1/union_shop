import 'package:flutter/material.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/services/products_service.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/utils/screen_size_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductsService _productsService = ProductsService();

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenSize.isMobile(context);
    final isTablet = ScreenSize.isTablet(context);

    // Get featured products
    final featuredProducts = _productsService
        .getAllProducts()
        .take(isMobile ? 4 : (isTablet ? 6 : 8))
        .toList();

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildProductsSection(context, featuredProducts),
            const UnionFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isMobile = ScreenSize.isMobile(context);
    final isTablet = ScreenSize.isTablet(context);

    return Container(
      height: isMobile ? 300 : (isTablet ? 400 : 500),
      width: double.infinity,
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
          color: Colors.black.withValues(alpha: 0.6),
        ),
        padding: ScreenSize.getPagePadding(context),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ScreenSize.getMaxContentWidth(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to UPSU Shop',
                  style: TextStyle(
                    fontSize: isMobile ? 28 : (isTablet ? 36 : 48),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 16 : 24),
                Text(
                  'Official merchandise and essentials for Portsmouth students',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : (isTablet ? 16 : 20),
                    color: Colors.white,
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
                      horizontal: isMobile ? 24 : 40,
                      vertical: isMobile ? 14 : 18,
                    ),
                    minimumSize: Size(isMobile ? 200 : 250, isMobile ? 48 : 56),
                  ),
                  child: Text(
                    'BROWSE PRODUCTS',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSection(
    BuildContext context,
    List<ProductModel> products,
  ) {
    final padding = ScreenSize.getPagePadding(context);

    return Container(
      color: Colors.white,
      padding: padding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              Text(
                'FEATURED PRODUCTS',
                style: TextStyle(
                  fontSize: ScreenSize.isMobile(context) ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: ScreenSize.isMobile(context) ? 24 : 40),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ScreenSize.getGridColumns(context),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(products[index]);
                },
              ),
              SizedBox(height: ScreenSize.isMobile(context) ? 24 : 40),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/collections'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.isMobile(context) ? 24 : 32,
                    vertical: ScreenSize.isMobile(context) ? 12 : 16,
                  ),
                  minimumSize: Size(
                    ScreenSize.isMobile(context) ? 200 : 250,
                    48,
                  ),
                ),
                child: const Text('VIEW ALL PRODUCTS'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {'productId': product.id},
        );
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 48),
                      );
                    },
                  ),
                  if (product.isOnSale)
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

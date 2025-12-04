import 'package:flutter/material.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/services/products_service.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';

class CollectionDetailScreen extends StatefulWidget {
  final String collectionName;
  final String collectionDisplayName;

  const CollectionDetailScreen({
    Key? key,
    required this.collectionName,
    required this.collectionDisplayName,
  }) : super(key: key);

  @override
  State<CollectionDetailScreen> createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen> {
  final ProductsService _productsService = ProductsService();
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];
  String _selectedCategory = 'All Categories';
  String _sortBy = 'popularity';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _isLoading = true;
    });

    try {
      final products = _productsService.getProductsByCollection(
        widget.collectionName,
        sortBy: _sortBy,
      );

      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });

      print(
          '✅ Loaded ${products.length} products for ${widget.collectionName}');
    } catch (e) {
      print('❌ Error loading products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterProducts(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All Categories') {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
            .where((product) => product.category == category.toLowerCase())
            .toList();
      }
    });
  }

  void _sortProducts(String sortBy) {
    setState(() {
      _sortBy = sortBy;
    });
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: UnionNavbar(),
      drawer: isMobile ? MobileDrawer() : null,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            color: const Color(0xFF4d2963),
            child: Column(
              children: [
                Text(
                  widget.collectionDisplayName,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_filteredProducts.length} products',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Filters
          Container(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            color: Colors.grey[100],
            child: isMobile
                ? Column(
                    children: [
                      _buildCategoryDropdown(),
                      const SizedBox(height: 12),
                      _buildSortDropdown(),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildCategoryDropdown()),
                      const SizedBox(width: 24),
                      Expanded(child: _buildSortDropdown()),
                    ],
                  ),
          ),

          // Products Grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.inventory_2_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No products found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        child: Center(
                          child: Wrap(
                            spacing: 24,
                            runSpacing: 24,
                            alignment: WrapAlignment.center,
                            children: _filteredProducts.map((product) {
                              return SizedBox(
                                width: isMobile ? double.infinity : 280,
                                child: _buildProductCard(product),
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

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter by Category',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: ['All Categories', 'Clothing', 'Accessories', 'Stationery']
              .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) _filterProducts(value);
          },
        ),
      ],
    );
  }

  Widget _buildSortDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sort by',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _sortBy,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'popularity', child: Text('Popularity')),
            DropdownMenuItem(value: 'name', child: Text('Name')),
            DropdownMenuItem(
                value: 'price_low', child: Text('Price: Low to High')),
            DropdownMenuItem(
                value: 'price_high', child: Text('Price: High to Low')),
            DropdownMenuItem(value: 'newest', child: Text('Newest')),
          ],
          onChanged: (value) {
            if (value != null) _sortProducts(value);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          print('🔍 Navigating to product: ${product.id}');

          Navigator.pushNamed(
            context,
            '/product',
            arguments: {
              'productId': product.id,
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
                child: product.imageUrl.isNotEmpty
                    ? Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.image_not_supported, size: 40),
                        ),
                      )
                    : const Center(child: Icon(Icons.image, size: 40)),
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(12),
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
                  if (product.isOnSale && product.salePrice != null)
                    Row(
                      children: [
                        Text(
                          '£${product.salePrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4d2963),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '£${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      '£${product.displayPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4d2963),
                      ),
                    ),
                  if (product.isOnSale)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'SALE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
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

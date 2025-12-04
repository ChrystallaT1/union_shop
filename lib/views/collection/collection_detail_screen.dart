import 'package:flutter/material.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/services/products_service.dart';
import 'package:union_shop/utils/screen_size_helper.dart';
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
  String _sortBy = 'popularity';
  bool _sortAscending = false;
  String _filterSize = 'all';
  String _filterColor = 'all';
  String _filterPriceRange = 'all';
  int _currentPage = 0;
  final int _itemsPerPage = 12;

  List<ProductModel> get _filteredProducts {
    print('Getting products for collection: ${widget.collectionName}');

    var products = _productsService.getProductsByCollection(
      widget.collectionName,
      sortBy: _sortBy,
    );

    print('Found ${products.length} products');

    if (_filterSize != 'all') {
      products = products.where((p) => p.sizes.contains(_filterSize)).toList();
    }

    if (_filterColor != 'all') {
      products =
          products.where((p) => p.colors.contains(_filterColor)).toList();
    }

    if (_filterPriceRange != 'all') {
      products = products.where((p) {
        final price = p.displayPrice;
        switch (_filterPriceRange) {
          case '0-15':
            return price < 15;
          case '15-30':
            return price >= 15 && price < 30;
          case '30-50':
            return price >= 30 && price < 50;
          case '50+':
            return price >= 50;
          default:
            return true;
        }
      }).toList();
    }

    if (_sortAscending) {
      products = products.reversed.toList();
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    // ✅ DEBUG: Print received values
    print('CollectionDetailScreen - collectionName: ${widget.collectionName}');
    print(
        'CollectionDetailScreen - collectionDisplayName: ${widget.collectionDisplayName}');

    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildFiltersAndSorting(),
            _buildProductsGrid(),
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
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Back to Collections',
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.collectionName,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Browse products in this collection',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSorting() {
    final isMobile = ScreenSize.isMobile(context);

    return Container(
      padding: ScreenSize.getPagePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: isMobile
              ? Column(
                  children: [
                    _buildSortDropdown(),
                    const SizedBox(height: 12),
                    _buildPriceRangeFilter(),
                    const SizedBox(height: 12),
                    _buildSizeFilter(),
                    const SizedBox(height: 12),
                    _buildColorFilter(),
                  ],
                )
              : Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    SizedBox(width: 200, child: _buildSortDropdown()),
                    SizedBox(width: 200, child: _buildPriceRangeFilter()),
                    SizedBox(width: 150, child: _buildSizeFilter()),
                    SizedBox(width: 150, child: _buildColorFilter()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return DropdownButtonFormField<String>(
      value: _sortBy,
      decoration: const InputDecoration(
        labelText: 'Sort by',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: const [
        DropdownMenuItem(value: 'popularity', child: Text('Popularity')),
        DropdownMenuItem(value: 'name', child: Text('Name')),
        DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
        DropdownMenuItem(
            value: 'price_high', child: Text('Price: High to Low')),
        DropdownMenuItem(value: 'newest', child: Text('Newest')),
      ],
      onChanged: (value) => setState(() => _sortBy = value!),
    );
  }

  Widget _buildPriceRangeFilter() {
    return DropdownButtonFormField<String>(
      value: _filterPriceRange,
      decoration: const InputDecoration(
        labelText: 'Price Range',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: const [
        DropdownMenuItem(value: 'all', child: Text('All Prices')),
        DropdownMenuItem(value: '0-15', child: Text('Under £15')),
        DropdownMenuItem(value: '15-30', child: Text('£15 - £30')),
        DropdownMenuItem(value: '30-50', child: Text('£30 - £50')),
        DropdownMenuItem(value: '50+', child: Text('Over £50')),
      ],
      onChanged: (value) => setState(() {
        _filterPriceRange = value!;
        _currentPage = 0;
      }),
    );
  }

  Widget _buildSizeFilter() {
    return DropdownButtonFormField<String>(
      value: _filterSize,
      decoration: const InputDecoration(
        labelText: 'Size',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: const [
        DropdownMenuItem(value: 'all', child: Text('All Sizes')),
        DropdownMenuItem(value: 'XS', child: Text('XS')),
        DropdownMenuItem(value: 'S', child: Text('Small')),
        DropdownMenuItem(value: 'M', child: Text('Medium')),
        DropdownMenuItem(value: 'L', child: Text('Large')),
        DropdownMenuItem(value: 'XL', child: Text('XL')),
        DropdownMenuItem(value: 'XXL', child: Text('XXL')),
      ],
      onChanged: (value) => setState(() {
        _filterSize = value!;
        _currentPage = 0;
      }),
    );
  }

  Widget _buildColorFilter() {
    return DropdownButtonFormField<String>(
      value: _filterColor,
      decoration: const InputDecoration(
        labelText: 'Color',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: const [
        DropdownMenuItem(value: 'all', child: Text('All Colors')),
        DropdownMenuItem(value: 'Navy', child: Text('Navy')),
        DropdownMenuItem(value: 'Black', child: Text('Black')),
        DropdownMenuItem(value: 'White', child: Text('White')),
        DropdownMenuItem(value: 'Grey', child: Text('Grey')),
        DropdownMenuItem(value: 'Purple', child: Text('Purple')),
        DropdownMenuItem(value: 'Red', child: Text('Red')),
      ],
      onChanged: (value) => setState(() {
        _filterColor = value!;
        _currentPage = 0;
      }),
    );
  }

  Widget _buildProductsGrid() {
    final products = _filteredProducts;

    if (products.isEmpty) {
      return _buildEmptyState();
    }

    final totalPages = (products.length / _itemsPerPage).ceil();
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, products.length);
    final paginatedProducts = products.sublist(startIndex, endIndex);

    return Column(
      children: [
        Padding(
          padding: ScreenSize.getPagePadding(context),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ScreenSize.getMaxContentWidth(context),
              ),
              child: Column(
                children: [
                  Text(
                    'Showing ${startIndex + 1}-$endIndex of ${products.length} products',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ScreenSize.getGridColumns(context),
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: paginatedProducts.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(paginatedProducts[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (totalPages > 1) _buildPagination(totalPages),
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
            arguments: {'productId': product.id},
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
            if (totalPages > 5) {
              if (index == 0 ||
                  index == totalPages - 1 ||
                  (index >= _currentPage - 1 && index <= _currentPage + 1)) {
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
                      minimumSize: const Size(40, 40),
                    ),
                    child: Text('${index + 1}'),
                  ),
                );
              } else if (index == 1 && _currentPage > 2) {
                return const Text('...');
              } else if (index == totalPages - 2 &&
                  _currentPage < totalPages - 3) {
                return const Text('...');
              }
              return const SizedBox.shrink();
            }

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
                  minimumSize: const Size(40, 40),
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

  Widget _buildEmptyState() {
    return Padding(
      padding: ScreenSize.getPagePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              Icon(
                Icons.search_off,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                'No Products Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Try adjusting your filters or check back later',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _sortBy = 'popularity';
                    _filterSize = 'all';
                    _filterColor = 'all';
                    _filterPriceRange = 'all';
                    _currentPage = 0;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Clear Filters'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }
}

import 'package:flutter/material.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/services/products_service.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';

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
  final ProductsService _productsService = ProductsService();

  String _sortBy = 'name';
  bool _sortAscending = true;
  String _filterSize = 'all';
  String _filterColor = 'all';
  String _filterPriceRange = 'all';
  int _currentPage = 0;
  final int _itemsPerPage = 12;

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
          Text(
            widget.collectionName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
    );
  }

  Widget _buildFiltersAndSorting() {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildSortDropdown()),
                IconButton(
                  icon: Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
                  onPressed: () =>
                      setState(() => _sortAscending = !_sortAscending),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildPriceRangeFilter(),
            const SizedBox(height: 12),
            _buildSizeFilter(),
            const SizedBox(height: 12),
            _buildColorFilter(),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 200,
            child: Row(
              children: [
                Expanded(child: _buildSortDropdown()),
                IconButton(
                  icon: Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
                  onPressed: () =>
                      setState(() => _sortAscending = !_sortAscending),
                ),
              ],
            ),
          ),
          SizedBox(width: 200, child: _buildPriceRangeFilter()),
          SizedBox(width: 150, child: _buildSizeFilter()),
          SizedBox(width: 150, child: _buildColorFilter()),
        ],
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
        DropdownMenuItem(value: 'name', child: Text('Name')),
        DropdownMenuItem(value: 'price', child: Text('Price')),
        DropdownMenuItem(value: 'popularity', child: Text('Popularity')),
        DropdownMenuItem(value: 'dateAdded', child: Text('Newest')),
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
        DropdownMenuItem(value: 'S', child: Text('Small')),
        DropdownMenuItem(value: 'M', child: Text('Medium')),
        DropdownMenuItem(value: 'L', child: Text('Large')),
        DropdownMenuItem(value: 'XL', child: Text('XL')),
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
      ],
      onChanged: (value) => setState(() {
        _filterColor = value!;
        _currentPage = 0;
      }),
    );
  }

  Widget _buildProductsGrid() {
    final collectionId =
        widget.collectionName.toLowerCase().replaceAll(' ', '-');

    return StreamBuilder<List<ProductModel>>(
      stream: _productsService.getProductsByCollection(
        collectionId,
        sortBy: _sortBy,
        ascending: _sortAscending,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading products',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() {}),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No products found in this collection'),
                ],
              ),
            ),
          );
        }

        List<ProductModel> products = snapshot.data!;

        // Apply filters
        if (_filterSize != 'all') {
          products =
              products.where((p) => p.sizes.contains(_filterSize)).toList();
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

        if (products.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('No products match your filters'),
            ),
          );
        }

        // Pagination
        final totalPages = (products.length / _itemsPerPage).ceil();
        final startIndex = _currentPage * _itemsPerPage;
        final endIndex = (startIndex + _itemsPerPage).clamp(0, products.length);
        final paginatedProducts = products.sublist(startIndex, endIndex);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Showing ${startIndex + 1}-$endIndex of ${products.length} products',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(context),
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: paginatedProducts.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(paginatedProducts[index]);
                },
              ),
            ),
            if (totalPages > 1) _buildPagination(totalPages, products.length),
          ],
        );
      },
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
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
                  if (product.stockQuantity < 10)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Only ${product.stockQuantity} left!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
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
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${(product.popularity / 50).toStringAsFixed(1)}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.popularity} reviews)',
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (product.isOnSale)
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
                      color: product.isOnSale
                          ? Colors.red[700]
                          : const Color(0xFF4d2963),
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

  Widget _buildPagination(int totalPages, int totalItems) {
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

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }
}

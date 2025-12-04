import 'dart:async';
import 'package:flutter/material.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/services/products_service.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/product/product_page.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final ProductsService _productsService = ProductsService();

  List<ProductModel> _searchResults = [];
  List<ProductModel> _filteredResults = [];
  bool _isLoading = true;
  String _sortBy = 'relevance';
  double _minPrice = 0;
  double _maxPrice = 100;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _performSearch();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() => _isLoading = true);

    try {
      // Get ALL products from ProductsService
      final allProducts = _productsService.getAllProducts();

      // Filter by search query
      final searchQuery = widget.query.toLowerCase();
      final results = allProducts
          .where((product) => product.name.toLowerCase().contains(searchQuery))
          .toList();

      setState(() {
        _searchResults = results;
        _filteredResults = results;
        _isLoading = false;
      });
    } catch (e) {
      print('Error searching products: $e');
      setState(() => _isLoading = false);
    }
  }

  void _applyFiltersAndSort() {
    setState(() {
      _filteredResults = _searchResults.where((product) {
        final price = product.displayPrice;
        return price >= _minPrice && price <= _maxPrice;
      }).toList();

      switch (_sortBy) {
        case 'price_low':
          _filteredResults
              .sort((a, b) => a.displayPrice.compareTo(b.displayPrice));
          break;
        case 'price_high':
          _filteredResults
              .sort((a, b) => b.displayPrice.compareTo(a.displayPrice));
          break;
        case 'name':
          _filteredResults.sort((a, b) => a.name.compareTo(b.name));
          break;
        default:
          break;
      }
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: UnionNavbar(),
      drawer: MobileDrawer(),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildSearchResults(isMobile),
          ),
          const UnionFooter(),
        ],
      ),
    );
  }

  Widget _buildSearchResults(bool isMobile) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Results for "${widget.query}"',
              style: TextStyle(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_filteredResults.length} ${_filteredResults.length == 1 ? 'product' : 'products'} found',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            if (!isMobile) _buildDesktopFilters(),
            if (isMobile) _buildMobileFilters(),
            const SizedBox(height: 24),
            if (_filteredResults.isEmpty)
              _buildNoResults()
            else
              _buildProductGrid(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopFilters() {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<String>(
            value: _sortBy,
            decoration: const InputDecoration(
              labelText: 'Sort By',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: const [
              DropdownMenuItem(value: 'relevance', child: Text('Relevance')),
              DropdownMenuItem(
                  value: 'price_low', child: Text('Price: Low to High')),
              DropdownMenuItem(
                  value: 'price_high', child: Text('Price: High to Low')),
              DropdownMenuItem(value: 'name', child: Text('Name: A-Z')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _sortBy = value);
                _applyFiltersAndSort();
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Text('Price: £${_minPrice.toInt()} - £${_maxPrice.toInt()}'),
              Expanded(
                child: RangeSlider(
                  values: RangeValues(_minPrice, _maxPrice),
                  min: 0,
                  max: 100,
                  divisions: 20,
                  onChanged: (values) {
                    setState(() {
                      _minPrice = values.start;
                      _maxPrice = values.end;
                    });
                  },
                  onChangeEnd: (values) => _applyFiltersAndSort(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _sortBy = 'relevance';
              _minPrice = 0;
              _maxPrice = 100;
            });
            _applyFiltersAndSort();
          },
          icon: const Icon(Icons.clear),
          label: const Text('Clear Filters'),
        ),
      ],
    );
  }

  Widget _buildMobileFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          value: _sortBy,
          decoration: const InputDecoration(
            labelText: 'Sort By',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'relevance', child: Text('Relevance')),
            DropdownMenuItem(
                value: 'price_low', child: Text('Price: Low to High')),
            DropdownMenuItem(
                value: 'price_high', child: Text('Price: High to Low')),
            DropdownMenuItem(value: 'name', child: Text('Name: A-Z')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _sortBy = value);
              _applyFiltersAndSort();
            }
          },
        ),
        const SizedBox(height: 16),
        Text('Price Range: £${_minPrice.toInt()} - £${_maxPrice.toInt()}'),
        RangeSlider(
          values: RangeValues(_minPrice, _maxPrice),
          min: 0,
          max: 100,
          divisions: 20,
          onChanged: (values) {
            setState(() {
              _minPrice = values.start;
              _maxPrice = values.end;
            });
          },
          onChangeEnd: (values) => _applyFiltersAndSort(),
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _sortBy = 'relevance';
              _minPrice = 0;
              _maxPrice = 100;
            });
            _applyFiltersAndSort();
          },
          icon: const Icon(Icons.clear),
          label: const Text('Clear Filters'),
        ),
      ],
    );
  }

  Widget _buildProductGrid(bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredResults.length,
      itemBuilder: (context, index) {
        final product = _filteredResults[index];
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(4)),
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
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            if (product.isOnSale &&
                                product.salePrice != null) ...[
                              Text(
                                '£${product.salePrice!.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
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
                            ] else
                              Text(
                                '£${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              'No products found',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or search terms',
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}

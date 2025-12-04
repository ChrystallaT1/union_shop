import 'package:flutter/material.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/models/cart_item_model.dart';
import 'package:union_shop/services/products_service.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/utils/screen_size_helper.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';

class ProductPage extends StatefulWidget {
  final String? productId;

  const ProductPage({
    Key? key,
    this.productId,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductsService _productsService = ProductsService();
  final CartService _cartService = CartService();

  ProductModel? _product;
  bool _isLoading = true;
  String? _errorMessage;

  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _loadProduct();
    }
  }

  Future<void> _loadProduct() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      String? productId = widget.productId;

      // Try to get productId from route arguments if not provided
      if (productId == null || productId.isEmpty) {
        final args = ModalRoute.of(context)?.settings.arguments;

        print('🔍 Route arguments: $args');
        print('🔍 Args type: ${args.runtimeType}');

        if (args != null) {
          if (args is Map<String, dynamic>) {
            productId = args['productId'] as String?;
            print('🔍 Extracted productId from Map: $productId');
          } else if (args is String) {
            productId = args;
            print('🔍 Args is String: $productId');
          }
        }
      }

      print('🔍 Final productId: $productId');

      if (productId != null && productId.isNotEmpty) {
        final product = _productsService.getProductById(productId);

        print('🔍 Product found: ${product?.name}');

        if (product != null) {
          setState(() {
            _product = product;
            _selectedSize =
                product.sizes.isNotEmpty ? product.sizes.first : null;
            _selectedColor =
                product.colors.isNotEmpty ? product.colors.first : null;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Product not found with ID: $productId';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'No product ID provided';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('🔍 Error loading product: $e');
      setState(() {
        _errorMessage = 'Error loading product: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadProductByColor(String color) async {
    print('🔍 === Color Switch Started ===');
    print('🔍 Requested color: $color');
    print('🔍 Current product ID: ${_product!.id}');

    String? newProductId;

    // Hoodies
    if (_product!.id.startsWith('hoodie_sport_')) {
      final colorToId = {
        'Navy': 'hoodie_sport_navy',
        'Grey': 'hoodie_sport_grey',
        'Black': 'hoodie_sport_black',
      };
      newProductId = colorToId[color];
    } else if (_product!.id.startsWith('hoodie_upsu_')) {
      final colorToId = {
        'Navy': 'hoodie_upsu_navy',
        'Black': 'hoodie_upsu_black',
        'Grey': 'hoodie_upsu_grey',
      };
      newProductId = colorToId[color];
    } else if (_product!.id.startsWith('hoodie_portsmouth_')) {
      final colorToId = {
        'Navy': 'hoodie_portsmouth_navy',
        'Burgundy': 'hoodie_portsmouth_burgundy',
      };
      newProductId = colorToId[color];
    }
    // T-Shirts
    else if (_product!.id.startsWith('tshirt_upsu_sports_')) {
      final colorToId = {
        'Black': 'tshirt_upsu_sports_black',
        'Navy': 'tshirt_upsu_sports_navy',
        'Grey': 'tshirt_upsu_sports_grey',
      };
      newProductId = colorToId[color];
    } else if (_product!.id.startsWith('tshirt_portsmouth_full_')) {
      // ✅ University of Portsmouth Full Text
      final colorToId = {
        'Purple': 'tshirt_portsmouth_full_purple',
        'White': 'tshirt_portsmouth_full_white',
      };
      newProductId = colorToId[color];
    } else if (_product!.id.startsWith('tshirt_portsmouth_')) {
      // ✅ Portsmouth Arch T-Shirts
      final colorToId = {
        'White': 'tshirt_portsmouth_white',
        'Navy': 'tshirt_portsmouth_navy',
        'Grey': 'tshirt_portsmouth_grey',
      };
      newProductId = colorToId[color];
    }

    print('🔍 New product ID: $newProductId');

    if (newProductId != null && newProductId != _product!.id) {
      final product = _productsService.getProductById(newProductId);

      if (product != null) {
        print('🔍 ✅ Product found: ${product.name}');

        setState(() {
          _product = product;
          _selectedColor = color;
        });

        print('🔍 === Color Switch Complete ===');
      } else {
        print('🔍 ❌ Product not found for ID: $newProductId');
      }
    }
  }

  void _incrementQuantity() {
    if (_product != null && _quantity < _product!.stockQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  Future<void> _addToCart() async {
    if (_selectedSize == null) {
      _showErrorSnackbar('Please select a size');
      return;
    }

    if (_selectedColor == null) {
      _showErrorSnackbar('Please select a color');
      return;
    }

    if (_product == null) {
      _showErrorSnackbar('Product not available');
      return;
    }

    if (_product!.stockQuantity < _quantity) {
      _showErrorSnackbar('Not enough stock available');
      return;
    }

    if (_product!.stockQuantity == 0) {
      _showErrorSnackbar('Product is out of stock');
      return;
    }

    final cartItem = CartItemModel(
      productId: _product!.id,
      productName: _product!.name,
      productImage: _product!.imageUrl,
      price: _product!.displayPrice,
      selectedSize: _selectedSize!,
      selectedColor: _selectedColor!,
      quantity: _quantity,
    );

    final success = await _cartService.addToCart(cartItem);

    if (success) {
      _showSuccessSnackbar(
        'Added $_quantity x ${_product!.name} to cart\n'
        'Size: $_selectedSize, Color: $_selectedColor',
      );

      setState(() => _quantity = 1);
    } else {
      _showErrorSnackbar('Failed to add to cart');
    }
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red[700],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: UnionNavbar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_product == null || _errorMessage != null) {
      return Scaffold(
        appBar: UnionNavbar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage ?? 'Product not found',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: UnionNavbar(),
      drawer: isMobile ? MobileDrawer() : null,
      body: Column(
        children: [
          // Breadcrumb
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[100],
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  icon: const Icon(Icons.home, size: 16),
                  label: const Text('Home', style: TextStyle(fontSize: 12)),
                ),
                const Text(' > ', style: TextStyle(fontSize: 12)),
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/collections'),
                  icon: const Icon(Icons.grid_view, size: 16),
                  label:
                      const Text('Collections', style: TextStyle(fontSize: 12)),
                ),
                const Text(' > ', style: TextStyle(fontSize: 12)),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: _product!.imageUrl.isNotEmpty
                ? Image.asset(
                    // ✅ Changed to Image.asset
                    _product!.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                  )
                : const Icon(Icons.image, size: 100, color: Colors.grey),
          ),
        ),

        const SizedBox(height: 24),

        // Product Details
        _buildProductDetails(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Section - Uses Image.asset for local images
          Expanded(
            flex: 55,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: _product!.imageUrl.isNotEmpty
                    ? Image.asset(
                        // ✅ Changed to Image.asset
                        _product!.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: ${_product!.imageUrl}');
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.broken_image,
                                  size: 100, color: Colors.grey),
                              SizedBox(height: 16),
                              Text('Image not found'),
                            ],
                          );
                        },
                      )
                    : const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(width: 24),

          // Details Section
          Expanded(
            flex: 45,
            child: SingleChildScrollView(
              child: _buildProductDetails(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            _product!.imageUrl,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 400,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 64),
              );
            },
          ),
        ),
        if (_product!.isOnSale)
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _product!.discountPercentage,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        if (_product!.stockQuantity < 10 && _product!.stockQuantity > 0)
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Only ${_product!.stockQuantity} left!',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _product!.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              '${(_product!.popularity / 50).toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            Text(
              '(${_product!.popularity} reviews)',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_product!.isOnSale)
          Text(
            '£${_product!.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Text(
          '£${_product!.displayPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color:
                _product!.isOnSale ? Colors.red[700] : const Color(0xFF4d2963),
          ),
        ),
      ],
    );
  }

  Widget _buildStockInfo() {
    final inStock = _product!.stockQuantity > 0;
    return Row(
      children: [
        Icon(
          inStock ? Icons.check_circle : Icons.cancel,
          color: inStock ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          inStock
              ? 'In Stock (${_product!.stockQuantity} available)'
              : 'Out of Stock',
          style: TextStyle(
            fontSize: 16,
            color: inStock ? Colors.green[700] : Colors.red[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _product!.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSizeSelector(),
        const SizedBox(height: 24),
        _buildColorSelector(),
      ],
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _product!.sizes.map((size) {
            final isSelected = _selectedSize == size;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedSize = size;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4d2963) : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4d2963)
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _product!.colors.map((color) {
            final isSelected = _selectedColor == color;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  print('🔍 Color button clicked: $color');
                  print('🔍 Current product: ${_product!.id}');

                  // Update selected color immediately
                  setState(() {
                    _selectedColor = color;
                  });

                  // Load new product variant
                  await _loadProductByColor(color);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4d2963) : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4d2963)
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    color,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuantityAndAddToCart() {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text(
              'Quantity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _quantity > 1 ? _decrementQuantity : null,
                    color:
                        _quantity > 1 ? const Color(0xFF4d2963) : Colors.grey,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _quantity < _product!.stockQuantity
                        ? _incrementQuantity
                        : null,
                    color: _quantity < _product!.stockQuantity
                        ? const Color(0xFF4d2963)
                        : Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _product!.stockQuantity > 0 ? _addToCart : null,
            icon: const Icon(Icons.shopping_cart),
            label: Text(
              _product!.stockQuantity > 0 ? 'Add to Cart' : 'Out of Stock',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        if (_cartService.itemCount > 0) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_cart,
                        color: Colors.green[700], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${_cartService.itemCount} item(s) in cart',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                  child: const Text('View Cart'),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductHeader(),
          const SizedBox(height: 16),
          _buildStockInfo(),
          const SizedBox(height: 24),
          _buildDescription(),
          const SizedBox(height: 24),
          _buildOptionsSection(), // Calls size & color
          const SizedBox(height: 24),
          _buildQuantityAndAddToCart(),
        ],
      ),
    );
  }
}

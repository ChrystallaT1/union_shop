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
  final String? productName;
  final String? productPrice;
  final String? productImage;

  const ProductPage({
    super.key,
    this.productId,
    this.productName,
    this.productPrice,
    this.productImage,
  });

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
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (widget.productId != null) {
        final product = _productsService.getProductById(widget.productId!);
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
            _errorMessage = 'Product not found';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid product ID';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading product: $e';
        _isLoading = false;
      });
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

  void _addToCart() {
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

    final success = _cartService.addToCart(cartItem);

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
        appBar: const UnionNavbar(),
        drawer: const MobileDrawer(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null || _product == null) {
      return Scaffold(
        appBar: const UnionNavbar(),
        drawer: const MobileDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Error Loading Product',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_errorMessage ?? 'Product not found',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context), // ✅ Back button
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Breadcrumb navigation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    icon: const Icon(Icons.home, size: 16),
                    label: const Text('Home'),
                  ),
                  const Text(' > '),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/collections'),
                    icon: const Icon(Icons.grid_view, size: 16),
                    label: const Text('Collections'),
                  ),
                  const Text(' > '),
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: const Text('Back'),
                  ),
                  const Text(' > '),
                  Text(
                    _product!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Main content ✅ This is the correct method to call
            _buildProductView(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductView() {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return SingleChildScrollView(
      child: Column(
        children: [
          if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),
          const UnionFooter(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductHeader(),
              const SizedBox(height: 16),
              _buildStockInfo(),
              const SizedBox(height: 16),
              _buildDescription(),
              const SizedBox(height: 24),
              _buildOptionsSection(),
              const SizedBox(height: 24),
              _buildQuantityAndAddToCart(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildProductImage(),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductHeader(),
                const SizedBox(height: 16),
                _buildStockInfo(),
                const SizedBox(height: 16),
                _buildDescription(),
                const SizedBox(height: 24),
                _buildOptionsSection(),
                const SizedBox(height: 24),
                _buildQuantityAndAddToCart(),
              ],
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
        if (_product!.sizes.isNotEmpty) ...[
          const Text(
            'Size',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _product!.sizes.map((size) {
              final isSelected = _selectedSize == size;
              return ChoiceChip(
                label: Text(size),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => _selectedSize = size);
                },
                selectedColor: const Color(0xFF4d2963),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
        if (_product!.colors.isNotEmpty) ...[
          const Text(
            'Color',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _product!.colors.map((color) {
              final isSelected = _selectedColor == color;
              return ChoiceChip(
                label: Text(color),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => _selectedColor = color);
                },
                selectedColor: const Color(0xFF4d2963),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
        ],
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
}

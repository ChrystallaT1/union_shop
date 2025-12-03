import 'package:flutter/material.dart';
import 'package:union_shop/models/personalization_model.dart';
import 'package:union_shop/models/cart_item_model.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_footer.dart';

class PrintShackScreen extends StatefulWidget {
  const PrintShackScreen({super.key});

  @override
  State<PrintShackScreen> createState() => _PrintShackScreenState();
}

class _PrintShackScreenState extends State<PrintShackScreen> {
  final CartService _cartService = CartService();
  final TextEditingController _textController = TextEditingController();

  //  options
  String _selectedFont = 'Arial';
  String _selectedColor = 'Black';
  String _selectedProduct = 'T-Shirt';
  int _quantity = 1;

  // Available options
  final List<String> _fonts = [
    'Arial',
    'Times New Roman',
    'Comic Sans',
    'Courier',
    'Georgia'
  ];
  final List<String> _colors = [
    'Black',
    'White',
    'Red',
    'Blue',
    'Green',
    'Gold',
    'Silver'
  ];
  final Map<String, double> _products = {
    'T-Shirt': 19.99,
    'Hoodie': 39.99,
    'Mug': 9.99,
    'Tote Bag': 14.99,
    'Water Bottle': 12.99,
  };

  // Pricing
  final double _personalizationFee = 5.00;
  final int _maxCharacters = 50;

  String get _previewText =>
      _textController.text.isEmpty ? 'Your text here' : _textController.text;

  Color get _previewColor {
    switch (_selectedColor) {
      case 'White':
        return Colors.white;
      case 'Red':
        return Colors.red;
      case 'Blue':
        return Colors.blue;
      case 'Green':
        return Colors.green;
      case 'Gold':
        return Colors.amber[700]!;
      case 'Silver':
        return Colors.grey[400]!;
      default:
        return Colors.black;
    }
  }

  String get _previewFontFamily {
    switch (_selectedFont) {
      case 'Times New Roman':
        return 'serif';
      case 'Comic Sans':
        return 'cursive';
      case 'Courier':
        return 'monospace';
      case 'Georgia':
        return 'serif';
      default:
        return 'sans-serif';
    }
  }

  double get _basePrice => _products[_selectedProduct] ?? 0.0;
  double get _totalPrice => (_basePrice + _personalizationFee) * _quantity;

  bool get _isValid {
    final text = _textController.text.trim();
    return text.isNotEmpty && text.length <= _maxCharacters;
  }

  void _addToCart() {
    if (!_isValid) {
      _showSnackbar(
        'Please enter text (1-$_maxCharacters characters)',
        isError: true,
      );
      return;
    }

    final personalization = PersonalizationModel(
      text: _textController.text.trim(),
      fontStyle: _selectedFont,
      color: _selectedColor,
      additionalCost: _personalizationFee,
    );

    final cartItem = CartItemModel(
      productId: 'personalized-${DateTime.now().millisecondsSinceEpoch}',
      productName: 'Personalized $_selectedProduct',
      productImage:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      price: _basePrice,
      selectedSize: 'One Size',
      selectedColor: _selectedColor,
      quantity: _quantity,
      personalization: personalization,
    );

    final success = _cartService.addToCart(cartItem);

    if (success) {
      _showSnackbar(
        'Added personalized $_selectedProduct to cart!\n${personalization.displaySummary}',
        isError: false,
      );
      // Reset form
      setState(() {
        _textController.clear();
        _quantity = 1;
      });
    } else {
      _showSnackbar('Failed to add to cart', isError: true);
    }
  }

  void _showSnackbar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error : Icons.check_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? Colors.red[700] : Colors.green[700],
        duration: const Duration(seconds: 3),
        action: isError
            ? null
            : SnackBarAction(
                label: 'VIEW CART',
                textColor: Colors.white,
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF4d2963), Colors.purple[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.edit, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            'Print Shack',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Personalize your products with custom text',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/print-shack-about'),
            icon: const Icon(Icons.info_outline, color: Colors.white),
            label: const Text(
              'Learn More About Personalization',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildPersonalizationForm(),
          const SizedBox(height: 24),
          _buildPreviewCard(),
          const SizedBox(height: 24),
          _buildPricingSummary(),
          const SizedBox(height: 16),
          _buildAddToCartButton(),
        ],
      ),
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
            child: Column(
              children: [
                _buildPersonalizationForm(),
                const SizedBox(height: 24),
                _buildPricingSummary(),
                const SizedBox(height: 16),
                _buildAddToCartButton(),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 1,
            child: _buildPreviewCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalizationForm() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize Your Product',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // Product Selection
            const Text(
              'Select Product',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedProduct,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: _products.keys.map((product) {
                return DropdownMenuItem(
                  value: product,
                  child: Text(
                      '$product - £${_products[product]!.toStringAsFixed(2)}'),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedProduct = value!),
            ),
            const SizedBox(height: 16),

            // Text Input
            Text(
              'Your Text (max $_maxCharacters characters)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              maxLength: _maxCharacters,
              decoration: InputDecoration(
                hintText: 'Enter your custom text...',
                border: const OutlineInputBorder(),
                counterText: '${_textController.text.length}/$_maxCharacters',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Font Selection
            const Text(
              'Font Style',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedFont,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: _fonts.map((font) {
                return DropdownMenuItem(
                  value: font,
                  child: Text(font),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedFont = value!),
            ),
            const SizedBox(height: 16),

            // Color Selection
            const Text(
              'Text Color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colors.map((color) {
                final isSelected = _selectedColor == color;
                return ChoiceChip(
                  label: Text(color),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedColor = color),
                  selectedColor: const Color(0xFF4d2963),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Quantity
            const Text(
              'Quantity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed:
                      _quantity > 1 ? () => setState(() => _quantity--) : null,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Center(
                  child: Text(
                    _previewText,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _previewColor,
                      fontFamily: _previewFontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This is a preview. Actual product may vary slightly.',
                      style: TextStyle(color: Colors.blue[700], fontSize: 12),
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

  Widget _buildPricingSummary() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildPricingRow('Base Price', _basePrice),
            _buildPricingRow('Personalization Fee', _personalizationFee),
            _buildPricingRow('Quantity', _quantity.toDouble(),
                isQuantity: true),
            const Divider(height: 24),
            _buildPricingRow('Total', _totalPrice, isBold: true, isLarge: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingRow(String label, double amount,
      {bool isBold = false, bool isLarge = false, bool isQuantity = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 20 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            isQuantity
                ? amount.toInt().toString()
                : '£${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isLarge ? 20 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? const Color(0xFF4d2963) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _isValid ? _addToCart : null,
        icon: const Icon(Icons.shopping_cart),
        label: const Text(
          'Add to Cart',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4d2963),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[600],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

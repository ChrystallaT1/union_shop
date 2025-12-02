import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';
import 'package:union_shop/views/common/union_navbar.dart';

// product page showing product information and purchase options
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
  String selectedSize = 'M';
  int quantity = 1;
  int _currentImageIndex = 0;

  // Dummy product images
  final List<String> _productImages = [
    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
  ];

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
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 32),
              child: isMobile
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(isTablet),
            ),
            const UnionFooter(),
          ],
        ),
      ),
    );
  }

  // Mobile layout
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageGallery(true),
        const SizedBox(height: 24),
        _buildProductInfo(true),
      ],
    );
  }

  // Desktop/Tablet layout - side by side
  Widget _buildDesktopLayout(bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildImageGallery(false),
        ),
        SizedBox(width: isTablet ? 32 : 48),
        Expanded(
          flex: 1,
          child: _buildProductInfo(false),
        ),
      ],
    );
  }

  Widget _buildImageGallery(bool isMobile) {
    return Column(
      children: [
        Container(
          height: isMobile ? 300 : 500,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _productImages[_currentImageIndex],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(
            _productImages.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                child: Container(
                  height: 80,
                  margin: EdgeInsets.only(
                    right: index < _productImages.length - 1 ? 8 : 0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentImageIndex == index
                          ? const Color(0xFF4d2963)
                          : Colors.grey[300]!,
                      width: _currentImageIndex == index ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      _productImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, color: Colors.grey);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Product information and purchase options
  Widget _buildProductInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product title
        Text(
          widget.productName ?? 'Product Name',
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        //  price
        Text(
          widget.productPrice ?? '£0.00',
          style: TextStyle(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4d2963),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        //  description
        const Text(
          'Product Description',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'This premium quality hoodie features the UPSU Portsmouth logo. '
          'Made from soft, comfortable fabric perfect for everyday wear. '
          'Show your university pride with this stylish and cozy hoodie.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        // Size selector
        const Text(
          'Size',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        _buildSizeSelector(),
        const SizedBox(height: 24),
        // Color selector
        const Text(
          'Color',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        _buildColorSelector(),
        const SizedBox(height: 24),
        // Quantity selector
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        _buildQuantitySelector(),
        const SizedBox(height: 32),
        // Add to Cart button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added $quantity x ${widget.productName} (Size: $selectedSize) to cart',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        _buildProductDetails(),
      ],
    );
  }

  // Size selector dropdown
  Widget _buildSizeSelector() {
    return DropdownButtonFormField<String>(
      value: selectedSize,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: ['XS', 'S', 'M', 'L', 'XL', 'XXL'].map((size) {
        return DropdownMenuItem(
          value: size,
          child: Text(size),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedSize = value!;
        });
      },
    );
  }

  // Color selector dropdown
  Widget _buildColorSelector() {
    return DropdownButtonFormField<String>(
      value: 'Navy',
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: ['Navy', 'Black', 'Grey', 'White'].map((color) {
        return DropdownMenuItem(
          value: color,
          child: Text(color),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          // Update color selection
        });
      },
    );
  }

  // Quantity selector with +/- buttons
  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
              }
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
          ),
        ],
      ),
    );
  }

  // Product details section
  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildDetailRow('Material', '80% Cotton, 20% Polyester'),
        _buildDetailRow('Care', 'Machine washable'),
        _buildDetailRow('Fit', 'Regular fit'),
        _buildDetailRow('SKU', 'UPSU-HOOD-001'),
      ],
    );
  }

  // Helper to build detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:union_shop/models/product_model.dart';

class ProductsService {
  static final ProductsService _instance = ProductsService._internal();
  factory ProductsService() => _instance;
  ProductsService._internal();

  List<ProductModel> getAllProducts() {
    return [
      // ========== UPSU SPORT HOODIES (Original 3) ==========

      ProductModel(
        id: 'hoodie_sport_navy',
        name: 'UPSU Sport Hoodie - Navy',
        description:
            'Comfortable navy hoodie perfect for sports and casual wear. Features the iconic UPSU Sport logo.',
        price: 35.00,
        imageUrl:
            'assets/images/products/hoodie_sport_navy.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Navy', 'Grey', 'Black'],
        stockQuantity: 50,
        dateAdded: DateTime.now(),
        isOnSale: false,
        salePrice: null,
        popularity: 150,
      ),

      ProductModel(
        id: 'hoodie_sport_grey',
        name: 'UPSU Sport Hoodie - Grey',
        description: 'Lightweight athletic hoodie perfect for sports',
        price: 34.99,
        imageUrl:
            'assets/images/products/hoodie_sport_grey.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Navy', 'Grey', 'Black'],
        stockQuantity: 50,
        dateAdded: DateTime.now(),
        isOnSale: false,
        salePrice: null,
        popularity: 120,
      ),

      ProductModel(
        id: 'hoodie_sport_black',
        name: 'UPSU Sport Hoodie - Black',
        description:
            'Comfortable black hoodie perfect for sports and casual wear. Features the iconic UPSU Sport logo.',
        price: 35.00,
        imageUrl:
            'assets/images/products/hoodie_sport_black.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Navy', 'Grey', 'Black'],
        stockQuantity: 50,
        dateAdded: DateTime.now(),
        isOnSale: false,
        salePrice: null,
        popularity: 140,
      ),

      // ========== UPSU TEXT HOODIES (New 3) ==========

      ProductModel(
        id: 'hoodie_upsu_navy',
        name: 'UPSU Classic Hoodie - Navy',
        description:
            'Classic navy pullover hoodie with bold UPSU text. Perfect for everyday wear and showing your university pride.',
        price: 32.99,
        imageUrl: 'assets/images/products/hoodie_upsu_navy.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Navy', 'Black', 'Grey'],
        stockQuantity: 45,
        dateAdded: DateTime.now().subtract(const Duration(days: 5)),
        isOnSale: false,
        salePrice: null,
        popularity: 180,
      ),

      ProductModel(
        id: 'hoodie_upsu_black',
        name: 'UPSU Classic Hoodie - Black',
        description:
            'Sleek black pullover hoodie with prominent UPSU branding. Comfortable cotton blend for all-day wear.',
        price: 32.99,
        imageUrl:
            'assets/images/products/hoodie_upsu_black.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Navy', 'Black', 'Grey'],
        stockQuantity: 40,
        dateAdded: DateTime.now().subtract(const Duration(days: 5)),
        isOnSale: false,
        salePrice: null,
        popularity: 200,
      ),

      ProductModel(
        id: 'hoodie_upsu_grey',
        name: 'UPSU Classic Hoodie - Grey',
        description:
            'Versatile grey pullover hoodie with UPSU text. Essential wardrobe piece for any student.',
        price: 32.99,
        imageUrl: 'assets/images/products/hoodie_upsu_grey.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Navy', 'Black', 'Grey'],
        stockQuantity: 50,
        dateAdded: DateTime.now().subtract(const Duration(days: 5)),
        isOnSale: true,
        salePrice: 29.99,
        popularity: 160,
      ),

      // ========== UNIVERSITY OF PORTSMOUTH ZIP HOODIES (New 2) ==========

      ProductModel(
        id: 'hoodie_portsmouth_navy',
        name: 'University of Portsmouth Zip Hoodie - Navy',
        description:
            'Premium navy zip-up hoodie featuring full University of Portsmouth text. High-quality construction with comfortable fit.',
        price: 42.99,
        imageUrl:
            'assets/images/products/hoodie_portsmouth_navy.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Navy', 'Burgundy'],
        stockQuantity: 35,
        dateAdded: DateTime.now().subtract(const Duration(days: 2)),
        isOnSale: false,
        salePrice: null,
        popularity: 220,
      ),

      ProductModel(
        id: 'hoodie_portsmouth_burgundy',
        name: 'University of Portsmouth Zip Hoodie - Burgundy',
        description:
            'Distinctive burgundy zip-up hoodie with University of Portsmouth branding. Stand out with this unique color option.',
        price: 42.99,
        imageUrl:
            'assets/images/products/hoodie_portsmouth_burgundy.png', // ✅ Local path
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Navy', 'Burgundy'],
        stockQuantity: 30,
        dateAdded: DateTime.now().subtract(const Duration(days: 2)),
        isOnSale: true,
        salePrice: 38.99,
        popularity: 190,
      ),
    ];
  }

  List<ProductModel> getProductsByCollection(String collectionId,
      {String? sortBy}) {
    var products = getAllProducts()
        .where((product) => product.collectionId == collectionId)
        .toList();

    if (sortBy != null) {
      switch (sortBy) {
        case 'popularity':
          products.sort((a, b) => b.popularity.compareTo(a.popularity));
          break;
        case 'name':
          products.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'price_low':
          products.sort((a, b) => a.displayPrice.compareTo(b.displayPrice));
          break;
        case 'price_high':
          products.sort((a, b) => b.displayPrice.compareTo(a.displayPrice));
          break;
        case 'newest':
          products.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
          break;
      }
    }

    return products;
  }

  ProductModel? getProductById(String productId) {
    try {
      return getAllProducts().firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  List<ProductModel> getSaleProducts() {
    return getAllProducts().where((product) => product.isOnSale).toList();
  }
}

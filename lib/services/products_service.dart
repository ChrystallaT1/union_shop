import 'package:union_shop/models/product_model.dart';

class ProductsService {
  static final ProductsService _instance = ProductsService._internal();
  factory ProductsService() => _instance;
  ProductsService._internal();

  List<ProductModel> getAllProducts() {
    return [
      // ========== HOODIES ==========
      ProductModel(
        id: 'hoodie_sport_navy',
        name: 'UPSU Sport Hoodie - Navy',
        description:
            'Comfortable navy hoodie perfect for sports and casual wear.',
        price: 35.00,
        imageUrl: 'assets/images/products/hoodie_sport_navy.png',
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
        imageUrl: 'assets/images/products/hoodie_sport_grey.png',
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
            'Comfortable black hoodie perfect for sports and casual wear.',
        price: 35.00,
        imageUrl: 'assets/images/products/hoodie_sport_black.png',
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

      ProductModel(
        id: 'hoodie_upsu_navy',
        name: 'UPSU Classic Hoodie - Navy',
        description: 'Classic navy pullover hoodie with bold UPSU text.',
        price: 32.99,
        imageUrl: 'assets/images/products/hoodie_upsu_navy.png',
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
            'Sleek black pullover hoodie with prominent UPSU branding.',
        price: 32.99,
        imageUrl: 'assets/images/products/hoodie_upsu_black.png',
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
        description: 'Versatile grey pullover hoodie with UPSU text.',
        price: 32.99,
        imageUrl: 'assets/images/products/hoodie_upsu_grey.png',
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

      ProductModel(
        id: 'hoodie_portsmouth_navy',
        name: 'University of Portsmouth Zip Hoodie - Navy',
        description:
            'Premium navy zip-up hoodie featuring full University text.',
        price: 42.99,
        imageUrl: 'assets/images/products/hoodie_portsmouth_navy.png',
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
            'Distinctive burgundy zip-up hoodie with University branding.',
        price: 42.99,
        imageUrl: 'assets/images/products/hoodie_portsmouth_burgundy.png',
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

      // ========== T-SHIRTS ==========

      ProductModel(
        id: 'tshirt_upsu_sports_black',
        name: 'UPSU Sports T-Shirt - Black',
        description: 'Classic black t-shirt with UPSU Sports branding.',
        price: 18.99,
        imageUrl: 'assets/images/products/tshirt_upsu_sports_black.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Black', 'Navy', 'Grey'],
        stockQuantity: 60,
        dateAdded: DateTime.now().subtract(const Duration(days: 10)),
        isOnSale: false,
        salePrice: null,
        popularity: 250,
      ),

      ProductModel(
        id: 'tshirt_upsu_sports_navy',
        name: 'UPSU Sports T-Shirt - Navy',
        description: 'Navy blue athletic t-shirt featuring UPSU Sports logo.',
        price: 18.99,
        imageUrl: 'assets/images/products/tshirt_upsu_sports_navy.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Black', 'Navy', 'Grey'],
        stockQuantity: 55,
        dateAdded: DateTime.now().subtract(const Duration(days: 10)),
        isOnSale: true,
        salePrice: 15.99,
        popularity: 280,
      ),

      ProductModel(
        id: 'tshirt_upsu_sports_grey',
        name: 'UPSU Sports T-Shirt - Grey',
        description: 'Versatile grey marl t-shirt with UPSU Sports text.',
        price: 18.99,
        imageUrl: 'assets/images/products/tshirt_upsu_sports_grey.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Black', 'Navy', 'Grey'],
        stockQuantity: 50,
        dateAdded: DateTime.now().subtract(const Duration(days: 10)),
        isOnSale: false,
        salePrice: null,
        popularity: 230,
      ),

      ProductModel(
        id: 'tshirt_portsmouth_full_purple',
        name: 'University of Portsmouth T-Shirt - Purple',
        description:
            'Premium purple t-shirt featuring full University of Portsmouth text. Show your university pride in style.',
        price: 21.99,
        imageUrl: 'assets/images/products/tshirt_portsmouth_full_purple.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Purple', 'White'],
        stockQuantity: 40,
        dateAdded: DateTime.now().subtract(const Duration(days: 3)),
        isOnSale: false,
        salePrice: null,
        popularity: 270,
      ),

      ProductModel(
        id: 'tshirt_portsmouth_full_white',
        name: 'University of Portsmouth T-Shirt - White',
        description:
            'Classic white t-shirt with University of Portsmouth branding. Versatile design perfect for any occasion.',
        price: 21.99,
        imageUrl: 'assets/images/products/tshirt_portsmouth_full_white.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Purple', 'White'],
        stockQuantity: 45,
        dateAdded: DateTime.now().subtract(const Duration(days: 3)),
        isOnSale: true,
        salePrice: 18.99,
        popularity: 290,
      ),

      ProductModel(
        id: 'tshirt_portsmouth_white',
        name: 'Portsmouth T-Shirt - White',
        description:
            'Clean white t-shirt with Portsmouth arch text. Simple and stylish university wear.',
        price: 19.99,
        imageUrl: 'assets/images/products/tshirt_portsmouth_white.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Navy', 'Grey'],
        stockQuantity: 55,
        dateAdded: DateTime.now().subtract(const Duration(days: 7)),
        isOnSale: false,
        salePrice: null,
        popularity: 260,
      ),

      ProductModel(
        id: 'tshirt_portsmouth_navy',
        name: 'Portsmouth T-Shirt - Navy',
        description:
            'Navy blue t-shirt featuring Portsmouth arch logo. Classic university style in official colors.',
        price: 19.99,
        imageUrl: 'assets/images/products/tshirt_portsmouth_navy.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Navy', 'Grey'],
        stockQuantity: 50,
        dateAdded: DateTime.now().subtract(const Duration(days: 7)),
        isOnSale: false,
        salePrice: null,
        popularity: 300,
      ),

      ProductModel(
        id: 'tshirt_portsmouth_grey',
        name: 'Portsmouth T-Shirt - Grey',
        description:
            'Grey marl t-shirt with Portsmouth text. Comfortable everyday wear with university branding.',
        price: 19.99,
        imageUrl: 'assets/images/products/tshirt_portsmouth_grey.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Navy', 'Grey'],
        stockQuantity: 48,
        dateAdded: DateTime.now().subtract(const Duration(days: 7)),
        isOnSale: true,
        salePrice: 16.99,
        popularity: 240,
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

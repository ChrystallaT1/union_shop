import 'package:union_shop/models/product_model.dart';

class ProductsService {
  static final ProductsService _instance = ProductsService._internal();
  factory ProductsService() => _instance;
  ProductsService._internal();

  List<ProductModel> getAllProducts() {
    return [
      // Navy Hoodie
      ProductModel(
        id: 'hoodie_sport_navy',
        name: 'UPSU Sport Hoodie - Navy',
        description:
            'Comfortable navy hoodie perfect for sports and casual wear. Features the iconic UPSU Sport logo.',
        price: 34.99,
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
        popularity: 10,
      ),

      // Grey Hoodie
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

      // Black Hoodie
      ProductModel(
        id: 'hoodie_sport_black',
        name: 'UPSU Sport Hoodie - Black',
        description:
            'Comfortable black hoodie perfect for sports and casual wear. Features the iconic UPSU Sport logo.',
        price: 34.99,
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
        popularity: 10,
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

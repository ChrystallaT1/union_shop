import 'package:union_shop/models/product_model.dart';

class ProductsService {
  Stream<List<ProductModel>> getProductsByCollection(
    String collectionId, {
    String sortBy = 'name',
    bool ascending = true,
  }) async* {
    List<ProductModel> products = _getFakeProducts(collectionId);

    if (sortBy == 'name') {
      products.sort((a, b) =>
          ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    } else if (sortBy == 'price') {
      products.sort((a, b) => ascending
          ? a.displayPrice.compareTo(b.displayPrice)
          : b.displayPrice.compareTo(a.displayPrice));
    } else if (sortBy == 'popularity') {
      products.sort((a, b) => ascending
          ? a.popularity.compareTo(b.popularity)
          : b.popularity.compareTo(a.popularity));
    } else if (sortBy == 'dateAdded') {
      products.sort((a, b) => ascending
          ? a.dateAdded.compareTo(b.dateAdded)
          : b.dateAdded.compareTo(a.dateAdded));
    }

    yield products;
  }

  ProductModel? getProductById(String productId) {
    final allProducts = _getAllFakeProducts();
    try {
      return allProducts.firstWhere((p) => p.id == productId);
    } catch (e) {
      return null;
    }
  }

  List<ProductModel> _getFakeProducts(String collectionId) {
    return _getAllFakeProducts()
        .where(
            (p) => p.collectionId.toLowerCase() == collectionId.toLowerCase())
        .toList();
  }

  List<ProductModel> _getAllFakeProducts() {
    return [
      // Hoodies Collection
      ProductModel(
        id: 'hoodie-1',
        name: 'Classic UPSU Hoodie',
        description: 'Comfortable cotton hoodie with university branding',
        price: 39.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Navy', 'Black', 'Grey'],
        stockQuantity: 50,
        dateAdded: DateTime.now().subtract(const Duration(days: 30)),
        isOnSale: true,
        salePrice: 29.99,
        popularity: 150,
      ),
      ProductModel(
        id: 'hoodie-2',
        name: 'Portsmouth University Zip Hoodie',
        description: 'Premium zip-up hoodie with embroidered logo',
        price: 44.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Navy', 'Burgundy'],
        stockQuantity: 35,
        dateAdded: DateTime.now().subtract(const Duration(days: 25)),
        popularity: 85,
      ),
      ProductModel(
        id: 'hoodie-3',
        name: 'UPSU Sport Hoodie',
        description: 'Lightweight athletic hoodie perfect for sports',
        price: 34.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['Black', 'Grey', 'Navy'],
        stockQuantity: 40,
        dateAdded: DateTime.now().subtract(const Duration(days: 20)),
        popularity: 120,
      ),

      // T-Shirts Collection
      ProductModel(
        id: 'tshirt-1',
        name: 'Portsmouth University T-Shirt',
        description: 'Classic cotton t-shirt with university crest',
        price: 19.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        collectionId: 't-shirts',
        category: 'clothing',
        sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Navy', 'Black'],
        stockQuantity: 100,
        dateAdded: DateTime.now().subtract(const Duration(days: 35)),
        isOnSale: true,
        salePrice: 14.99,
        popularity: 200,
      ),
      ProductModel(
        id: 'tshirt-2',
        name: 'UPSU Sports T-Shirt',
        description: 'Performance fabric t-shirt for active wear',
        price: 24.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        collectionId: 't-shirts',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Navy', 'Black', 'Grey'],
        stockQuantity: 75,
        dateAdded: DateTime.now().subtract(const Duration(days: 30)),
        popularity: 95,
      ),
      ProductModel(
        id: 'tshirt-3',
        name: 'Vintage Portsmouth Tee',
        description: 'Retro style t-shirt with vintage design',
        price: 22.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        collectionId: 't-shirts',
        category: 'clothing',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Grey', 'Navy'],
        stockQuantity: 60,
        dateAdded: DateTime.now().subtract(const Duration(days: 28)),
        popularity: 110,
      ),

      // Accessories Collection
      ProductModel(
        id: 'acc-1',
        name: 'UPSU Backpack',
        description: 'Durable backpack with multiple compartments',
        price: 34.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        collectionId: 'accessories',
        category: 'accessories',
        sizes: ['One Size'],
        colors: ['Navy', 'Black'],
        stockQuantity: 45,
        dateAdded: DateTime.now().subtract(const Duration(days: 22)),
        isOnSale: true,
        salePrice: 24.99,
        popularity: 75,
      ),
      ProductModel(
        id: 'acc-2',
        name: 'University Cap',
        description: 'Adjustable baseball cap with embroidered logo',
        price: 14.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        collectionId: 'accessories',
        category: 'accessories',
        sizes: ['One Size'],
        colors: ['Navy', 'Black', 'Grey'],
        stockQuantity: 80,
        dateAdded: DateTime.now().subtract(const Duration(days: 18)),
        popularity: 140,
      ),
      ProductModel(
        id: 'acc-3',
        name: 'UPSU Water Bottle',
        description: 'Insulated water bottle keeps drinks cold for 24hrs',
        price: 12.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        collectionId: 'accessories',
        category: 'accessories',
        sizes: ['500ml'],
        colors: ['Navy', 'Black', 'White'],
        stockQuantity: 90,
        dateAdded: DateTime.now().subtract(const Duration(days: 15)),
        popularity: 160,
      ),

      // Stationery Collection
      ProductModel(
        id: 'stat-1',
        name: 'University Notebook Set',
        description: 'Set of 3 A4 notebooks with university branding',
        price: 7.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        collectionId: 'stationery',
        category: 'stationery',
        sizes: ['A4'],
        colors: ['Navy', 'Black'],
        stockQuantity: 120,
        dateAdded: DateTime.now().subtract(const Duration(days: 40)),
        isOnSale: true,
        salePrice: 5.99,
        popularity: 180,
      ),
      ProductModel(
        id: 'stat-2',
        name: 'UPSU Pen Set',
        description: 'Premium ballpoint pen set with case',
        price: 8.99,
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        collectionId: 'stationery',
        category: 'stationery',
        sizes: ['Standard'],
        colors: ['Navy', 'Black'],
        stockQuantity: 150,
        dateAdded: DateTime.now().subtract(const Duration(days: 35)),
        popularity: 90,
      ),
    ];
  }
}

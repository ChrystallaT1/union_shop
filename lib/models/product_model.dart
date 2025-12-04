import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String collectionId;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final int stockQuantity;
  final DateTime dateAdded;
  final bool isOnSale;
  final double? salePrice;
  final int popularity;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.collectionId,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.stockQuantity,
    required this.dateAdded,
    this.isOnSale = false,
    this.salePrice,
    this.popularity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0.0,
      collectionId: json['collectionId'] ?? '',
      category: json['category'] ?? '',
      sizes: json['sizes'] ?? [],
      colors: json['colors'] ?? [],
      stockQuantity: json['stockQuantity'] ?? 0,
      dateAdded: json['dateAdded'] ?? DateTime.now(),
      isOnSale: json['isOnSale'] ?? false,
      salePrice: json['salePrice'] ?? null,
      popularity: json['popularity'] ?? 0,
    );
  }

  double get displayPrice => isOnSale && salePrice != null ? salePrice! : price;

  String get discountPercentage {
    if (!isOnSale || salePrice == null) return '';
    final discount = ((price - salePrice!) / price * 100).round();
    return '$discount% OFF';
  }

  static fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}
}

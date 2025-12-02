import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int productCount;
  final DateTime dateAdded;
  final String category;

  CollectionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.productCount,
    required this.dateAdded,
    required this.category,
  });

  // Convert from Firestore document
  factory CollectionModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CollectionModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      productCount: data['productCount'] ?? 0,
      dateAdded: (data['dateAdded'] as Timestamp).toDate(),
      category: data['category'] ?? 'general',
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'productCount': productCount,
      'dateAdded': Timestamp.fromDate(dateAdded),
      'category': category,
    };
  }
}

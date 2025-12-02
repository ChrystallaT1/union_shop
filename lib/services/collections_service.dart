import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_shop/models/collection_model.dart';

class CollectionsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'collections';

  // Get collections with sorting
  Stream<List<CollectionModel>> getCollectionsSorted(
      String sortBy, bool ascending) {
    Query query = _firestore.collection(_collectionPath);

    query = query.orderBy(sortBy, descending: !ascending);

    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => CollectionModel.fromFirestore(
                  doc.data() as Map<String, dynamic>, doc.id))
              .toList(),
        );
  }

  // Add sample collections (for testing)
  Future<void> addSampleCollections() async {
    final collections = [
      {
        'name': 'Hoodies',
        'description': 'Comfortable hoodies for all seasons',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        'productCount': 12,
        'dateAdded': Timestamp.now(),
        'category': 'clothing',
      },
      {
        'name': 'T-Shirts',
        'description': 'Stylish t-shirts for everyday wear',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        'productCount': 20,
        'dateAdded': Timestamp.now(),
        'category': 'clothing',
      },
      {
        'name': 'Accessories',
        'description': 'Complete your look with our accessories',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        'productCount': 15,
        'dateAdded': Timestamp.now(),
        'category': 'accessories',
      },
      {
        'name': 'Stationery',
        'description': 'University branded stationery items',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        'productCount': 8,
        'dateAdded': Timestamp.now(),
        'category': 'stationery',
      },
      {
        'name': 'Bags',
        'description': 'Carry your essentials in style',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        'productCount': 10,
        'dateAdded': Timestamp.now(),
        'category': 'accessories',
      },
      {
        'name': 'Drinkware',
        'description': 'Mugs, bottles, and more',
        'imageUrl':
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        'productCount': 18,
        'dateAdded': Timestamp.now(),
        'category': 'accessories',
      },
    ];

    for (var collection in collections) {
      await _firestore.collection(_collectionPath).add(collection);
    }
  }
}

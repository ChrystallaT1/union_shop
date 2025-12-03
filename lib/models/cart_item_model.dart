import 'package:union_shop/models/personalization_model.dart';

class CartItemModel {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final String selectedSize;
  final String selectedColor;
  int quantity;
  final PersonalizationModel? personalization;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
    this.personalization,
  });

  double get totalPrice =>
      (price + (personalization?.additionalCost ?? 0.0)) * quantity;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'quantity': quantity,
      'personalization': personalization?.toJson(),
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      price: json['price'],
      selectedSize: json['selectedSize'],
      selectedColor: json['selectedColor'],
      quantity: json['quantity'],
      personalization: json['personalization'] != null
          ? PersonalizationModel.fromJson(json['personalization'])
          : null,
    );
  }

  CartItemModel copyWith({
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
    PersonalizationModel? personalization,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
      personalization: personalization ?? this.personalization,
    );
  }
}

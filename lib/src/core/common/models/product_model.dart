import 'dart:convert';

import 'food_enums.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String title;
  final int price;
  final int protein;
  final int fats;
  final int carbs;
  final int ccal;
  final ProductGroup productGroup;
  final int quantity;
  final FishType? fishType;
  final ProteinType? proteinType;
  final MeatType? meatType;

  Product({
    required this.title,
    required this.price,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.ccal,
    required this.productGroup,
    required this.quantity,
    this.fishType,
    this.proteinType,
    this.meatType,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.title == title && other.price == price;
  }

  @override
  int get hashCode => title.hashCode ^ price.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'protein': protein,
      'fats': fats,
      'carbs': carbs,
      'ccal': ccal,
      'productGroup': 'temp',
      'quantity': quantity,
      // 'fishType': fishType?.toMap(),
      // 'proteinType': proteinType?.toMap(),
      // 'meatType': meatType?.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String,
      price: map['price'] as int,
      protein: map['protein'] as int,
      fats: map['fats'] as int,
      carbs: map['carbs'] as int,
      ccal: map['ccal'] as int,
      productGroup: ProductGroup.addedFatsNutsSeedsAndOilyFruits,
      // ProductGroupExtension.fromMap(
      //   map['productGroup'] as String,
      // ),
      fishType:
          map['fishType'] != null
              ? FishTypeExtension.fromMap(map['fishType'] as String)
              : null,
      proteinType:
          map['proteinType'] != null
              ? ProteinTypeExtension.fromMap(map['proteinType'] as String)
              : null,
      meatType:
          map['meatType'] != null
              ? MeatTypeExtension.fromMap(map['meatType'] as String)
              : null,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Product copyWith({
    String? title,
    int? price,
    int? protein,
    int? fats,
    int? carbs,
    int? ccal,
    ProductGroup? productGroup,
    FishType? fishType,
    ProteinType? proteinType,
    MeatType? meatType,
    int? quantity,
  }) {
    return Product(
      title: title ?? this.title,
      price: price ?? this.price,
      protein: protein ?? this.protein,
      productGroup: productGroup ?? this.productGroup,
      fats: fats ?? this.fats,
      carbs: carbs ?? this.carbs,
      ccal: ccal ?? this.ccal,
      fishType: fishType ?? this.fishType,
      proteinType: proteinType ?? this.proteinType,
      meatType: meatType ?? this.meatType,
      quantity: quantity ?? this.quantity,
    );
  }
}

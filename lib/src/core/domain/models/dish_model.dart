// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'product_model.dart';

class Dish {
  final String title;
  final List<Product> products;
  final int calories;
  final Set<String> restrictions;
  final int totalPrice;
  final List<Product> missingProducts;
  final int protein;
  final int fats;
  final int carbs;
  final int? totalMissingCost;

  const Dish({
    required this.title,
    required this.products,
    required this.calories,
    required this.restrictions,
    required this.totalPrice,
    required this.missingProducts,
    required this.protein,
    required this.fats,
    required this.carbs,
    this.totalMissingCost,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'products': products.map((x) => x.toMap()).toList(),
      'calories': calories,
      'restrictions': restrictions.toList(),
      'totalPrice': totalPrice,
      'missingProducts': missingProducts,
      'totalMissingCost': totalMissingCost,
      'protein': protein,
      'fats': fats,
      'carbs': carbs,
    };
  }

  @override
  String toString() {
    return 'Dish(title: $title, '
        'products: ${products.map((p) => p.toString()).join(", ")}, '
        'calories: $calories, '
        'restrictions: ${restrictions.join(", ")}, '
        'totalPrice: $totalPrice, '
        'missingProducts: ${missingProducts.map((p) => p.toString()).join(", ")}, '
        'protein: $protein, '
        'fats: $fats, '
        'carbs: $carbs, '
        'totalMissingCost: $totalMissingCost)';
  }

  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      title: map['title'] as String,
      products: List<Product>.from(
        (map['products'] as List<dynamic>)
            .map((x) => Product.fromMap(x as Map<String, dynamic>)),
      ),
      calories: map['calories'] as int,
      restrictions: Set<String>.from(map['restrictions'] as List<dynamic>),
      totalPrice: map['totalPrice'] as int,
      missingProducts: map['missingProducts'] != null
          ? List<Product>.from(
              (map['missingProducts'] as List<dynamic>)
                  .map((x) => Product.fromMap(x as Map<String, dynamic>)),
            )
          : [],
      totalMissingCost: map['totalMissingCost'] as int?,
      protein: map['protein'] as int,
      fats: map['fats'] as int,
      carbs: map['carbs'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dish.fromJson(String source) =>
      Dish.fromMap(json.decode(source) as Map<String, dynamic>);

  Dish copyWith({
    String? title,
    List<Product>? products,
    int? calories,
    Set<String>? restrictions,
    List<int>? pfc,
    int? totalPrice,
    List<Product>? missingProducts,
    int? totalMissingCost,
    int? protein,
    int? fats,
    int? carbs,
    int? ccal,
  }) {
    return Dish(
      title: title ?? this.title,
      products: products ?? this.products,
      calories: calories ?? this.calories,
      restrictions: restrictions ?? this.restrictions,
      totalPrice: totalPrice ?? this.totalPrice,
      missingProducts: missingProducts ?? this.missingProducts,
      totalMissingCost: totalMissingCost ?? this.totalMissingCost,
      protein: protein ?? this.protein,
      fats: fats ?? this.fats,
      carbs: carbs ?? this.carbs,
    );
  }
}

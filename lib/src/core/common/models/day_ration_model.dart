// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'dish_model.dart';

class DayRation {
  final DateTime? day;
  final int? dayIndex;
  final Dish? morningDish;
  final bool? morningEaten;
  final Dish? lunchDish;
  final bool? lunchEaten;
  final Dish? snackDish;
  final bool? snackEaten;
  final Dish? dinnerDish;
  final bool? dinnerEaten;
  final int? totalCcal;

  const DayRation({
    this.day,
    this.dayIndex,
    this.dinnerEaten = false,
    this.morningEaten = false,
    this.lunchEaten = false,
    this.snackEaten = false,
    this.morningDish,
    this.lunchDish,
    this.snackDish,
    this.dinnerDish,
    this.totalCcal,
  });

  @override
  String toString() {
    return 'Day: $day, ccal: $totalCcal';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is! DayRation) return false;

    return other.day == day &&
        other.dayIndex == dayIndex &&
        other.morningEaten == morningEaten &&
        other.lunchEaten == lunchEaten &&
        other.dinnerEaten == dinnerEaten &&
        other.snackEaten == snackEaten &&
        other.morningDish == morningDish &&
        other.lunchDish == lunchDish &&
        other.snackDish == snackDish &&
        other.dinnerDish == dinnerDish &&
        other.totalCcal == totalCcal;
  }

  @override
  int get hashCode {
    return day.hashCode ^
        dayIndex.hashCode ^
        morningDish.hashCode ^
        lunchDish.hashCode ^
        snackEaten.hashCode ^
        morningEaten.hashCode ^
        lunchEaten.hashCode ^
        dinnerEaten.hashCode ^
        snackDish.hashCode ^
        dinnerDish.hashCode ^
        totalCcal.hashCode;
  }

  DayRation copyWith({
    final DateTime? day,
    final int? dayIndex,
    final bool? morningEaten,
    final bool? lunchEaten,
    final bool? snackEaten,
    final bool? dinnerEaten,
    final Dish? morningDish,
    final Dish? lunchDish,
    final Dish? snackDish,
    final Dish? dinnerDish,
    final int? totalCcal,
  }) {
    return DayRation(
      day: day ?? this.day,
      dayIndex: dayIndex ?? this.dayIndex,
      morningEaten: morningEaten ?? this.morningEaten,
      lunchEaten: lunchEaten ?? this.lunchEaten,
      snackEaten: snackEaten ?? this.snackEaten,
      dinnerEaten: dinnerEaten ?? this.dinnerEaten,
      morningDish: morningDish ?? this.morningDish,
      lunchDish: lunchDish ?? this.lunchDish,
      snackDish: snackDish ?? this.snackDish,
      dinnerDish: dinnerDish ?? this.dinnerDish,
      totalCcal: totalCcal ?? this.totalCcal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day?.millisecondsSinceEpoch,
      'dayIndex': dayIndex,
      'morningEaten': morningEaten,
      'lunchEaten': lunchEaten,
      'snackEaten': snackEaten,
      'dinnerEaten': dinnerEaten,
      'morningDish': morningDish?.toMap(),
      'lunchDish': lunchDish?.toMap(),
      'snackDish': snackDish?.toMap(),
      'dinnerDish': dinnerDish?.toMap(),
      'totalCcal': totalCcal,
    };
  }

  factory DayRation.fromMap(Map<String, dynamic> map) {
    final day =
        map['day'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['day'] as int)
            : null;
    final morningEaten =
        map['morningEaten'] != null ? map['morningEaten'] as bool : null;
    final lunchEaten =
        map['lunchEaten'] != null ? map['lunchEaten'] as bool : null;
    final snackEaten =
        map['snackEaten'] != null ? map['snackEaten'] as bool : null;
    final dinnerEaten =
        map['dinnerEaten'] != null ? map['dinnerEaten'] as bool : null;
    final dayIndex = map['dayIndex'] != null ? map['dayIndex'] as int : null;
    final morningDish =
        map['morningDish'] != null
            ? Dish.fromMap(map['morningDish'] as Map<String, dynamic>)
            : null;
    final lunchDish =
        map['lunchDish'] != null
            ? Dish.fromMap(map['lunchDish'] as Map<String, dynamic>)
            : null;
    final snackDish =
        map['snackDish'] != null
            ? Dish.fromMap(map['snackDish'] as Map<String, dynamic>)
            : null;
    final dinnerDish =
        map['dinnerDish'] != null
            ? Dish.fromMap(map['dinnerDish'] as Map<String, dynamic>)
            : null;
    final totalCcal = map['totalCcal'] != null ? map['totalCcal'] as int : null;

    return DayRation(
      day: day,
      dayIndex: dayIndex,
      morningEaten: morningEaten,
      lunchEaten: lunchEaten,
      snackEaten: snackEaten,
      dinnerEaten: dinnerEaten,
      morningDish: morningDish,
      lunchDish: lunchDish,
      snackDish: snackDish,
      dinnerDish: dinnerDish,
      totalCcal: totalCcal,
    );
  }
  String toJson() => json.encode(toMap());

  factory DayRation.fromJson(String source) =>
      DayRation.fromMap(json.decode(source) as Map<String, dynamic>);
}

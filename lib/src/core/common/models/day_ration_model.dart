// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'dish_model.dart';

class DayRation {
  final DateTime? day;
  final int? dayIndex;
  final Dish? morningDish;
  final Dish? lunchDish;
  final Dish? snackDish;
  final Dish? dinnerDish;
  final int? totalCcal;

  const DayRation({
    this.day,
    this.dayIndex,
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
        snackDish.hashCode ^
        dinnerDish.hashCode ^
        totalCcal.hashCode;
  }

  DayRation copyWith({
    DateTime? day,
    int? dayIndex,
    Dish? morningDish,
    Dish? lunchDish,
    Dish? snackDish,
    Dish? dinnerDish,
    int? totalCcal,
  }) {
    return DayRation(
      day: day ?? this.day,
      dayIndex: dayIndex ?? this.dayIndex,
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
      'morningDish': morningDish?.toMap(),
      'lunchDish': lunchDish?.toMap(),
      'snackDish': snackDish?.toMap(),
      'dinnerDish': dinnerDish?.toMap(),
      'totalCcal': totalCcal,
    };
  }

  factory DayRation.fromMap(Map<String, dynamic> map) {
    return DayRation(
      day:
          map['day'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['day'] as int)
              : null,
      dayIndex: map['dayIndex'] != null ? map['dayIndex'] as int : null,
      morningDish:
          map['morningDish'] != null
              ? Dish.fromMap(map['morningDish'] as Map<String, dynamic>)
              : null,
      lunchDish:
          map['lunchDish'] != null
              ? Dish.fromMap(map['lunchDish'] as Map<String, dynamic>)
              : null,
      snackDish:
          map['snackDish'] != null
              ? Dish.fromMap(map['snackDish'] as Map<String, dynamic>)
              : null,
      dinnerDish:
          map['dinnerDish'] != null
              ? Dish.fromMap(map['dinnerDish'] as Map<String, dynamic>)
              : null,
      totalCcal: map['totalCcal'] != null ? map['totalCcal'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DayRation.fromJson(String source) =>
      DayRation.fromMap(json.decode(source) as Map<String, dynamic>);
}

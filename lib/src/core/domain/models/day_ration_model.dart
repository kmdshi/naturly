// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dish_model.dart';

class DayRation {
  final String? day;
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

  DayRation copyWith({
    String? day,
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
}

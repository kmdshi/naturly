// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dish_model.dart';

class DayRation {
  final String day;
  final Dish morningDish;
  final Dish lunchDish;
  final Dish snackDish;
  final Dish dinnerDish;
  final int totalCcal;

  const DayRation({
    required this.day,
    required this.morningDish,
    required this.lunchDish,
    required this.snackDish,
    required this.dinnerDish,
    required this.totalCcal,
  });

  @override
  String toString() {
    return 'Day: $day, ccal: $totalCcal';
  }
}

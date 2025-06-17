import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Human {
  final String nickName;
  final int age;
  final String sex;
  final int height;
  final int weight;
  final String goal;
  final String activityLevel;
  final Set<String> restrictions;
  late final double activityMultiplier;

  Human({
    required this.nickName,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.restrictions,
    required this.sex,
    required this.activityLevel,
  }) {
    activityMultiplier = _calculateActivityMultiplier();
  }

  double _calculateActivityMultiplier() {
    switch (activityLevel) {
      case 'Sedentary':
        return 1.2;
      case 'Lightly active':
        return 1.375;
      case 'Moderately active':
        return 1.55;
      case 'Very active':
        return 1.725;
      case 'Extra active':
        return 1.9;
      default:
        throw AssertionError('activityLevel isn\'t provided');
    }
  }

  double calculateBMR() {
    double bmr;

    if (sex.toLowerCase() == 'male') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    return bmr;
  }

  double calculateTDEE() {
    double bmr = calculateBMR();
    return bmr * activityMultiplier;
  }

  /*
    Очень низкая активность- 1.2
    Низкая активность - 1.375
    Умеренная активность - 1.55
    Высокая активность - 1.725
    Очень высокая активность  - 1.9
  */

  double calculateDayCalories() {
    double tdee = calculateTDEE();

    switch (goal) {
      case 'gain':
        return tdee + 500;
      case 'lose':
        return tdee - 500;
      case 'maintain':
        return tdee;
      default:
        return tdee;
    }
  }

  Map<String, double> calculateDayMacronutrients() {
    double totalCalories = calculateDayCalories();

    double proteinCalories = totalCalories * 0.25;
    double fatsCalories = totalCalories * 0.30;
    double carbsCalories = totalCalories * 0.45;

    double proteinGrams = proteinCalories / 4;
    double fatsGrams = fatsCalories / 9;
    double carbsGrams = carbsCalories / 4;

    return {'protein': proteinGrams, 'fats': fatsGrams, 'carbs': carbsGrams};
  }

  double calculateWeeklyCalories() {
    return calculateDayCalories() * 7;
  }

  Map<String, double> calculateWeeklyMacronutrients() {
    final dayMacroNutrients = calculateDayMacronutrients();
    return {
      'protein': dayMacroNutrients["protein"]! * 7,
      'fats': dayMacroNutrients["fats"]! * 7,
      'carbs': dayMacroNutrients["carbs"]! * 7,
    };
  }

  double calculateBMI() {
    return weight / ((height / 100) * (height / 100));
  }

  bool hasRestriction(String restriction) {
    return restrictions.contains(restriction);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickName,
      'age': age,
      'sex': sex,
      'height': height,
      'weight': weight,
      'goal': goal,
      'activityLevel': activityLevel,
      'restrictions': restrictions.toList(),
      'activityMultiplier': activityMultiplier,
    };
  }

  String toJson() => json.encode(toMap());

  factory Human.fromMap(Map<String, dynamic> map) {
    return Human(
      nickName: map['nickname'] as String,
      age: map['age'] as int,
      sex: map['sex'] as String,
      height: map['height'] as int,
      weight: map['weight'] as int,
      goal: map['goal'] as String,
      activityLevel: map['activityLevel'] as String,
      restrictions: Set<String>.from(map['restrictions'] as List),
    );
  }

  factory Human.fromJson(String source) =>
      Human.fromMap(json.decode(source) as Map<String, dynamic>);
}

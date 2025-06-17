import 'package:equatable/equatable.dart';
import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/week_ration_dto.dart';

class WeekRation extends Equatable {
  final String shareId;
  final List<DayRation> foodData;

  WeekRation({required this.shareId, required this.foodData});

  factory WeekRation.fromDto(WeekRationDto dto) {
    final parsedDays =
        dto.foodData.map((json) => DayRation.fromMap(json)).toList();

    return WeekRation(shareId: dto.shareId, foodData: parsedDays);
  }

  factory WeekRation.empty() {
    return WeekRation(shareId: '', foodData: []);
  }

  @override
  List<Object?> get props => [shareId, foodData];
}

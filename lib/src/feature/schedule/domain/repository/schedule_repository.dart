import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/human_profile.dart';
import 'package:naturly/src/core/common/models/week_ration.dart';

abstract class ScheduleRepository {
  Future<DayRation> generateDayRation(String day, int dayIndex, Human person);
  Future<List<DayRation>> generateWeekRation(Human person);
  Future<WeekRation> getWeekUserRation();
  Future<List<WeekRation>> getAllWeeksUserRation();
  Future<String> addUserRation(List<DayRation> ration);
}

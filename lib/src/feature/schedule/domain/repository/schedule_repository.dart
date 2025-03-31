import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/human_profile.dart';

abstract class ScheduleRepository {
  Future<DayRation> generateDayRation(String day, int dayIndex, Human person);
  Future<List<DayRation>> generateWeekRation(Human person);
  Future<List<DayRation>> getUserRation();
  Future<void> addUserRation(List<DayRation> ration);
}

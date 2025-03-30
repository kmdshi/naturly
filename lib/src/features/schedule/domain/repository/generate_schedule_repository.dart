import 'package:naturly/src/features/schedule/domain/models/day_ration_model.dart';
import 'package:naturly/src/features/schedule/domain/models/human_profile.dart';

abstract class GenerateScheduleRepository {
  Future<DayRation> generateDayRation(
    String day,
    int dayIndex,
    Human person,
  );
  Future<List<DayRation>> generateWeekRation(
    Human person,
  );
}

import 'package:naturly/src/feature/share_meal/domain/models/week_ration_wrapper.dart';

abstract class ShareMealRepository {
  Future<WeekRationWrapper> getAnotherWeekRation(String weekId);
}

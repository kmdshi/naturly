// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:naturly/src/feature/share_meal/data/datasource/supabase_datasource.dart';
import 'package:naturly/src/feature/share_meal/domain/models/week_ration_wrapper.dart';
import 'package:naturly/src/feature/share_meal/domain/repository/share_meal_repository.dart';

class ShareMealRepositoryImpl implements ShareMealRepository {
  final ShareMealSupabaseRemoteDs scheduleRemoteDs;
  ShareMealRepositoryImpl({required this.scheduleRemoteDs});

  @override
  Future<WeekRationWrapper> getAnotherWeekRation(String week_key) async {
    final Map<String, dynamic> weekRationDto = await scheduleRemoteDs
        .getAnotherWeekRation(week_key);

    return WeekRationWrapper.fromDto(weekRationDto);
  }
}

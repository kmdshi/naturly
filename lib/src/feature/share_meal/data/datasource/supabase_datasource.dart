import 'package:naturly/src/core/common/models/week_ration_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShareMealSupabaseRemoteDs {
  final SupabaseClient supabase;
  ShareMealSupabaseRemoteDs({required this.supabase});

  Future<Map<String, dynamic>> getAnotherWeekRation(String weekKey) async {
    try {
      final response =
          await supabase
              .from('Rations')
              .select('usid, food_data')
              .eq('share_id', weekKey)
              .maybeSingle();

      if (response == null) throw Exception('Рацион не найден');

      final foodDataRaw = response['food_data'];
      final weekRation = List<Map<String, dynamic>>.from(foodDataRaw ?? []);

      final usId = response['usid'];
      if (usId == null) throw Exception('ID пользователя не найден');

      final profileResponse =
          await supabase
              .from('Profiles')
              .select('nickname')
              .eq('id', usId)
              .maybeSingle();

      final sharedBy = profileResponse?['nickname'] ?? 'Неизвестный';

      final weekShareKey = response['share_id'] ?? '';

      return {
        'ration': WeekRationDto(shareId: weekShareKey, foodData: weekRation),
        'shared_by': sharedBy,
      };
    } catch (e) {
      throw Exception('Ошибка при загрузке рациона: $e');
    }
  }
}

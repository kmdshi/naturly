// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:naturly/src/core/common/models/week_ration.dart';

class WeekRationWrapper {
  final WeekRation ration;

  final String sharedBy;
  WeekRationWrapper({required this.ration, required this.sharedBy});

  factory WeekRationWrapper.fromDto(Map<String, dynamic> dto) {
    return WeekRationWrapper(
      ration: WeekRation.fromDto(dto['ration']),
      sharedBy: dto['shared_by'] as String,
    );
  }
}

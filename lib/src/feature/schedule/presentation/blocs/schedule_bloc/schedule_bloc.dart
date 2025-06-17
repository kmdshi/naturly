// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:naturly/src/core/common/extensions/datetime_extension.dart';

import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/human_profile.dart';
import 'package:naturly/src/core/common/models/week_ration.dart';
import 'package:naturly/src/feature/schedule/domain/repository/schedule_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;
  ScheduleBloc({required this.scheduleRepository}) : super(ScheduleInitial()) {
    on<ScheduleGenerateDayRation>(_generateDayRation);
    on<ScheduleGenerateWeekRation>(_generateWeekRation);
    on<ScheduleSaveUserRation>(_saveRation);
    on<ScheduleGetWeekUserRationEvent>(_getWeekUserRation);
    on<ScheduleGetAllWeeksUserRationEvent>(_getAllUserWeeks);
  }

  Future<void> _generateDayRation(
    ScheduleGenerateDayRation event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      List<DayRation> weekRation = [];
      String currentShareId = '';

      if (state is ScheduleLoaded) {
        weekRation = (state as ScheduleLoaded).ration.foodData;
        currentShareId = (state as ScheduleLoaded).ration.shareId;
      }

      emit(ScheduleLoading());
      final newRation = await scheduleRepository.generateDayRation(
        _getDayName(DateTime.now(), false),
        DateTime.now().weekday,
        event.person,
      );

      final index = weekRation.indexWhere(
        (el) => el.day!.isSameDate(newRation.day!),
      );
      if (index != -1) {
        weekRation[index] = newRation;
      } else {
        weekRation.add(newRation);
      }

      final updatedWeekRation = WeekRation(
        shareId: currentShareId,
        foodData: weekRation,
      );

      emit(ScheduleLoaded(ration: updatedWeekRation));
    } catch (e) {
      emit(ScheduleFailure(message: e.toString()));
    }
  }

  Future<void> _getAllUserWeeks(
    ScheduleGetAllWeeksUserRationEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      emit(ScheduleLoading());

      final userRationsHistory =
          await scheduleRepository.getAllWeeksUserRation();

      emit(ScheduleHistoryLoaded(history: userRationsHistory));
    } catch (e) {
      emit(ScheduleFailure(message: e.toString()));
    }
  }

  Future<void> _generateWeekRation(
    ScheduleGenerateWeekRation event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      emit(ScheduleLoading());

      final generatedRation = await scheduleRepository.generateWeekRation(
        event.person,
      );

      final preRation = WeekRation(shareId: '', foodData: generatedRation);

      emit(ScheduleLoaded(ration: preRation));
    } catch (e) {
      emit(ScheduleFailure(message: e.toString()));
    }
  }

  Future<void> _saveRation(
    ScheduleSaveUserRation event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      emit(ScheduleLoading());
      final shareKey = await scheduleRepository.addUserRation(event.ration);

      final doneRation = WeekRation(shareId: shareKey, foodData: event.ration);

      emit(ScheduleLoaded(ration: doneRation));
    } catch (e) {
      emit(ScheduleFailure(message: e.toString()));
    }
  }

  Future<void> _getWeekUserRation(
    ScheduleGetWeekUserRationEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      emit(ScheduleLoading());
      final userRation = await scheduleRepository.getWeekUserRation();
      emit(ScheduleLoaded(ration: userRation));
    } catch (e) {
      emit(ScheduleFailure(message: e.toString()));
    }
  }

  String _getDayName(DateTime date, bool forTable) {
    return forTable
        ? DateFormat('EEE, d').format(date)
        : DateFormat('EEE').format(date);
  }
}

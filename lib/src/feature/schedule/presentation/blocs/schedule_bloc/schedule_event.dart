// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class ScheduleGenerateDayRation extends ScheduleEvent {
  final Human person;
  const ScheduleGenerateDayRation({required this.person});

  @override
  List<Object> get props => [person];
}

class ScheduleGenerateWeekRation extends ScheduleEvent {
  final Human person;
  const ScheduleGenerateWeekRation({required this.person});

  @override
  List<Object> get props => [person];
}

class ScheduleGetWeekUserRationEvent extends ScheduleEvent {}

class ScheduleGetAllWeeksUserRationEvent extends ScheduleEvent {}


class ScheduleSaveUserRation extends ScheduleEvent {
  final List<DayRation> ration;
  const ScheduleSaveUserRation({required this.ration});
  @override
  List<Object> get props => [ration];
}

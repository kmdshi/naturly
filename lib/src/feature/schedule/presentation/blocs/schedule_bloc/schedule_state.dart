part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleLoaded extends ScheduleState {
  final List<DayRation> ration;

  const ScheduleLoaded({required this.ration});

  @override
  List<Object> get props => [ration];
}

final class ScheduleFailure extends ScheduleState {
  final String message;

  const ScheduleFailure({required this.message});
  @override
  List<Object> get props => [message];
}

part of 'share_meal_bloc.dart';

sealed class ShareMealState extends Equatable {
  const ShareMealState();

  @override
  List<Object> get props => [];
}

final class ShareMealInitial extends ShareMealState {}

final class ShareMealLoading extends ShareMealState {}

final class ShareMealLoaded extends ShareMealState {
  final WeekRation weekRation;
  final String shared_by;

  const ShareMealLoaded({required this.weekRation, required this.shared_by});

  @override
  List<Object> get props => [weekRation, shared_by];
}

final class ShareMealFailure extends ShareMealState {
  final String error;

  const ShareMealFailure(this.error);

  @override
  List<Object> get props => [error];
}

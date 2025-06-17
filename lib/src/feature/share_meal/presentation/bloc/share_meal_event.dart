// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'share_meal_bloc.dart';

sealed class ShareMealEvent extends Equatable {
  const ShareMealEvent();

  @override
  List<Object> get props => [];
}

class GetAnotherRationShareMealEvent extends ShareMealEvent {
  final String week_key;
  GetAnotherRationShareMealEvent({required this.week_key});

  @override
  List<Object> get props => [week_key];
}

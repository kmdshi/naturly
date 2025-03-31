part of 'userbase_bloc.dart';

sealed class UserbaseState extends Equatable {
  const UserbaseState();

  @override
  List<Object> get props => [];
}

final class UserbaseInitial extends UserbaseState {}

final class UserbaseLoading extends UserbaseState {}

final class UserbaseLoaded extends UserbaseState {
  final List<Product> products;
  final List<Dish> dishes;

  const UserbaseLoaded({required this.products, required this.dishes});

  @override
  List<Object> get props => [products, dishes];
}

final class UserbaseFailure extends UserbaseState {
  final String message;

  const UserbaseFailure({required this.message});
  @override
  List<Object> get props => [message];
}

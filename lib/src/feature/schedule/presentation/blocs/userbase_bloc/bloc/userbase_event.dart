part of 'userbase_bloc.dart';

sealed class UserbaseEvent extends Equatable {
  const UserbaseEvent();

  @override
  List<Object> get props => [];
}

class UserbaseGetUserDataEvent extends UserbaseEvent {}


class UserbaseAddUserProduct extends UserbaseEvent {
  final Product product;
  const UserbaseAddUserProduct({required this.product});
  @override
  List<Object> get props => [product];
}

class UserbaseAddUserDish extends UserbaseEvent {
  final Dish dish;
  const UserbaseAddUserDish({required this.dish});
  @override
  List<Object> get props => [dish];
}

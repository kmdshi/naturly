// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'userbase_bloc.dart';

sealed class UserbaseEvent extends Equatable {
  const UserbaseEvent();

  @override
  List<Object> get props => [];
}

class UserbaseGetAllUserDataEvent extends UserbaseEvent {}

class UserbaseGetDishesEvent extends UserbaseEvent {}

class UserbaseGetProductsEvent extends UserbaseEvent {}

class EditUserProductEvent extends UserbaseEvent {
  final Product newProduct;
  final String oldTitle;

  EditUserProductEvent({required this.newProduct, required this.oldTitle});
  @override
  List<Object> get props => [newProduct, oldTitle];
}

class EditUserDishEvent extends UserbaseEvent {
  final Dish newDish;
  final String oldTitle;
  EditUserDishEvent({required this.newDish, required this.oldTitle});
  @override
  List<Object> get props => [newDish, oldTitle];
}

class DeleteUserDishEvent extends UserbaseEvent {
  final Dish dish;

  DeleteUserDishEvent({required this.dish});

  @override
  List<Object> get props => [dish];
}

class DeleteUserProductEvent extends UserbaseEvent {
  final Product product;

  DeleteUserProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

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

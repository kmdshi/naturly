// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/product_model.dart';
import 'package:naturly/src/feature/schedule/domain/repository/userbase_repository.dart';

part 'userbase_event.dart';
part 'userbase_state.dart';

class UserbaseBloc extends Bloc<UserbaseEvent, UserbaseState> {
  final UserBaseRepository userBaseRepository;
  UserbaseBloc({required this.userBaseRepository}) : super(UserbaseInitial()) {
    on<UserbaseGetUserDataEvent>(_getUserData);
    on<UserbaseAddUserProduct>(_addUserProduct);
    on<UserbaseAddUserDish>(_addUserDish);
  }

  Future<void> _getUserData(
    UserbaseGetUserDataEvent event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      emit(UserbaseLoading());
      final products = await userBaseRepository.getUserProducts();
      final dishes = await userBaseRepository.getUserDishes();

      emit(UserbaseLoaded(products: products, dishes: dishes));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _addUserProduct(
    UserbaseAddUserProduct event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      List<Product> products = _getCurrentProducts(state);
      List<Dish> dishes = _getCurrentDishes(state);
      
      emit(UserbaseLoading());

      await userBaseRepository.addUserProduct(event.product);

      products = [event.product, ...products];

      emit(UserbaseLoaded(products: products, dishes: dishes));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _addUserDish(
    UserbaseAddUserDish event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      List<Product> products = _getCurrentProducts(state);
      List<Dish> dishes = _getCurrentDishes(state);

      emit(UserbaseLoading());

      await userBaseRepository.addUserDish(event.dish);

      dishes = [event.dish, ...dishes];

      emit(UserbaseLoaded(products: products, dishes: dishes));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  List<Product> _getCurrentProducts(UserbaseState state) {
    return state is UserbaseLoaded ? state.products : [];
  }

  List<Dish> _getCurrentDishes(UserbaseState state) {
    return state is UserbaseLoaded ? state.dishes : [];
  }
}

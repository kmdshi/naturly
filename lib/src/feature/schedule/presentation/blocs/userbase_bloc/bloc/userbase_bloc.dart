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
    on<UserbaseGetAllUserDataEvent>(_getAllUserData);
    on<UserbaseAddUserProduct>(_addUserProduct);
    on<UserbaseAddUserDish>(_addUserDish);
    on<UserbaseGetDishesEvent>(_getUserDishes);
    on<UserbaseGetProductsEvent>(_getProducts);
    on<EditUserDishEvent>(_onEditUserDish);
    on<EditUserProductEvent>(_onEditUserProduct);
    on<DeleteUserDishEvent>(_onDeleteUserDish);
    on<DeleteUserProductEvent>(_onDeleteUserProduct);
  }

  Future<void> _onDeleteUserProduct(
    DeleteUserProductEvent event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      await userBaseRepository.deleteUserProduct(event.product);

      final products = await userBaseRepository.getUserProducts();

      emit(UserbaseLoaded(products: products, dishes: []));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _onDeleteUserDish(
    DeleteUserDishEvent event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      await userBaseRepository.deleteUserDish(event.dish);

      final dishes = await userBaseRepository.getUserDishes();

      emit(UserbaseLoaded(products: [], dishes: dishes));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _onEditUserProduct(
    EditUserProductEvent event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      await userBaseRepository.editUserProduct(
        event.newProduct,
        event.oldTitle,
      );

      final products = await userBaseRepository.getUserProducts();

      emit(UserbaseLoaded(products: products, dishes: []));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _onEditUserDish(
    EditUserDishEvent event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      await userBaseRepository.editUserDish(event.newDish, event.oldTitle);

      final dishes = await userBaseRepository.getUserDishes();
      final products = await userBaseRepository.getUserProducts();

      emit(UserbaseLoaded(products: products, dishes: dishes));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _getProducts(
    UserbaseGetProductsEvent event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      emit(UserbaseLoading());
      final products = await userBaseRepository.getUserProducts();

      emit(UserbaseLoaded(products: products, dishes: []));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _getUserDishes(
    UserbaseGetDishesEvent event,
    Emitter<UserbaseState> emit,
  ) async {
    try {
      emit(UserbaseLoading());
      final dishes = await userBaseRepository.getUserDishes();

      emit(UserbaseLoaded(products: [], dishes: dishes));
    } catch (e) {
      emit(UserbaseFailure(message: e.toString()));
    }
  }

  Future<void> _getAllUserData(
    UserbaseGetAllUserDataEvent event,
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

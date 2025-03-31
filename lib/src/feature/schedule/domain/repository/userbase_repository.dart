import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/product_model.dart';

abstract class UserBaseRepository {
  Future<void> addUserProduct(Product product);
  Future<void> addUserDish(Dish dish);
  Future<List<Product>> getUserProducts();
  Future<List<Dish>> getUserDishes();
}

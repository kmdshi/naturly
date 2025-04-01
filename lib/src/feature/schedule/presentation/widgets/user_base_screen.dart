import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/features/initialization/widget/dependencies_scope.dart';
import 'package:naturly/src/core/common/models/food_enums.dart';
import 'package:naturly/src/core/common/models/product_model.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/widget/alert_snackbar.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/userbase_bloc/bloc/userbase_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/widgets/dish_form_widget.dart';
import 'package:naturly/src/feature/schedule/presentation/widgets/product_form_widget.dart';

@RoutePage()
class UserBaseScreen extends StatefulWidget {
  const UserBaseScreen({super.key});

  @override
  State<UserBaseScreen> createState() => _UserBaseScreenState();
}

class _UserBaseScreenState extends State<UserBaseScreen> {
  @override
  void initState() {
    context.read<UserbaseBloc>().add(UserbaseGetUserDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Продукты и блюда'),
        leading: IconButton(
          onPressed:
              () => context.router.pushAndPopUntil(
                ScheduleRoute(),
                predicate: (route) => false,
              ),
          icon: Icon(Icons.arrow_left),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final state = context.read<UserbaseBloc>().state;

          if (state is UserbaseLoaded) {
            final products = state.products;

            _showProductDialog(products);
          }
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<UserbaseBloc, UserbaseState>(
        builder: (context, state) {
          if (state is UserbaseInitial) {
            return Center(child: Text('Нет данных'));
          } else if (state is UserbaseLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserbaseLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ...state.products.map(
                        (product) => ListTile(
                          title: Text(product.title),
                          subtitle: Text('Цена: ${product.price} руб.'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...state.dishes.map(
                        (dish) => ListTile(
                          title: Text(dish.title),
                          subtitle: Text('Цена: ${dish.totalPrice} руб.'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is UserbaseFailure) {
            DependenciesScope.of(context).logger.error(state.message);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomSnackBar(
                context,
                'Произошла ошибка непредвиденная ошибка. Попробуйте позже. Если она долго повторяется свяжитесь с разработчиком.',
              );
            });

            Future.delayed(Duration(milliseconds: 100), () {
              context.read<UserbaseBloc>().add(UserbaseGetUserDataEvent());
            });

            return SizedBox.shrink();
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _showProductDialog(final List<Product> products) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: width / 3,
            height: height / 2,
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(tabs: [Tab(text: 'Продукт'), Tab(text: 'Блюдо')]),
                  Container(
                    height: 300,
                    child: TabBarView(
                      children: [
                        ProductFormWidget(),
                        DishFormWidget(products: products),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

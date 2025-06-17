import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:naturly/src/core/common/features/initialization/widget/dependencies_scope.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
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

class _UserBaseScreenState extends State<UserBaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    context.read<UserbaseBloc>().add(UserbaseGetAllUserDataEvent());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Блюда и Продукты'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Блюда'), Tab(text: 'Продукты')],
        ),
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
        onPressed: _onFabPressed,
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<UserbaseBloc, UserbaseState>(
        builder: (context, state) {
          if (state is UserbaseInitial) {
            return Center(child: Text('Нет данных'));
          } else if (state is UserbaseLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserbaseLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    ...state.dishes.map(
                      (dish) => SwipeActionCell(
                        key: ValueKey(dish.title),
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                            title: "Edit",
                            color: Colors.blue,
                            onTap: (handler) async {
                              handler(false);
                              await changeItem(
                                context: context,
                                dish: dish,
                                products: state.products,
                              );
                            },
                          ),
                          SwipeAction(
                            title: "Delete",
                            color: Colors.red,
                            onTap: (handler) async {
                              await handler(true);
                              context.read<UserbaseBloc>().add(
                                DeleteUserDishEvent(dish: dish),
                              );
                            },
                          ),
                        ],
                        child: ListTile(
                          title: Text(dish.title),
                          subtitle: Text('Цена: ${dish.totalPrice} руб.'),
                        ),
                      ),
                    ),
                  ],
                ),

                ListView(
                  children: [
                    ...state.products.map(
                      (product) => SwipeActionCell(
                        key: ValueKey(product.title),
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                            title: "Edit",
                            color: Colors.blue,
                            onTap: (handler) async {
                              handler(false);
                              await changeItem(
                                context: context,
                                products: state.products,
                                product: product,
                              );
                            },
                          ),
                          SwipeAction(
                            title: "Delete",
                            color: Colors.red,
                            onTap: (handler) async {
                              await handler(true);
                              context.read<UserbaseBloc>().add(
                                DeleteUserProductEvent(product: product),
                              );
                            },
                          ),
                        ],
                        child: ListTile(
                          title: Text(product.title),
                          subtitle: Text('Цена: ${product.price} руб.'),
                        ),
                      ),
                    ),
                  ],
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
              context.read<UserbaseBloc>().add(UserbaseGetAllUserDataEvent());
            });

            return SizedBox.shrink();
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  void _onFabPressed() {
    if (_tabController.indexIsChanging) return;

    final state = context.read<UserbaseBloc>().state;
    if (state is UserbaseLoaded) {
      final currentTabIndex = _tabController.index;

      showDialog<void>(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 300,
                    child:
                        currentTabIndex == 1
                            ? ProductFormWidget()
                            : DishFormWidget(products: state.products),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;

    final bloc = context.read<UserbaseBloc>();
    final state = bloc.state;

    if (_tabController.index == 0) {
      if (state is UserbaseLoaded && state.dishes.isEmpty) {
        bloc.add(UserbaseGetDishesEvent());
      }
    } else if (_tabController.index == 1) {
      if (state is UserbaseLoaded && state.products.isEmpty) {
        bloc.add(UserbaseGetProductsEvent());
      }
    }
  }

  Future<void> changeItem({
    required final BuildContext context,
    required final List<Product> products,
    final Product? product,
    final Dish? dish,
  }) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: width / 3,
            height: height / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 300,
                  child:
                      product != null
                          ? ProductFormWidget(product: product, isEdit: true)
                          : DishFormWidget(
                            dish: dish,
                            products: products,
                            isEdit: true,
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/food_enums.dart';
import 'package:naturly/src/core/common/models/product_model.dart';
import 'package:naturly/src/core/widget/alert_snackbar.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/userbase_bloc/bloc/userbase_bloc.dart';

class DishFormWidget extends StatefulWidget {
  final List<Product> products;
  final Dish? dish;
  final bool isEdit;

  const DishFormWidget({
    super.key,
    required this.products,
    this.dish,
    this.isEdit = false,
  });

  @override
  State<DishFormWidget> createState() => _DishFormWidgetState();
}

class _DishFormWidgetState extends State<DishFormWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mealTypeController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();

  ProductGroup _selectedGroup = ProductGroup.addedFatsNutsSeedsAndOilyFruits;

  late Map<Product, bool> productsSelected;

  @override
  void initState() {
    super.initState();

    productsSelected = {for (var product in widget.products) product: false};

    final d = widget.dish;
    if (widget.isEdit && d != null) {
      _titleController.text = d.title;
      _mealTypeController.text = d.mealType;
      _caloriesController.text = d.calories.toString();
      _totalPriceController.text = d.totalPrice.toString();
      _proteinController.text = d.protein.toString();
      _fatsController.text = d.fats.toString();
      _carbsController.text = d.carbs.toString();

      for (var product in d.products) {
        productsSelected[product] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Название блюда'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _mealTypeController,
            decoration: InputDecoration(
              labelText: 'Прием пищи',
              helperText: 'Завтрак/Обед...',
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final currentProduct = widget.products[index];
              return ListTile(
                title: Text(currentProduct.title),
                leading: Checkbox(
                  value: productsSelected[currentProduct],
                  onChanged: (bool? value) {
                    setState(() {
                      productsSelected[currentProduct] = value ?? false;
                    });
                  },
                ),
              );
            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: _caloriesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Калории'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _totalPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Общая цена'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _proteinController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Белки'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _fatsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Жиры'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _carbsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Углеводы'),
          ),
          SizedBox(height: 10),

          SizedBox(height: 10),
          DropdownButton<ProductGroup>(
            value: _selectedGroup,
            isExpanded: true,
            onChanged: (ProductGroup? newValue) {
              setState(() {
                _selectedGroup = newValue!;
              });
            },
            items:
                ProductGroup.values.map((ProductGroup group) {
                  return DropdownMenuItem<ProductGroup>(
                    value: group,
                    child: Text(
                      group.displayName.split('.').last,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              final selectedProducts =
                  widget.products
                      .where((product) => productsSelected[product] == true)
                      .toList();

              if (_titleController.text.isEmpty ||
                  _mealTypeController.text.isEmpty ||
                  _proteinController.text.isEmpty ||
                  _fatsController.text.isEmpty ||
                  _carbsController.text.isEmpty ||
                  _caloriesController.text.isEmpty ||
                  selectedProducts.isEmpty) {
                showCustomSnackBar(context, 'Должны быть заполнены все поля');
                return;
              }

              final newDish = Dish(
                title: _titleController.text,
                mealType: _mealTypeController.text,
                products: selectedProducts,
                calories: int.tryParse(_caloriesController.text) ?? 0,
                totalPrice: int.tryParse(_totalPriceController.text) ?? 0,
                protein: int.tryParse(_proteinController.text) ?? 0,
                fats: int.tryParse(_fatsController.text) ?? 0,
                carbs: int.tryParse(_carbsController.text) ?? 0,
                restrictions: widget.dish?.restrictions ?? {},
                missingProducts: widget.dish?.missingProducts ?? [],
              );

              Navigator.pop(context);

              if (widget.isEdit) {
                context.read<UserbaseBloc>().add(
                  EditUserDishEvent(
                    newDish: newDish,
                    oldTitle: widget.dish?.title ?? '',
                  ),
                );
              } else {
                context.read<UserbaseBloc>().add(
                  UserbaseAddUserDish(dish: newDish),
                );
              }
            },
            child: Text(
              widget.isEdit ? 'Сохранить изменения' : 'Создать блюдо',
            ),
          ),
        ],
      ),
    );
  }
}

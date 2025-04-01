import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/models/food_enums.dart';
import 'package:naturly/src/core/common/models/product_model.dart';
import 'package:naturly/src/core/widget/alert_snackbar.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/userbase_bloc/bloc/userbase_bloc.dart';

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({super.key});

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _ccalController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  ProductGroup _selectedGroup = ProductGroup.grainsAndPotatoes;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Цена'),
            ),

            DropdownButton<ProductGroup>(
              value: _selectedGroup,
              onChanged: (ProductGroup? newValue) {
                setState(() {
                  _selectedGroup = newValue!;
                });
              },
              items:
                  ProductGroup.values.map((ProductGroup group) {
                    return DropdownMenuItem<ProductGroup>(
                      value: group,
                      child: Text(group.displayName.split('.').last),
                    );
                  }).toList(),
            ),
            TextField(
              controller: _proteinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Белки'),
            ),
            TextField(
              controller: _fatsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Жиры'),
            ),
            TextField(
              controller: _carbsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Углеводы'),
            ),
            TextField(
              controller: _ccalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Калории'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Количество'),
            ),
            TextButton(
              onPressed: () {
                if (_titleController.text.isEmpty ||
                    _priceController.text.isEmpty ||
                    _proteinController.text.isEmpty ||
                    _fatsController.text.isEmpty ||
                    _carbsController.text.isEmpty ||
                    _ccalController.text.isEmpty ||
                    _quantityController.text.isEmpty) {
                  showCustomSnackBar(context, 'Должны быть заполнены все поля');
                  return;
                }
                final newProduct = Product(
                  title: _titleController.text,
                  price: int.tryParse(_priceController.text) ?? 0,
                  protein: double.tryParse(_proteinController.text) ?? 0,
                  fats: double.tryParse(_fatsController.text) ?? 0,
                  carbs: double.tryParse(_carbsController.text) ?? 0,
                  ccal: double.tryParse(_ccalController.text) ?? 0,
                  productGroup: _selectedGroup,
                  quantity: int.tryParse(_quantityController.text) ?? 0,
                  fishType: null,
                  proteinType: null,
                  meatType: null,
                );
                Navigator.of(context).pop();

                context.read<UserbaseBloc>().add(
                  UserbaseAddUserProduct(product: newProduct),
                );
              },
              child: Text('Добавить продукт'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:naturly/src/features/schedule/data/data_source/remote/schedule_remote_ds.dart';
import 'package:naturly/src/features/schedule/domain/models/food_enums.dart';
import 'package:naturly/src/features/schedule/domain/models/product_model.dart';

class UserBaseScreen extends StatefulWidget {
  const UserBaseScreen({super.key});

  @override
  State<UserBaseScreen> createState() => _UserBaseScreenState();
}

class _UserBaseScreenState extends State<UserBaseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _ccalController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  ProductGroup _selectedGroup = ProductGroup.grainsAndPotatoes;
  final supa = ScheduleSupabaseRemoteDS();
  var text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Продукты и блюда')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showProductDialog(),
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final products = await supa.getAvailableProducts();
                  setState(() {
                    text = products.toString();
                  });
                },
                child: Text('Получить продукты')),
            Text(text)
          ],
        ));
  }

  Future<void> _showProductDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Добавить продукт'),
          content: SingleChildScrollView(
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
                DropdownButton<ProductGroup>(
                  value: _selectedGroup,
                  onChanged: (ProductGroup? newValue) {
                    setState(() {
                      _selectedGroup = newValue!;
                    });
                  },
                  items: ProductGroup.values.map((ProductGroup group) {
                    return DropdownMenuItem<ProductGroup>(
                      value: group,
                      child: Text(group.toString().split('.').last),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final newProduct = Product(
                  title: _titleController.text,
                  price: int.tryParse(_priceController.text) ?? 0,
                  protein: int.tryParse(_proteinController.text) ?? 0,
                  fats: int.tryParse(_fatsController.text) ?? 0,
                  carbs: int.tryParse(_carbsController.text) ?? 0,
                  ccal: int.tryParse(_ccalController.text) ?? 0,
                  productGroup: _selectedGroup,
                  quantity: int.tryParse(_quantityController.text) ?? 0,
                  fishType: null,
                  proteinType: null,
                  meatType: null,
                );
                supa.addUserProduct(newProduct);
                Navigator.of(context).pop();
              },
              child: Text('Добавить'),
            ),
          ],
        );
      },
    );
  }
}

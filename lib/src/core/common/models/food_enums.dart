enum ProductGroup {
  grainsAndPotatoes,
  vegetablesFruitsAndBerries,
  dairyAndDairyProducts,
  fishPoultryMeatAndEggs,
  addedFatsNutsSeedsAndOilyFruits,
  sugarSweetsAndSnacks,
  soupsAndBroths,
}

enum MeatType { beef, pork, chicken, turkey, lamb, duck, rabbit }

enum FishType { salmon, tuna, cod, trout, herring, mackerel, shrimp, squid }

enum ProteinType {
  cottageCheese,
  milk,
  yogurt,
  kefir,
  cheese,
  eggs,
  tofu,
  legumes,
  nuts,
}

extension MeatTypeExtension on MeatType {
  String toMap() {
    return toString().split('.').last;
  }

  static MeatType fromMap(String value) {
    return MeatType.values.firstWhere(
      (e) => e.toString().split('.').last == value,
    );
  }
}

extension FishTypeExtension on FishType {
  String toMap() {
    return toString().split('.').last;
  }

  static FishType fromMap(String value) {
    return FishType.values.firstWhere(
      (e) => e.toString().split('.').last == value,
    );
  }
}

extension ProteinTypeExtension on ProteinType {
  String toMap() {
    return toString().split('.').last;
  }

  static ProteinType fromMap(String value) {
    return ProteinType.values.firstWhere(
      (e) => e.toString().split('.').last == value,
    );
  }
}

extension ProductGroupExtension on ProductGroup {
  String get displayName {
    switch (this) {
      case ProductGroup.grainsAndPotatoes:
        return 'Зерновые и картофель';
      case ProductGroup.vegetablesFruitsAndBerries:
        return 'Овощи, фрукты и ягоды';
      case ProductGroup.dairyAndDairyProducts:
        return 'Молочные продукты';
      case ProductGroup.fishPoultryMeatAndEggs:
        return 'Рыба, птица, мясо и яйца';
      case ProductGroup.addedFatsNutsSeedsAndOilyFruits:
        return 'Добавленные жиры, орехи, семена и масличные плоды';
      case ProductGroup.sugarSweetsAndSnacks:
        return 'Сахар, сладости и закуски';
      case ProductGroup.soupsAndBroths:
        return 'Супы и бульоны';
    }
  }

  static ProductGroup fromMap(String value) {
    switch (value) {
      case 'grainsAndPotatoes':
        return ProductGroup.grainsAndPotatoes;
      case 'vegetablesFruitsAndBerries':
        return ProductGroup.vegetablesFruitsAndBerries;
      case 'dairyAndDairyProducts':
        return ProductGroup.dairyAndDairyProducts;
      case 'fishPoultryMeatAndEggs':
        return ProductGroup.fishPoultryMeatAndEggs;
      case 'addedFatsNutsSeedsAndOilyFruits':
        return ProductGroup.addedFatsNutsSeedsAndOilyFruits;
      case 'sugarSweetsAndSnacks':
        return ProductGroup.sugarSweetsAndSnacks;
      case 'soupsAndBroths':
        return ProductGroup.soupsAndBroths;
      default:
        throw ArgumentError('Unknown product group: $value');
    }
  }

  static String toMap(ProductGroup group) {
    switch (group) {
      case ProductGroup.grainsAndPotatoes:
        return 'grainsAndPotatoes';
      case ProductGroup.vegetablesFruitsAndBerries:
        return 'vegetablesFruitsAndBerries';
      case ProductGroup.dairyAndDairyProducts:
        return 'dairyAndDairyProducts';
      case ProductGroup.fishPoultryMeatAndEggs:
        return 'fishPoultryMeatAndEggs';
      case ProductGroup.addedFatsNutsSeedsAndOilyFruits:
        return 'addedFatsNutsSeedsAndOilyFruits';
      case ProductGroup.sugarSweetsAndSnacks:
        return 'sugarSweetsAndSnacks';
      case ProductGroup.soupsAndBroths:
        return 'soupsAndBroths';
    }
  }
}

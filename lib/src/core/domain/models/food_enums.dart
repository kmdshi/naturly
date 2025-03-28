enum ProductGroup {
  grainsAndPotatoes,
  vegetablesFruitsAndBerries,
  dairyAndDairyProducts,
  fishPoultryMeatAndEggs,
  addedFatsNutsSeedsAndOilyFruits,
  sugarSweetsAndSnacks,
}

enum MeatType {
  beef,
  pork,
  chicken,
  turkey,
  lamb,
  duck,
  rabbit,
}

enum FishType {
  salmon,
  tuna,
  cod,
  trout,
  herring,
  mackerel,
  shrimp,
  squid,
}

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
    return this.toString().split('.').last;
  }

  static MeatType fromMap(String value) {
    return MeatType.values
        .firstWhere((e) => e.toString().split('.').last == value);
  }
}

extension FishTypeExtension on FishType {
  String toMap() {
    return this.toString().split('.').last;
  }

  static FishType fromMap(String value) {
    return FishType.values
        .firstWhere((e) => e.toString().split('.').last == value);
  }
}

extension ProteinTypeExtension on ProteinType {
  String toMap() {
    return this.toString().split('.').last;
  }

  static ProteinType fromMap(String value) {
    return ProteinType.values
        .firstWhere((e) => e.toString().split('.').last == value);
  }
}

extension ProductGroupExtension on ProductGroup {
  String toMap() {
    return this.toString().split('.').last;
  }

  static ProductGroup fromMap(String value) {
    return ProductGroup.values
        .firstWhere((e) => e.toString().split('.').last == value);
  }
}

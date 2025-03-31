import 'package:shared_preferences/shared_preferences.dart';


abstract class PersistedEntry<T extends Object> {
  const PersistedEntry();

  Future<T?> read();

  Future<void> set(T value);

  Future<void> remove();

  Future<void> setIfNullRemove(T? value) => value == null ? remove() : set(value);
}


abstract class SharedPreferencesEntry<T extends Object> extends PersistedEntry<T> {
  const SharedPreferencesEntry({required this.sharedPreferences, required this.key});

  final SharedPreferencesAsync sharedPreferences;

  final String key;
}

class IntPreferencesEntry extends SharedPreferencesEntry<int> {
  const IntPreferencesEntry({required super.sharedPreferences, required super.key});

  @override
  Future<int?> read() => sharedPreferences.getInt(key);

  @override
  Future<void> set(int value) async {
    await sharedPreferences.setInt(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

class StringPreferencesEntry extends SharedPreferencesEntry<String> {
  const StringPreferencesEntry({required super.sharedPreferences, required super.key});

  @override
  Future<String?> read() => sharedPreferences.getString(key);

  @override
  Future<void> set(String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

class BoolPreferencesEntry extends SharedPreferencesEntry<bool> {
  const BoolPreferencesEntry({required super.sharedPreferences, required super.key});

  @override
  Future<bool?> read() => sharedPreferences.getBool(key);

  @override
  Future<void> set(bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

class DoublePreferencesEntry extends SharedPreferencesEntry<double> {
  const DoublePreferencesEntry({required super.sharedPreferences, required super.key});

  @override
  Future<double?> read() => sharedPreferences.getDouble(key);

  @override
  Future<void> set(double value) async {
    await sharedPreferences.setDouble(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

class StringListPreferencesEntry extends SharedPreferencesEntry<List<String>> {
  const StringListPreferencesEntry({required super.sharedPreferences, required super.key});

  @override
  Future<List<String>?> read() => sharedPreferences.getStringList(key);

  @override
  Future<void> set(List<String> value) async {
    await sharedPreferences.setStringList(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

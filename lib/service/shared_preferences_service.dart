
import "dart:convert";

import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;
  SharedPreferencesService(this.sharedPreferences);

  Future<void> addBuildingDetails(Map<String, dynamic> value) async {
    List<String> items = sharedPreferences.getStringList('items') ?? [];

    items.add(jsonEncode(value));

    await sharedPreferences.setStringList('items', items);
  }

  List<Map<String, dynamic>> getBuildingDetails() {

    List<String> items = sharedPreferences.getStringList('items') ?? [];

    return items.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  Future<void> addUnitBuildingList(Map<String, dynamic> value) async {
    List<String> items = sharedPreferences.getStringList('items') ?? [];
    items.add(jsonEncode(value));
    await sharedPreferences.setStringList('items', items);
  }

  List<Map<String, dynamic>> getUnitBuildingList() {
    List<String> items = sharedPreferences.getStringList('items') ?? [];
    return items.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }


  /// ✅ NEW: Overwrite full list after delete or update
  Future<void> saveAll(List<Map<String, dynamic>> list) async {
    List<String> encodedList = list.map((e) => jsonEncode(e)).toList();
    await sharedPreferences.setStringList('items', encodedList);
  }

  /// ✅ Optional: Clear all data (for reset)
  Future<void> clearAll() async {
    await sharedPreferences.remove('items');
  }

  Future<void> updateAtIndex(int index, Map<String, dynamic> newValue) async {
    List<String> items = sharedPreferences.getStringList('items') ?? [];

    if (index < 0 || index >= items.length) return; // Safety check

    items[index] = jsonEncode(newValue); // Replace with updated value

    await sharedPreferences.setStringList('items', items);
  }
}
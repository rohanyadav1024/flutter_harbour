import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  static FlutterSecureStorage? storage;

  static void initiateSecureStorage() {
    storage ??= const FlutterSecureStorage();
  }

// Read value
  static Future<String?> readStringValue(String key) async {
    String? value = await storage?.read(key: key);
    return value;
  }

  static Future<int?> readIntValue(String key) async {
    String? value = await storage?.read(key: key);
    return int.parse(value!);
  }

  static Future<bool?> readBoolValue(String key) async {
    String? value = await storage?.read(key: key);
    return value == "true" ? true : false;
  }

// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete value
  static Future<void> deleteValue(String key) async {
    await storage?.delete(key: key);
  }

// Delete all
  static Future<void> clearSecureStorage() async {
    await storage?.deleteAll();
  }

// Write value
  static Future<void> writeStringValue(String key, String value) async {
    await storage?.write(key: key, value: value);
  }

  static Future<void> writeIntValue(String key, int value) async {
    await storage?.write(key: key, value: value.toString());
  }

  static Future<void> writeBoolValue(String key, bool value) async {
    await storage?.write(key: key, value: value.toString());
  }
}

class Keys {
  static const userId = "userId";
  static const firstName = "firstName";
  static const email = "email";
  static const gender = "gender";
  static const token = "token";
  static const contNum = "contNum";
  static const role = "role";
  static const walletBal = "walletbal";
  static const img = "img";
}

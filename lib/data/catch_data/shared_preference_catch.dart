import 'package:shared_preferences/shared_preferences.dart';

setStrToPrefs(key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

setIntToPrefs(key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

setBoolToPrefs(key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

getStrPrefs({required key}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getString(key);
    } else {
      return "";
    }
  } catch (e) {
    //   TODO
  }
}

Future<int?> getIntPrefs({required String key}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getInt(key);
    } else {
      return -1;
    }
  } catch (e) {
    return -1;
  }
}

getBoolPrefs({required key}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getBool(key);
    } else {
      return false;
    }
  } catch (e) {
    //   TODO
  }
}

removePrefsKey({required key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey(key)) {
    await prefs.remove(key);
  }
}

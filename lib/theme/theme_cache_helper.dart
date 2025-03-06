import 'package:shared_preferences/shared_preferences.dart';

class ThemeCacheHelper {
  // choosed user theme
  Future<void> getCachedHelper(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("THEME_INDEX", themeIndex);
  }
 // get initial theme
  Future<int> getCachedThemeIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedThemeIndex = prefs.getInt("THEME_INDEX");
    if (cachedThemeIndex != null) {
      return cachedThemeIndex;
    } else {
      return 0;
    }
  }
}

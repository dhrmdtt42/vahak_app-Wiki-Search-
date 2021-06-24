import 'package:shared_preferences/shared_preferences.dart';

class MyUtils {
  saveResponse(String jsonResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("response", jsonResponse);
    print(jsonResponse);
  }

  Future<String> getResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var wikiResponse = prefs.get("response");
    print(wikiResponse);
    return wikiResponse;
  }
}

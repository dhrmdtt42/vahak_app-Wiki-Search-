import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class ProviderModel extends ChangeNotifier {
  Future<dynamic> getCityDataApiCall(
      BuildContext context, String searchText) async {
    var url =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=$searchText&gpslimit=10';
    Map data = {
      "srchtext": "$searchText",
    };

    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "ee4454DSFDSDSF556566"
        },
        body: body);
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show("Success", context, gravity: 1, duration: Toast.LENGTH_LONG);
      Map responseData = new Map();
      responseData = jsonDecode(response.body);
//      cityBaseResponse = CityBaseResponse.fromJson(responseData);
    }

    print("${response.body}");
    return response;
  }
}

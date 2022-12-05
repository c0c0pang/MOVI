import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiModel {
  final String url;
  ApiModel(this.url);

  Future<dynamic> getJsonData() async{
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData)['results'];
      return parsingData;
    }
  }
}
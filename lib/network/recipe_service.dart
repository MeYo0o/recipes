import 'dart:developer';

import 'package:http/http.dart';

const String apiId = '42c7b339';
const String apiKey = 'a7e1c43e220278806bf21062d6a60b1e';
const String apiUrl = 'https://api.edamam.com/search';

class RecipeService {
 static Future _getData(String url) async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      log(response.body);
    }
  }

 static Future<dynamic> getRecipes({
    required String query,
    required int from,
    required int to,
  }) async {
    final recipeData = await _getData(
      '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to',
    );

    return recipeData;
  }
}

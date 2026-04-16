import 'dart:convert';
import 'package:http/http.dart' as http;

class UsdaApi {
  static const String apiKey = 'XgbOn8NEonyrgz3eHJ3tx4eYRXMWqU4oP0fbdGOC';

  static Future<Map<String, dynamic>?> searchFood(String query) async {
    final url = Uri.parse(
      'https://api.nal.usda.gov/fdc/v1/foods/search?query=$query&api_key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      print("API error");
      return null;
    }

    final data = json.decode(response.body);

    if (data['foods'] == null || data['foods'].isEmpty) {
      return null;
    }

    final food = data['foods'][0]; 

    double? calories;
    double? protein;
    double? carbs;
    double? fat;

    for (var n in food['foodNutrients']) {
      switch (n['nutrientName']) {
        case 'Energy':
          calories = n['value']?.toDouble();
          break;
        case 'Protein':
          protein = n['value']?.toDouble();
          break;
        case 'Carbohydrate, by difference':
          carbs = n['value']?.toDouble();
          break;
        case 'Total lipid (fat)':
          fat = n['value']?.toDouble();
          break;
      }
    }

    return {
      "name": food['description'],
      "calories": calories,
      "protein": protein,
      "carbs": carbs,
      "fat": fat,
    };
  }
}
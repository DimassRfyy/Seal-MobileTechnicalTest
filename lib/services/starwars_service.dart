import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../shared/shared_values.dart';

class StarWarsService {
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse(kStarWarsPeopleEndpoint));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}

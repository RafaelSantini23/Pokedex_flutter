import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_pokedex/constant.dart';
import 'package:project_pokedex/model/pokemon.dart';
import 'package:project_pokedex/service/pokemon_info_response.dart';
import 'package:project_pokedex/service/pokemon_species_info.dart';

class PokemonRepository{

  final baseUrl = '${Constant.BASE_URL}';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {

    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };

    final uri = Uri.https(baseUrl, Constant.POKEMON_ENDPOINT, queryParameters);

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    return PokemonPageResponse.fromJson(json);
  }
  Future<PokemonInfoResponse> getPokemonInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonInfoResponse.fromJson(json);
      print(json);
    } catch (e) {
      print(e);
    }
  }
  Future<PokemonSpeciesInfoResponse> getPokemonSpeciesInfo(
      int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonSpeciesInfoResponse.fromJson(json);
    } catch (e) {
      print(e);
    }
  }

}
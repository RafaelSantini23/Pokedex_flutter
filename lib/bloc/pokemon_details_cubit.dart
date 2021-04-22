import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pokedex/service/pokemon_details.dart';
import 'package:project_pokedex/service/pokemon_info_response.dart';
import 'package:project_pokedex/service/pokemon_service.dart';
import 'package:project_pokedex/service/pokemon_species_info.dart';


class PokemonDetailsCubit extends Cubit<PokemonDetails> {
  final _pokemonService = PokemonRepository();

  PokemonDetailsCubit() : super(null);

  void getPokemonDetails(int pokemonId) async {
    final responses = await Future.wait([
      _pokemonService.getPokemonInfo(pokemonId),
      _pokemonService.getPokemonSpeciesInfo(pokemonId)
  ]);


    final pokemonInfo = responses[0] as PokemonInfoResponse;
    final speciesInfo = responses[1] as PokemonSpeciesInfoResponse;

    emit(PokemonDetails(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        imageUrl: pokemonInfo.imageUrl,
        types: pokemonInfo.types,
        height: pokemonInfo.height,
        weight: pokemonInfo.weight,
        description: speciesInfo.description));
  }

  void clearPokemonDetails() => emit(null);
}
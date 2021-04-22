import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pokedex/bloc/nav_cubit.dart';
import 'package:project_pokedex/bloc/pokemon_bloc.dart';
import 'package:project_pokedex/bloc/pokemon_details_cubit.dart';
import 'package:project_pokedex/info_pokemon/app_navigator.dart';
import 'bloc/pokemon_event.dart';
import 'views/views.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
      title: 'Flutter Pokemon',
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(primaryColor: Colors.red, accentColor: Colors.redAccent),
      home: MultiBlocProvider(
          providers: [BlocProvider(create: (context) =>
          PokemonBloc()..add(PokemonPageRequest(page: 0))),
            BlocProvider(create: (context) => NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
            BlocProvider(create: (context) => pokemonDetailsCubit)
          ], child: AppNavigator()),
    );
  }
}



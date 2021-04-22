import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pokedex/bloc/nav_cubit.dart';
import 'package:project_pokedex/info_pokemon/pokemon_details_view.dart';
import 'package:project_pokedex/views/home.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(builder: (context, pokemonId){
        return Navigator(
          pages: [
            MaterialPage(child: MyHomePage()),
            if(pokemonId != null) MaterialPage(child: PokemonDetailsView())
          ],
          onPopPage: (route,result) {
            BlocProvider.of<NavCubit>(context).popToPokedex();
          return route.didPop(result);
          },
        );
    });
  }
}
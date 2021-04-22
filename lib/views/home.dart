import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:project_pokedex/bloc/nav_cubit.dart';
import 'package:project_pokedex/bloc/pokemon_bloc.dart';
import 'package:project_pokedex/bloc/pokemon_state.dart';
import 'package:backdrop/backdrop.dart';
import 'package:project_pokedex/constant.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}


enum TtsState {playing, stopped, paused, continued}
class _MyHomePageState extends State<MyHomePage> {

  FlutterTts _flutterTts = FlutterTts();
  TtsState _ttsState;
  double _volume = 0.5;

  void initState () {
    super.initState();
    _ttsState = TtsState.playing;
    _speak(Constant.HELLOW);
  }

  _frontLayer() {
    return Scaffold(
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: state.pokemonListings.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      BlocProvider.of<NavCubit>(context)
                          .showPokemonDetails(state.pokemonListings[index].id),
                  child: Card(
                    child: GridTile(
                      child: Column(
                        children: [
                          Image.network(state.pokemonListings[index].imageUrl),
                          Text(state.pokemonListings[index].name.toUpperCase())
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PokemonPageLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _backLayer() {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(
              child: Container(
                child: FlareActor(
                    "assets/space_demo.flr",
                    fit: BoxFit.cover,
                    animation: "idle"),
                    height: 350,
                    width: 500,
                ),
              ),
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: Column(
              children: [
                Text(Constant.ABOUT, style: TextStyle(color: Colors.black, fontSize: 50)),
              ],
             ),
           ),

          Column(
                children: [
                  Text(Constant.NAMES_TITLE, style: TextStyle(color: Colors.black, fontSize: 30)),
                  Text(Constant.NAMES, style: TextStyle(color: Colors.black, fontSize: 30)),
                ],
              ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(Constant.EMAIL_TITLE, style: TextStyle(color: Colors.black, fontSize: 30)),
                Text(Constant.EMAIL, style: TextStyle(color: Colors.black, fontSize: 30)),
              ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(Constant.LANG, style: TextStyle(color: Colors.black, fontSize: 30)),
                  FlutterLogo(size: 150.0),

                ],
              ),
            ),
          ],
        ),
      );
  }



  @override
  Widget build(BuildContext context) {
      return BackdropScaffold(
        appBar: BackdropAppBar(
           title: Text('Pokedex'),
        ),
        backLayer: _backLayer(),
        frontLayer: _frontLayer(),
      );

  }

  @override
  void dispose() async {
    super.dispose();
  }

  Future _speak(String message) async {
    var result = await _flutterTts.speak(message);
    if(result == 1) setState(() => _ttsState = TtsState.playing);
    await _flutterTts.getLanguages;
    await _flutterTts.setLanguage("pt-br");

  }
}
import 'package:character_app/business_logic/cubit/character_cubit.dart';
import 'package:character_app/data/repoistory/characters.repoistory.dart';
import 'package:character_app/data/web_services/character_web_service.dart';
import 'package:character_app/presentation/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:character_app/presentation/screens/character_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constansts/strings.dart';
import 'data/models/character.dart';

class AppRouter {
  late CharactersRepoistory charactersRepoistory;
  late CharactersCubit characterCubit;
  AppRouter() {
    //  أنت هنا ب create webservice جديدة
    charactersRepoistory = CharactersRepoistory(CharacterWebServices());
    characterCubit = CharactersCubit(charactersRepoistory);
    //characterCubit=CharactersCubit(CharactersRepoistory(CharacterWebServices()));
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext Context) => characterCubit,
                  child: CharacterScreen(),
                ));
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              // we are create new cubit    instead of   passing the same cubit here by using blocprovider.value
              create:(BuildContext Context) =>CharactersCubit(charactersRepoistory) ,
                    child: CharacterDetailsScreen(
                  character: character,
                )));
    }
  }
}

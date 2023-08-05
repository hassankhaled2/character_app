

import 'package:character_app/data/models/episode.dart';

import '../models/character.dart';
import '../web_services/character_web_service.dart';



class CharactersRepoistory
{
  final CharacterWebServices characterWebServices;

  CharactersRepoistory(this.characterWebServices);
  Future<List<Character>>getAllCharacter()
  async{
    final characters =await characterWebServices.getAllCharacter();
    return characters.map((character) => Character.fromJson(character)).toList();
  }
  Future<List<Episode>>getCharacterEpisodes(String charName)
  async{
    final episodes =await characterWebServices.getCharacterEpisodes(charName);
    return episodes.map((epsoide) =>Episode.fromJson(epsoide)).toList();
  }
}

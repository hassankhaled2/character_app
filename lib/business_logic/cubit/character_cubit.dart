import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/character.dart';
import '../../data/models/episode.dart';
import '../../data/repoistory/characters.repoistory.dart';

part 'character_state.dart';

class CharactersCubit extends Cubit<CharacterState> {
  final  CharactersRepoistory characterRepoistory;
  List< Character >characters=[];
  CharactersCubit(this.characterRepoistory) : super(CharacterInitial());
  List< Character >getAllCharacter()
  {
    characterRepoistory.getAllCharacter().then((characters)
    {
     emit(CharactersLoaded(characters));
     this.characters=characters;
    }
    );
    return characters;
  }
  void getCharacterEpisodes(String charName)
  {
    characterRepoistory.getCharacterEpisodes(charName).then((episodes)
    {
      emit(EpisodesLoaded(episodes));
    }
    );
  }
}

part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharactersLoaded extends  CharacterState
{
  final List< Character >characters;

  CharactersLoaded(this.characters);
}
class EpisodesLoaded extends  CharacterState
{
  final List<Episode>episodes;

  EpisodesLoaded(this.episodes);
}

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:character_app/business_logic/cubit/character_cubit.dart';
import 'package:character_app/constansts/my_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);

  Widget buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.name, style: TextStyle(color: MyColors.myWhite),

        ),
        background: Hero(
          tag: character.charld,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  // const CharacterDetailsScreen({Key? key}) : super(key: key);
Widget characterInfo(String title,String value)
{
return RichText(
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  text:TextSpan(
      children: [
        TextSpan(
          text: title,
          style: TextStyle(
            color: MyColors.myWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ) ,
        TextSpan(
          text: value,
          style: TextStyle(
            color: MyColors.myWhite,
            fontSize: 18,
          )
        )
      ])
);


}
Widget buildDivider(double endIndent)
{
  return Divider(endIndent: endIndent,height: 30,color: MyColors.myYellow,thickness: 2,);
}
Widget checkIfCodeAreLoaded(CharacterState state)
{
if(state is EpisodesLoaded)
{
  return displayRandomEpidsodeOrEmptySpace(state);
}
else
{
return  showProgressIndicator();
}
}
Widget displayRandomEpidsodeOrEmptySpace(state)
{
var episodes =(state).episodes;
if(episodes.length!=0)
{
  int randomEpisodeIndex=Random().nextInt(episodes.length-1);
  return Center(
    child: DefaultTextStyle(textAlign:TextAlign.center,style:TextStyle(fontSize: 20,color:MyColors.myWhite,shadows:
    [
      Shadow(
        blurRadius: 7,
        color: MyColors.myYellow,
        offset: Offset(0,0)
      )
    ]) ,child:AnimatedTextKit(repeatForever: true,
        animatedTexts:
        [
          FlickerAnimatedText(episodes[randomEpisodeIndex].episode),
        ]
    ),),
  );
}else
{
  return Container();
}
}
Widget showProgressIndicator()
{
  return Center(
    child:CircularProgressIndicator(color: MyColors.myYellow,),
  );
}
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getCharacterEpisodes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14,0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  characterInfo('Species:',character.species),
                buildDivider(244),
                  characterInfo('Gender:',character.gender),
                  buildDivider(310),
                  characterInfo('Status:',character.statusIfDeadOrA1ive),
                  buildDivider(310),
                  // SizedBox(height: 20,),
                  BlocBuilder<CharactersCubit,CharacterState>(builder: (context,state)
                  {
                return checkIfCodeAreLoaded(state);
                  })
                ],
              ),
            ),
            SizedBox(height: 500,)
          ],
          ),
          )
        ],
      ),
    );
  }
}

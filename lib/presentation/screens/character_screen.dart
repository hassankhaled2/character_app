import 'package:character_app/constansts/my_colors.dart';
import 'package:character_app/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../business_logic/cubit/character_cubit.dart';
import '../../data/models/character.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharaters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a Character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacters) {
        addSearchedForItemsToSearchedList(searchedCharacters);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharaters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //UI tell bloc/cubit give me the state, so the bloc lazy become available
    BlocProvider.of<CharactersCubit>(context).getAllCharacter();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharaters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharaters.length
            : searchedForCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allCharaters[index]
                : searchedForCharacters[index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return Text('Characters', style: TextStyle(color: MyColors.myGrey));
  }

  Widget BuildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text('Can\'t connect....check internet',style: TextStyle(color: MyColors.myGrey),
              
            ),
            Image(
              image: AssetImage('assets/images/NoWifi.jpg'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return buildBlocWidget();
        } else {
          return BuildNoInternetWidget();
        }
      },
      child: showLoadingIndicator(),
      ),

      //buildBlocWidget(),
    );
  }
}

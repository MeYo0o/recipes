import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_dropdown.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];

  // TODO: Add _currentRecipes1

  @override
  void initState() {
    super.initState();
    // TODO: Call loadRecipes()

    getPreviousSearches();

    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore &&
            currentEndPosition < currentCount &&
            !loading &&
            !inErrorState) {
          setState(() {
            loading = true;
            currentStartPosition = currentEndPosition;
            currentEndPosition =
                min(currentStartPosition + pageCount, currentCount);
          });
        }
      }
    });
  }

  // TODO: Add loadRecipes

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  Future<void> savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  Future<void> getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList(prefSearchKey);

    if (searches != null) {
      previousSearches = searches;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            _buildRecipeLoader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            // Replace
            const Icon(Icons.search),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) => startSearch(value),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    onSelected: (value) {
                      searchTextController.text = value;
                      startSearch(value);
                    },
                    itemBuilder: (context) {
                      return previousSearches
                          .map<CustomDropdownMenuItem<String>>(
                            (e) => CustomDropdownMenuItem<String>(
                              value: e,
                              text: e,
                              callback: () {
                                setState(() {
                                  previousSearches.remove(e);
                                  savePreviousSearches();
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();
    });

    if (!previousSearches.contains(value)) {
      previousSearches.add(value);

      savePreviousSearches();
    }
  }

  Widget _buildRecipeLoader(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        startSearch(searchTextController.text);
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }

  // TODO: Add _buildRecipeCard
}

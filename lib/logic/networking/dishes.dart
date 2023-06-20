import 'package:flutter/cupertino.dart';
import 'package:food/logic/dish.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food/logic/constants.dart';
import 'package:food/logic/category.dart';

class Dishes with ChangeNotifier {
  var data;

  void getDishesInfo() async {
    http.Response response = await http.get(Uri.parse(kItemsUrl));
    if (response.statusCode == 200) {
      String dataString = response.body;
      data = jsonDecode(dataString);
      getDishesTags();
      getAllDishes();
      getTagDishes();
      getCategories();
    } else {
      print(response.statusCode);
    }
  }

  //categories
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  void getCategories() async {
    http.Response response = await http.get(Uri.parse(kCategoriesUrl));

    if (response.statusCode == 200) {
      String dataString = response.body;
      final data = jsonDecode(dataString);
      for (var i = 0; i < data['сategories'].length; i++) {
        _categories.add(Category(
            id: data['сategories'][i]['id'],
            name: data['сategories'][i]['name'],
            imageUrl: data['сategories'][i]['image_url']));
      }
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  //dishes
  List<Dish> _listOfAllDishes = [];
  List<Dish> get listOfAllDishes => _listOfAllDishes;

  void getAllDishes() {
    for (var i = 0; i < data['dishes'].length; i++) {
      List<String> tags = [];
      for (String tag in data['dishes'][i]['tegs']) {
        tags.add(tag);
      }
      _listOfAllDishes.add(
        Dish(
          id: data['dishes'][i]['id'],
          name: data['dishes'][i]['name'],
          price: data['dishes'][i]['price'],
          weight: data['dishes'][i]['weight'],
          description: data['dishes'][i]['description'],
          imageUrl: data['dishes'][i]['image_url'],
          tags: tags,
        ),
      );
      notifyListeners();
    }
  }

  //dish tags
  List<String> _listOfTags = [];
  List<String> get listOfTags => _listOfTags;
  Set<String> _setOfTags = {};

  Map<String, bool> _tagsActivity = {};
  String _activeTag = '';
  String get activeTag => _activeTag;

  bool checkIfActive(String tag) => _tagsActivity[tag] == true;

  void getDishesTags() {
    for (var i = 0; i < data['dishes'].length; i++) {
      for (var j = 0; j < data['dishes'][i]['tegs'].length; j++) {
        if (_setOfTags.add(data['dishes'][i]['tegs'][j])) {
          _setOfTags.add(data['dishes'][i]['tegs'][j]);
          _listOfTags.add(data['dishes'][i]['tegs'][j]);
        }
      }
    }
    for (String item in _listOfTags) {
      if (item == _listOfTags[0]) {
        _tagsActivity[item] = true;
        _activeTag = item;
      } else {
        _tagsActivity[item] = false;
      }
    }
    notifyListeners();
  }

  void updateTagsActivity(String tag) {
    for (String item in _listOfTags) {
      if (item == tag) {
        _tagsActivity[item] = true;
        _activeTag = item;
        getTagDishes();
      } else {
        _tagsActivity[item] = false;
      }
    }
    notifyListeners();
  }

  //dishes by their tags

  List<Dish> _listOfTagDishes = [];
  List<Dish> get listOfTagDishes => _listOfTagDishes;

  void getTagDishes() {
    _listOfTagDishes.clear();
    for (var i = 0; i < data['dishes'].length; i++) {
      List<String> tags = [];
      for (String tag in data['dishes'][i]['tegs']) {
        tags.add(tag);
      }

      if (tags.contains(_activeTag)) {
        _listOfTagDishes.add(
          Dish(
            id: data['dishes'][i]['id'],
            name: data['dishes'][i]['name'],
            price: data['dishes'][i]['price'],
            weight: data['dishes'][i]['weight'],
            description: data['dishes'][i]['description'],
            imageUrl: data['dishes'][i]['image_url'],
            tags: tags,
          ),
        );
      }
      notifyListeners();
    }
  }
}

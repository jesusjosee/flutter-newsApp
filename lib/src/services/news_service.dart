import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const _URL_NEWS = 'https://newsapi.org/v2';
// ignore: constant_identifier_names
const _APIKEY = '50ac027653d947f3a05aa1bda9e2bc36';

class NewsService with ChangeNotifier {
  bool _isLoading = true;

  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  String _selectedCategory = 'business';

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();
    // categoryArticles[selectedCategory] = headlines;

    // Inicializar los categorias con listas vacias para ser llenadas en el metodo getArticlesByCategory
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
  }

  bool get isLoading => _isLoading;

  getTopHeadLines() async {
    final url =
        Uri.parse("$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us");
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final url = Uri.parse(
        "$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category");
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    _isLoading = false;

    notifyListeners();
  }

  get getArticulosCategoriaSelecionada => categoryArticles[selectedCategory];

  
}

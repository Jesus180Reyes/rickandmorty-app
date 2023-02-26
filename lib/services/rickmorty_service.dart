import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickmorty_app/models/rickmorty_response.dart';
// import 'package:rickmorty_app/models/rickmorty_response.dart';

class RickMortyService extends ChangeNotifier {
  List<Result> rickMortyList = [];
  bool isLoading = false;
  int page = 1;
  RickMortyService() {
    constructor();
  }

  void constructor() async {
    await getCharacters();
  }

  Future<List<Result>> getCharacters() async {
    final Uri url = Uri.parse(
      "https://rickandmortyapi.com/api/character?page=$page",
    );
    isLoading = true;
    notifyListeners();
    final resp = await http.get(url);
    final data = rickMortyResponseFromJson(resp.body);
    rickMortyList.addAll(data.results);
    isLoading = false;
    notifyListeners();
    return rickMortyList;
  }

  void addPage() {
    page++;
    notifyListeners();
  }
}

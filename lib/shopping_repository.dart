import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:food_app_1/catalog/catalog.dart';
import 'package:food_app_1/catalog/models/food_model.dart';

const _delay = Duration(milliseconds: 800);

class ShoppingRepository {
  final _favourite = <Meals>[];
  Future<List<Meals>> loadFavoriteFood() =>
      Future.delayed(_delay, () => _favourite);

  void addFoodToFavourite(Meals meals) => _favourite.add(meals);
  void removeFoodFromFavourite(Meals meals) => _favourite.remove(meals);

  Future<List<Meals>> getApi() async {
    try {
      List<Meals>? meals = <Meals>[];
      final response = await Dio()
          .get('https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef');
      // print(response);
      response.data['meals'].forEach((v) {
        meals.add(new Meals.fromJson(v));
      });
      return meals;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

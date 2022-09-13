import 'package:equatable/equatable.dart';
import 'package:food_app_1/catalog/catalog.dart';
import 'package:food_app_1/catalog/models/food_model.dart';

class Favorite extends Equatable {
  const Favorite({this.meals = const <Meals>[]});

  final List<Meals> meals;

  // int get totalPrice {
  //   return meals.fold(0, (total, current) => total + current.price);
  // }

  @override
  List<Object> get props => [meals];
}

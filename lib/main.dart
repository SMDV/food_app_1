import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_1/app.dart';
import 'package:food_app_1/shopping_repository.dart';
import 'package:food_app_1/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App(shoppingRepository: ShoppingRepository()));
}

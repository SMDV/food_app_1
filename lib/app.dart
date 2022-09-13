import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_1/catalog/catalog.dart';
import 'package:food_app_1/details/view/food_details.dart';
import 'package:food_app_1/favorite/bloc/favorite_bloc.dart';
import 'package:food_app_1/favorite/view/favorite_page.dart';
import 'package:food_app_1/shopping_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.shoppingRepository});

  final ShoppingRepository shoppingRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CatalogBloc(
            shoppingRepository: shoppingRepository,
          )..add(CatalogStarted()),
        ),
        BlocProvider(
          create: (_) => FavoriteBloc(
            shoppingRepository: shoppingRepository,
          )..add(FavoriteStarted()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Food Apps',
        initialRoute: '/',
        routes: {
          '/': (_) => const CatalogPage(),
          '/cart': (_) => const FavoritePage(),
          '/food_details': (_) => const FoodDetails(),
        },
      ),
    );
  }
}

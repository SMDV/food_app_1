import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_1/catalog/catalog.dart';
import 'package:food_app_1/catalog/models/food_model.dart';
import 'package:food_app_1/favorite/bloc/favorite_bloc.dart';
import 'package:food_app_1/favorite/model/favorite.dart';

class FoodDetails extends StatelessWidget {
  const FoodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final itemNameStyle = Theme.of(context).textTheme.headline6;
    if (ModalRoute.of(context)!.settings.arguments == null) {
      return Scaffold(
        appBar: AppBar(title: Text("no items selected!")),
        body: Center(
          child: Container(
            child: Text("Something went wrong"),
          ),
        ),
      );
    } else {
      Meals item = ModalRoute.of(context)!.settings.arguments as Meals;
      return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(item.strMeal.toString())),
            body: Center(
              child: Column(
                children: [
                  LimitedBox(
                    maxHeight: 500,
                    child: Container(
                      child: Image.network(item.strMealThumb.toString(),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(item.strMeal.toString(), style: itemNameStyle),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is FavoriteLoaded) ...[
                    ElevatedButton(
                      onPressed: state.favorite.meals.contains(item)
                          ? () => context
                              .read<FavoriteBloc>()
                              .add(FavoriteItemRemoved(item))
                          : () => context
                              .read<FavoriteBloc>()
                              .add(FavoriteItemAdded(item)),
                      child: state.favorite.meals.contains(item)
                          ? const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 50,
                            )
                          : Icon(
                              Icons.favorite,
                              color: Colors.yellow,
                              size: 50,
                            ),
                    )
                  ]
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_1/favorite/bloc/favorite_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Favorite Food')),
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CartList(),
              ),
            ),
            // Divider(height: 4, color: Colors.black),
            // CartTotal()
          ],
        ),
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    final itemNameStyle = Theme.of(context).textTheme.headline6;

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const CircularProgressIndicator();
        }
        if (state is FavoriteLoaded) {
          return ListView.separated(
            itemCount: state.favorite.meals.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final item = state.favorite.meals[index];
              return Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  leading: const Icon(Icons.done),
                  title: Text(item.strMeal.toString(), style: itemNameStyle),
                  // onLongPress: () {
                  //   context.read<CartBloc>().add(CartItemRemoved(item));
                  // },
                ),
              );
            },
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }
}

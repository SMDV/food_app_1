import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_1/catalog/catalog.dart';
import 'package:food_app_1/catalog/models/food_model.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CatalogAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              // if (state is CatalogLoaded) {
              //   return SliverList(
              //     delegate: SliverChildBuilderDelegate(
              //       (context, index) => CatalogListItem(
              //         state.catalog.getByPosition(index),
              //       ),
              //       childCount: state.catalog.itemNames.length,
              //     ),
              //   );
              // }
              if (state is CatalogLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => CatalogListFood(
                      state.catalog.meals![index],
                    ),
                    childCount: state.catalog.meals?.length,
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Text('Something went wrong!'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CatalogAppBar extends StatelessWidget {
  const CatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Catalog'),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () => Navigator.of(context).pushNamed('/cart'),
        ),
        SizedBox(
          width: 15,
        )
      ],
    );
  }
}

// class CatalogListItem extends StatelessWidget {
//   const CatalogListItem(this.item, {super.key});

//   final Item item;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme.headline6;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: LimitedBox(
//         maxHeight: 48,
//         child: Row(
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   //context.read<CartBloc>().add(CartItemSelected(item));
//                   Navigator.of(context)
//                       .pushNamed('/food_details', arguments: item);
//                 },
//                 child: Row(
//                   children: [
//                     AspectRatio(
//                         aspectRatio: 1, child: ColoredBox(color: item.color)),
//                     const SizedBox(width: 24),
//                     Expanded(child: Text(item.name, style: textTheme)),
//                     const SizedBox(width: 24),
//                     AddButton(item: item),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CatalogListFood extends StatelessWidget {
  const CatalogListFood(this.meals, {super.key});

  final Meals meals;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  //context.read<CartBloc>().add(CartItemSelected(item));
                  Navigator.of(context)
                      .pushNamed('/food_details', arguments: meals);
                },
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(meals.strMealThumb.toString()),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                        child:
                            Text(meals.strMeal.toString(), style: textTheme)),
                    const SizedBox(width: 24),
                    // AddButton(item: item),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

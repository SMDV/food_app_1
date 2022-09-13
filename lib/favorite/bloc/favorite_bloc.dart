import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../catalog/models/food_model.dart';
import '../../shopping_repository.dart';
import '../model/favorite.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required this.shoppingRepository}) : super(FavoriteLoading()) {
    on<FavoriteStarted>(_onStarted);
    on<FavoriteItemAdded>(_onItemAdded);
    on<FavoriteItemRemoved>(_onItemRemoved);
  }
  final ShoppingRepository shoppingRepository;

  Future<void> _onStarted(
      FavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final items = await shoppingRepository.loadFavoriteFood();
      emit(FavoriteLoaded(favorite: Favorite(meals: [...items])));
    } catch (_) {
      emit(FavoriteError());
    }
  }

  Future<void> _onItemAdded(
    FavoriteItemAdded event,
    Emitter<FavoriteState> emit,
  ) async {
    final state = this.state;
    if (state is FavoriteLoaded) {
      try {
        shoppingRepository.addFoodToFavourite(event.meals);
        emit(FavoriteLoaded(
            favorite: Favorite(meals: [...state.favorite.meals, event.meals])));
      } catch (_) {
        emit(FavoriteError());
      }
    }
  }

  void _onItemRemoved(FavoriteItemRemoved event, Emitter<FavoriteState> emit) {
    final state = this.state;
    if (state is FavoriteLoaded) {
      try {
        shoppingRepository.removeFoodFromFavourite(event.meals);
        emit(
          FavoriteLoaded(
            favorite: Favorite(
              meals: [...state.favorite.meals]..remove(event.meals),
            ),
          ),
        );
      } catch (_) {
        emit(FavoriteError());
      }
    }
  }
}

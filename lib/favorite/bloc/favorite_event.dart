part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteStarted extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class FavoriteItemAdded extends FavoriteEvent {
  const FavoriteItemAdded(this.meals);

  final Meals meals;

  @override
  List<Object> get props => [meals];
}

class FavoriteItemRemoved extends FavoriteEvent {
  const FavoriteItemRemoved(this.meals);

  final Meals meals;

  @override
  List<Object> get props => [meals];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_app_1/catalog/catalog.dart';
import 'package:food_app_1/catalog/models/food_model.dart';
import 'package:food_app_1/shopping_repository.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required this.shoppingRepository}) : super(CatalogLoading()) {
    on<CatalogStarted>(_onStarted);
  }

  final ShoppingRepository shoppingRepository;

  Future<void> _onStarted(
    CatalogStarted event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoading());
    try {
      // final catalog = await shoppingRepository.loadCatalog();
      List<Meals> food = await shoppingRepository.getApi();
      print(food[0].strMeal);
      // emit(CatalogLoaded(Catalog(itemNames: catalog)));
      emit(CatalogLoaded(FoodModel(meals: food)));
    } catch (_) {
      emit(CatalogError());
    }
  }
}

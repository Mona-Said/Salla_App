import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubit/states.dart';
import 'package:salla/models/change_favorites_model.dart';
import 'package:salla/models/login_model.dart';
import '../models/categories_model.dart';
import '../models/get_favorites_model.dart';
import '../models/home_model.dart';
import '../modules/categories/categories_screen.dart';
import '../modules/favorites/favorites_screen.dart';
import '../modules/products/products_screen.dart';
import '../modules/settings/settings_screen.dart';
import '../shared/components/constants.dart';
import '../shared/network/remote/dio_helper_shop_app.dart';
import '../shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopAppLoadingHomeDataState());
    ShopDioHelper.shopGetData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel?.data?.banners[0].id);
      print(homeModel?.toString());

      homeModel?.data?.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorites);
      emit(ShopAppSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    ShopDioHelper.shopGetData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopAppSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopAppChangeFavoritesState());
    ShopDioHelper.shopPostData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }

      emit(ShopAppSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopAppErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopAppLoadingFavoritesState());
    ShopDioHelper.shopGetData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopAppSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorFavoritesState());
    });
  }

  ShopLoginModel? userData;
  void getUserData() {
    emit(ShopAppLoadingGetUserDataState());
    ShopDioHelper.shopGetData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopAppSuccessGetUserDataState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopAppLoadingUpdateUserDataState());
    ShopDioHelper.shopPutData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopAppSuccessUpdateUserDataState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorUpdateUserDataState());
    });
  }
}

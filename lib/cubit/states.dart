import '../models/change_favorites_model.dart';
import '../models/login_model.dart';

abstract class ShopStates {}

class ShopAppInitialState extends ShopStates {}

class ShopAppChangeBottomNavState extends ShopStates {}

class ShopAppLoadingHomeDataState extends ShopStates {}

class ShopAppSuccessHomeDataState extends ShopStates {}

class ShopAppErrorHomeDataState extends ShopStates {}

class ShopAppSuccessCategoriesState extends ShopStates {}

class ShopAppErrorCategoriesState extends ShopStates {}

class ShopAppChangeFavoritesState extends ShopStates {}

class ShopAppSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel? model;

  ShopAppSuccessChangeFavoritesState(this.model);
}

class ShopAppErrorChangeFavoritesState extends ShopStates {}

class ShopAppLoadingFavoritesState extends ShopStates {}

class ShopAppSuccessFavoritesState extends ShopStates {}

class ShopAppErrorFavoritesState extends ShopStates {}

class ShopAppLoadingGetUserDataState extends ShopStates {}

class ShopAppSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopAppSuccessGetUserDataState(this.loginModel);
}

class ShopAppErrorGetUserDataState extends ShopStates {}

class ShopAppLoadingUpdateUserDataState extends ShopStates {}

class ShopAppSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopAppSuccessUpdateUserDataState(this.loginModel);
}

class ShopAppErrorUpdateUserDataState extends ShopStates {}

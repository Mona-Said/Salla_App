import '../../../models/login_model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppLoadingState extends ShopAppStates {}

class ShopAppSuccessState extends ShopAppStates {
  final ShopLoginModel loginModel;

  ShopAppSuccessState(this.loginModel);
}

class ShopAppErrorState extends ShopAppStates {
  final String error;
  ShopAppErrorState(
    this.error,
  );
}

class ShopAppChangeVisibilityState extends ShopAppStates {}

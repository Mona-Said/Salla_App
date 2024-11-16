import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/register/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper_shop_app.dart';
import '../../../shared/network/remote/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    ShopDioHelper.shopPostData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
      lang: 'en',
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ShopRegisterChangeVisibilityState());
  }
}

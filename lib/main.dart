import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/bloc_observer.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/remote/dio_helper_shop_app.dart';
import 'package:salla/shared/styles/themes.dart';
import 'cubit/cubit.dart';
import 'layout/shop_layout_screen.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  ShopDioHelper.shopInit();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  //print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayoutScreen();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = const OnboardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({
    super.key,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}

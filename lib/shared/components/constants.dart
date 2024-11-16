// https://newsapi.org/v2/everything?q=tesla&apiKey=abdea69a40a24a64be364ed51325ba9f

import '../../modules/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void logOut(context) {
  CacheHelper.deleteData(key: 'token').then((value) {
    if (value!) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String? token = '';
String? uId = '';

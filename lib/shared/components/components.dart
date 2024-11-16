import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubit/cubit.dart';

Widget defaultButton({
  Color color = Colors.blueAccent,
  double width = double.infinity,
  required String text,
  required VoidCallback function,
}) =>
    SizedBox(
      width: width,
      height: 50.0,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: MaterialButton(
          color: color,
          onPressed: function,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

Widget textButton({
  required String text,
  required VoidCallback function,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );

Widget formField({
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  IconData? suffix,
  required TextInputType type,
  required String? Function(String?)? function,
  String? Function(String?)? submit,
  String? Function(String?)? onChanged,
  VoidCallback? pressed,
  VoidCallback? onTap,
  bool isClickable = true,
  bool isPassword = false,
}) =>
    Container(
      width: double.infinity,
      height: 60.0,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: pressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
        ),
        keyboardType: type,
        style: const TextStyle(fontSize: 15.0),
        obscureText: isPassword,
        validator: function,
        onTap: onTap,
        enabled: isClickable,
        onFieldSubmitted: submit,
        onChanged: onChanged,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 30.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

void itemToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColorToast(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, warning, error }

Color chooseColorToast(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildProductList(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model!.image}'),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: (ShopCubit.get(context)
                                          .favorites[model.id!] !=
                                      null &&
                                  ShopCubit.get(context).favorites[model.id!]!)
                              ? Colors.brown
                              : Colors.white,
                          child: Icon(
                            Icons.favorite_border,
                            size: 15.0,
                            color:
                                (ShopCubit.get(context).favorites[model.id!] !=
                                            null &&
                                        ShopCubit.get(context)
                                            .favorites[model.id!]!)
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

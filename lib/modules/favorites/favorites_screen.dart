import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopAppLoadingFavoritesState,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildProductList(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data?[index]
                    .product,
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  // Widget buildFavItem(ProductData? model,context)=> Padding(
  //   padding: const EdgeInsets.all(20.0),
  //   child: Container(
  //     height: 120.0,
  //     child: Row(
  //       children:
  //       [
  //         Stack(
  //           alignment: AlignmentDirectional.bottomStart,
  //           children: [
  //              Image(
  //               image: NetworkImage('${model!.product!.image}'),
  //               width: 120.0,
  //               height: 120.0,
  //             ),
  //             if(model.product!.discount != 0)
  //               Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
  //                 color: Colors.red,
  //                 child: const Text(
  //                   'DISCOUNT',
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 10.0
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //         const SizedBox(
  //           width: 15.0,
  //         ),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //                Text(
  //                 '${model.product!.name}',
  //                 style: const TextStyle(
  //                   fontSize: 14.0,
  //                   height: 1.3,
  //                 ),
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               const Spacer(),
  //               Row(
  //                 children:
  //                 [
  //                    Text(
  //                     model.product!.price.toString(),
  //                     style: const TextStyle(
  //                       fontSize: 13.0,
  //                       color: Colors.brown,
  //                     ),
  //
  //                   ),
  //                   const SizedBox(
  //                     width: 10.0,
  //                   ),
  //                   if(model.product!.discount != 0)
  //                      Text(
  //                       model.product!.oldPrice.toString(),
  //                       style: const TextStyle(
  //                         fontSize: 10.0,
  //                         color: Colors.grey,
  //                         decoration: TextDecoration.lineThrough,
  //                       ),
  //
  //                     ),
  //                   const Spacer(),
  //                   IconButton(
  //                     onPressed: ()
  //                     {
  //                       ShopCubit.get(context).changeFavorites(model.product!.id!);
  //                     },
  //                     icon: CircleAvatar(
  //                       radius: 15.0,
  //                       backgroundColor: (ShopCubit.get(context).favorites[model.product!.id!] != null &&
  //                           ShopCubit.get(context).favorites[model.product!.id!]!)? Colors.brown: Colors.white,
  //                       child: Icon(
  //                         Icons.favorite_border,
  //                         size: 15.0,
  //                         color: (ShopCubit.get(context).favorites[model.product!.id!] != null &&
  //                             ShopCubit.get(context).favorites[model.product!.id!]!) ? Colors.white : Colors.black,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}

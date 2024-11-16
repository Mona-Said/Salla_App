import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopAppSuccessChangeFavoritesState) {
          if (!state.model!.status!) {
            itemToast(
              text: state.model!.message!,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => buildItem(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildItem(
      HomeModel? model, CategoriesModel? categoriesModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data?.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              reverse: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data?.data[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16.0,
                    ),
                    itemCount: categoriesModel!.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.72,
              children: List.generate(
                  model!.data!.products.length,
                  (index) =>
                      buildItemGrid(model.data?.products[index], context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemGrid(HomeProducts? item, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(item!.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (item.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${item.price.round()}',
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (item.discount != 0)
                        Text(
                          '${item.oldPrice.round()}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(item.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: (ShopCubit.get(context)
                                          .favorites[item.id] !=
                                      null &&
                                  ShopCubit.get(context).favorites[item.id]!)
                              ? Colors.brown
                              : Colors.white,
                          child: Icon(
                            Icons.favorite_border,
                            size: 15.0,
                            color: (ShopCubit.get(context).favorites[item.id] !=
                                        null &&
                                    ShopCubit.get(context).favorites[item.id]!)
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
      );

  Widget buildCategoryItem(DataModel? model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model?.image}'),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            width: 100.0,
            child: Text(
              '${model?.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}

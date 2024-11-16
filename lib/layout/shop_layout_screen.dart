import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            selectedItemColor: Colors.brown,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

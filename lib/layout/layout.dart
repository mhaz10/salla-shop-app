import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../shared/cubit/cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Salla',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

            actions: [
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
              }, icon: Icon(Icons.search)),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                ShopAppCubit.get(context).changeBottomNavBar(index: index);
              },
              currentIndex: ShopAppCubit.get(context).currentIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ]),

          body: IndexedStack(
            index: ShopAppCubit.get(context).currentIndex,
            children: [
              HomeScreen(),
              CategoryScreen(),
              FavoritesScreen(),
              SettingsScreen(),
            ],
          ),

        );
      },
    );
  }
}

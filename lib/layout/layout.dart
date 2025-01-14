import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        if (state is ShopAppSuccessChangeFavoritesState) {
          Fluttertoast.showToast(
              msg: state.changeFavoritesModel.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
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

          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(context),
                  buildMenuItem(context, ShopAppCubit.get(context).isDark),
                ],
              ),
            ),
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
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
              ]),

          body: IndexedStack(
            index: ShopAppCubit.get(context).currentIndex,
            children: [
              HomeScreen(),
              CategoryScreen(),
              FavoritesScreen(),
            ],
          ),

        );
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Colors.blue.shade700,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/user_profile.png'),
          ),
          SizedBox(height: 12,),
          Text('Amr Hosny', style: TextStyle(fontSize: 28, color: Colors.white),),
          Text('AmrHosny@gamil.com', style: TextStyle(fontSize: 16, color: Colors.white),),
        ],
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
      
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text(ShopAppCubit.get(context).language ?? 'ar'),
            trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("EN"),
                    onTap: (){
                      ShopAppCubit.get(context).changeAppLanguage(lang: 'en');
                    },
                  ),
                  PopupMenuItem(
                    child: Text("AR"),
                    onTap: () {
                      ShopAppCubit.get(context).changeAppLanguage(lang: 'ar');
                    },
                  ),
                ]),
          ),
          ListTile(
            leading: Icon(isDark ?  Icons.dark_mode : Icons.light_mode),
            title: const Text('Dark Mode'),
            subtitle: Text(isDark ? 'ON' : 'OFF'),
            selectedColor: Colors.green,
            trailing: Switch(
                value: isDark,
                onChanged: (value) {
                  ShopAppCubit.get(context).changeAppMode(value: value);
                }),
          ),
        ],
      ),
    );
  }
}

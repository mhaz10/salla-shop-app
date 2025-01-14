import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/categories/category.model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
  listener: (context, state) {},

  builder: (context, state) {
    return ConditionalBuilder(
      condition: state is! ShopAppChangeLanguageLoading && ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).categoryModel != null,
      builder: (context) => homePageBuilder(ShopAppCubit.get(context).homeModel!,ShopAppCubit.get(context).categoryModel!, context),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
  },
);
  }

  Widget homePageBuilder (HomeModel homeModel, CategoryModel categoryModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: homeModel.data!.banners.map((banner) => Image.network(
              banner.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error, color: Colors.red, size: 50),
                );
              },
            )
            ).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
          SizedBox(height: 14,),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),

                Container(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => categoryBuilder(categoryModel.categoryData!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(width: 14,),
                        itemCount: categoryModel.categoryData!.data.length)),

                SizedBox(height: 20,),

                Text('Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 14,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1 / 1.55,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: List.generate(homeModel.data!.products.length, (index) => productsBuilder(homeModel.data!.products[index], context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryBuilder (DataModel dataModel) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          dataModel.image!,
          height: 100,
          width: 100,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(Icons.error, color: Colors.red, size: 50),
            );
          },
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.3),
          child: Text(dataModel.name! , maxLines: 1, overflow:  TextOverflow.ellipsis, textAlign: TextAlign.center ,style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }

  Widget productsBuilder (Product product, context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(product.image!, fit: BoxFit.fill, width: double.infinity , height: 180, errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error, color: Colors.red, size: 50),
                );
              },),
              if(product.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text('DISCOUNT', style: TextStyle(fontSize: 12, color: Colors.white),),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(product.name!, maxLines: 2, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(product.price!.toString(), style: TextStyle(color: Colors.blue),),
                    SizedBox(width: 5,),
                    if(product.discount != 0)
                    Text(product.oldPrice!.toString(), style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough)),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopAppCubit.get(context).changeFavorites(productId: product.id!);
                        },
                        icon: CircleAvatar(backgroundColor: ShopAppCubit.get(context).favorites[product.id]! ? Colors.blue : Colors.grey, radius: 20 , child: Icon(Icons.favorite_border, color: Colors.white,)))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

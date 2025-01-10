import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: ShopAppCubit.get(context).homeModel != null,
      builder: (context) => homePageBuilder(ShopAppCubit.get(context).homeModel!),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
  }

  Widget homePageBuilder (HomeModel homeModel) {
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
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1 / 1.55,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: List.generate(homeModel.data!.products.length, (index) => productsBuilder(homeModel.data!.products[index])),
            ),
          ),
        ],
      ),
    );
  }

  Widget productsBuilder (Product product) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(product.image!, width: double.infinity , height: 180, errorBuilder: (context, error, stackTrace) {
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
                    IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
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

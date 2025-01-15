import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../models/favorites/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {},

      builder: (context, state) {

        return ConditionalBuilder(
            condition: state is! ShopAppLoadingFavoritesState && ShopAppCubit.get(context).favoritesModel != null,

            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavoritesItem(
                    ShopAppCubit.get(context)
                        .favoritesModel!
                        .favoritesData!
                        .data[index]
                        .product!,
                    context),
                separatorBuilder: (context, index) => Divider(),
                itemCount: ShopAppCubit.get(context)
                    .favoritesModel!
                    .favoritesData!
                    .data
                    .length),

            fallback: (context) => Center(
                child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildFavoritesItem(Product product, context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                product.image!,
                width: 140,
                height: 140,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.error, color: Colors.red, size: 50),
                  );
                },
              ),
              if (product.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      product.price.toString(),
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (product.discount != 0)
                      Text(product.oldPrice.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough)),
                    Spacer(),
                    IconButton(
                        // TODO
                        onPressed: () {
                          ShopAppCubit.get(context)
                              .changeFavorites(productId: product.id!);
                        },
                        icon: CircleAvatar(
                            backgroundColor:
                                ShopAppCubit.get(context).favorites[product.id]!
                                    ? Colors.blue
                                    : Colors.grey,
                            radius: 20,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

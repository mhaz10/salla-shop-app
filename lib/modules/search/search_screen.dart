import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../models/search/search_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},

        builder: (context, state) {


          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_new)),

              title: searchBox(
                controller: searchController,
                hintText: 'Enter Your Search',
                onFieldSubmitted: (value) {
                  String text = "${searchController.text}";
                    SearchCubit.get(context).search(text: text);
                    SearchCubit.get(context).getSearch(text);
                }
              ),
            ),


            body: ConditionalBuilder(
                condition: SearchCubit.get(context).searchList.length > 0 ,

                builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => productsBuilder(SearchCubit.get(context).searchList[index]),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: SearchCubit.get(context).searchList.length),

                fallback: (context) => Center(child: Text('There are no results to display', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w400),),),),
          );
        },
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

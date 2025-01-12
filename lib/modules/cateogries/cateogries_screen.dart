import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../models/categories/category.model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopAppCubit.get(context).categoryModel != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildCategoryItem(ShopAppCubit.get(context).categoryModel!.categoryData!.data[index]),
                separatorBuilder: (context, index) => Divider(),
                itemCount: ShopAppCubit.get(context).categoryModel!.categoryData!.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator(),));
      },
    );
  }

  Widget buildCategoryItem(DataModel dataModel) {
    return Row(
      children: [
        Image.network(
          dataModel.image!,
          width: 150,
          height: 150,
          errorBuilder: (context, error, stackTrace) =>
              Center(child: Icon(Icons.error, color: Colors.red, size: 50)),
        ),
        SizedBox(width: 20,),
        Text(dataModel.name!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    );
  }
}

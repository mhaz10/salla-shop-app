import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        if (state is ShopAppSuccessUpdateState) {
          Fluttertoast.showToast(
            msg: state.loginModel.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
      },
      builder: (context, state) {

        if (ShopAppCubit.get(context).userData != null ) {
          nameController.text = ShopAppCubit.get(context).userData!.data!.name!;
          phoneController.text = ShopAppCubit.get(context).userData!.data!.phone!;
          emailController.text = ShopAppCubit.get(context).userData!.data!.email!;
        }

        return ConditionalBuilder(
            condition: ShopAppCubit.get(context).userData != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                
                    if (state is ShopAppLoadingUpdateState)
                
                      LinearProgressIndicator(),
                
                    SizedBox(height: 20,),
                
                    defaultFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person)),
                
                    SizedBox(height: 20,),
                
                    defaultFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone)),
                
                    SizedBox(height: 20,),
                
                    defaultFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email)),
                
                    SizedBox(height: 20,),
                
                    defaultButton(function: (){
                      ShopAppCubit.get(context).updateProfile(name: nameController.text, phone: phoneController.text, email: emailController.text);
                    }, widget: Text('UDATE')),
                
                    SizedBox(height: 20,),
                
                    defaultButton(function: (){
                      CacheHelper.removeData(key: 'token').then((value) {
                        ShopAppCubit.get(context).Logout();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                      },);
                    }, widget: Text('LOGOUT'))
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}

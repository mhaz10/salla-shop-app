import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

   GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
            if (state.loginModel.status!){
              CacheHelper.saveData(key: 'token' , value: state.loginModel.data!.token)
                  .then((value) {

                    TOKEN = state.loginModel.data!.token!;

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeLayout(),), (route) => false,);
                  },);
            }
          }
        },

        builder: (context, state) {
          return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/login.png', width: double.infinity, height: 280, ),
                  SizedBox(height: 30.0,),
                  Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
                  SizedBox(height: 20,),
                  Text ('Login now to browse our hot offers', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),),
                  SizedBox(height: 30,),

                  defaultFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter your email address';
                      }
                      return null;
                    },
                    hintText: 'Write Your Email',
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email)),

                  SizedBox(height: 20,),

                  defaultFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter your password address';
                      }
                      return null;
                    },
                    hintText: 'Write Your Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(onPressed: (){
                      LoginCubit.get(context).changePasswordVisibility();}, icon: LoginCubit.get(context).suffixIcon),
                    obscureText: LoginCubit.get(context).visiblePassword,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock)),

                  SizedBox(height: 20,),

                  state is! LoginLoadingState ?
                  defaultButton(function: (){if(formKey.currentState!.validate()){ LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                    }}, widget: Text('Login'.toUpperCase(),style:  TextStyle(color: Colors.white),)) : defaultButton(function: (){}, widget: CircularProgressIndicator()),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                      }, child: Text('REGISTER'),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}

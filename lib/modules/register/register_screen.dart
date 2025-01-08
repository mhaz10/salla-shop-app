import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/state.dart';
import '../../shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
   
   GlobalKey<FormState> formKey = GlobalKey();
   TextEditingController nameController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if (state is RegisterSuccessState) {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/login.png', width: double.infinity, height: 280, ),
                  SizedBox(height: 30.0,),
                  Text('REGISTER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
                  SizedBox(height: 20,),
                  Text ('Register now to browse our hot offers', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),),
                  SizedBox(height: 30,),
              
                  defaultFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      hintText: 'Write Your name',
                      keyboardType: TextInputType.text,
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person)),
              
                  SizedBox(height: 20,),
              
                  defaultFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your phone';
                        }
                        return null;
                      },
                      hintText: 'Write Your name',
                      keyboardType: TextInputType.number,
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone)),
              
                  SizedBox(height: 20,),
              
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
                        RegisterCubit.get(context).changePasswordVisibility();}, icon: RegisterCubit.get(context).suffixIcon),
                      obscureText: RegisterCubit.get(context).visiblePassword,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock)),
              
                  SizedBox(height: 20,),
              
                  state is! RegisterLoadingState ? defaultButton(function: (){if(formKey.currentState!.validate()){
                    RegisterCubit.get(context).userRegister(name: nameController.text, phone: phoneController.text, email: emailController.text, password: passwordController.text);
                  }}, widget: Text('Register'.toUpperCase(),style:  TextStyle(color: Colors.white),)) : defaultButton(function: (){}, widget: CircularProgressIndicator()),
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

import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                  hintText: 'Write Your Email',
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email)),
            
                SizedBox(height: 20,),
            
                defaultFormField(
                  controller: passwordController,
                  hintText: 'Write Your Password',
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.visibility_off)),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock)),
            
                SizedBox(height: 20,),
            
                defaultButton(function: (){}, text: 'login'),
                
                SizedBox(height: 20,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(onPressed: (){}, child: Text('REGISTER'),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

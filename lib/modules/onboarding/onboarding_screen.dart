import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
   OnboardingScreen({super.key});

  PageController controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            isLastPage = index == 2;
          },
          children: [
            buildPage(color: Colors.white, image: 'assets/images/onboarding_2.png', title: 'Offers', subTitle: 'Enjoy with us exclusive offers and discounts'),
            buildPage(color: Colors.white, image: 'assets/images/onboarding_3.png', title: 'Payment', subTitle: 'Easy payment in different and secure ways'),
            buildPage(color: Colors.white, image: 'assets/images/onboarding_1.png', title: 'Delivered', subTitle: 'Easy delivery of products anywhere')
          ],
        ),
      ),

      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
              },);
            }, child: Text('Skip')),
            Center(child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
              activeDotColor: Colors.black,
              dotColor: Colors.grey,
              spacing: 16),
              onDotClicked: (index) {
                controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              },
            )),
            TextButton(onPressed: (){
              if (isLastPage == false){
                controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              } else {
                CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
                },);
              }
            }, child: Text('Next')),
          ],
        ),
      ),
    );
  }

  Widget buildPage ({required Color color, required String image, required String title, required String subTitle}) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,),

          SizedBox(height: 50,),

          Text(title, style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),

          SizedBox(height: 24,),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(subTitle, style: TextStyle(color: Colors.black),),
          )
        ],
      ),
    );
  }
}

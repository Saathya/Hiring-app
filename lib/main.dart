import 'package:flutter/material.dart';
import 'package:labour_app/Forms/Registration_form.dart';
import 'package:labour_app/Forms/formsScreen.dart';
// import 'package:labour_app/Forms/feedbackform.dart';
import 'package:labour_app/Forms/userReview_screen.dart';
import 'package:labour_app/Provider/catProvider.dart';
import 'package:labour_app/Screens/Authentication/EmailAuthScreen.dart';
import 'package:labour_app/Screens/Authentication/email_verification_screen.dart';
// import 'package:labour_app/Screens/Authentication/phone_auth_screen.dart';
// import 'package:labour_app/Screens/Authentication/phone_auth_screen.dart';
import 'package:labour_app/Screens/Authentication/reset_password.dart';
import 'package:labour_app/Screens/categories/screens_categories.dart';
// import 'package:labour_app/Screens/categories/subCat_screen.dart';
import 'package:labour_app/Screens/home_screen.dart';
import 'package:labour_app/Screens/login_screen.dart';
import 'package:labour_app/Screens/main_screen.dart';
import 'package:labour_app/Screens/product_by_category.dart';
import 'package:labour_app/Screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'Provider/productProvider.dart';
// import 'Screens/location_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => CategoryProvider()),
         Provider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LogIn.id: (context) => LogIn(),
        //  PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        // LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        EmailAuthScreen.id: (context) => EmailAuthScreen(),
        EmailVerificationScreen.id: (context) => EmailVerificationScreen(),
        ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
        CategoryListScreen.id: (context) => CategoryListScreen(),
        // SubCatList.id:(context) => SubCatList(),
        MainScreen.id: (context) => MainScreen(),
        RegisterCarForm.id: (context) => RegisterCarForm(),
         ProductByCategory.id: (context) => ProductByCategory(),
        //  RegistrationCategory.id :(context) => RegistrationCategory(),
        //  RegistrationSubCat.id :(context) => RegistrationSubCat(),
          UserReviewScreen.id: (context) => UserReviewScreen(),
          FormsScreen.id: (context) => FormsScreen(),
          // FeedbackForm.id: (context) => FeedbackForm(),
      
      },
    );

    //FutureBuilder(
    //   // Replace the 3 second delay with your initialization code:
    //   future: Future.delayed(Duration(seconds: 7)),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     // Show splash screen while waiting for app resources to load:
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(
    //           theme: ThemeData(
    //             primaryColor: Colors.cyan.shade900,
    //           ),
    //           debugShowCheckedModeBanner: false,
    //           home: SplashScreen());
    //     } else {
    //       // Loading is done, return the app:
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(
    //           primaryColor: Colors.cyan.shade900,
    //         ),
    //         home: LogIn(),
    //         routes: {
    //           LogIn.id: (context) => LogIn(),
    //           PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
    //           LocationScreen.id: (context) => LocationScreen(),
    //         },
    //       );
    //     }
    //   },
    // );
  }
}

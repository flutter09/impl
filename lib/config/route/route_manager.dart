

import 'package:chat_application/presentation/screen/sing_in_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/resources/string_manager.dart';


class Routes {
  // static const String splashRoute = "/";
  // static const String onBoardingRoute = "/onBoarding";
  static const String signInRoute = "/signIn";
  static const String signUpRoute = "/signUp";
//static const String registerRoute = "/register";
//static const String forgotPasswordRoute = "/forgotPassword";
//static const String mainRoute = "/main";
//static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) =>  SignInScreen());
    // case Routes.loginRoute:
    // //initLoginModule();
    //   return MaterialPageRoute(builder: (_) => LoginView());
    // case Routes.onBoardingRoute:
    //   return MaterialPageRoute(builder: (_) => OnBoardingView());
    // case Routes.registerRoute:
    // //initRegisterModule();
    //   return MaterialPageRoute(builder: (_) => RegisterView());
    // case Routes.forgotPasswordRoute:
    // //initForgotPasswordModule();
    //   return MaterialPageRoute(builder: (_) => ForgotPasswordView());
    // case Routes.mainRoute:
    // //initHomeModule();
    //   return MaterialPageRoute(builder: (_) => MainView());
    // case Routes.storeDetailsRoute:
    // //initStoreDetailsModule();
    //   return MaterialPageRoute(builder: (_) => StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title:  const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound)),
        ));
  }
}
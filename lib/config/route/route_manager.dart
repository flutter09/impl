import 'package:chat_application/presentation/screen/chat/chat_details_screen.dart';
import 'package:chat_application/presentation/screen/chat/chat_list_screen.dart';
import 'package:chat_application/presentation/screen/chat/chat_setting_screen.dart';
import 'package:chat_application/presentation/screen/chat/create_group_screen.dart';
import 'package:chat_application/presentation/screen/group/create_group_new_screen.dart';
import 'package:chat_application/presentation/screen/group/group_list_screen.dart';
import 'package:chat_application/presentation/screen/login/forgot_password_screen.dart';
import 'package:chat_application/presentation/screen/login/generate_password_screen.dart';
import 'package:chat_application/presentation/screen/login/otp_varification_screen.dart';
import 'package:chat_application/presentation/screen/login/sing_in_screen.dart';
import 'package:chat_application/presentation/screen/login/sing_up_screen.dart';
import 'package:chat_application/presentation/screen/media/media_viewer.dart';
import 'package:chat_application/presentation/screen/project/create_project_screen.dart';
import 'package:chat_application/presentation/screen/project/project_detail_screen.dart';
import 'package:chat_application/presentation/screen/project/project_list_screen.dart';
import 'package:chat_application/presentation/screen/user/add_user_screen.dart';
import 'package:chat_application/presentation/screen/user/personal_info_screen.dart';
import 'package:chat_application/presentation/screen/user/user_list_screen.dart';
import 'package:flutter/material.dart';

import '../../domain/model/response/res_project.dart';
import '../../presentation/screen/main_screen.dart';
import '../../presentation/screen/user/select_custom_user_screen.dart';
import '../../utils/resources/string_manager.dart';

class ArgConstant {
  static const String eMail = "e-mail";
  static const String otpType = "otpType";
}

class Routes {
  // static const String splashRoute = "/";
  // static const String onBoardingRoute = "/onBoarding";
  static const String signInRoute = "/signIn";
  static const String signUpRoute = "/signUp";
  static const String chatListRoute = "/chat_list";
  static const String chatDetailsRoute = "/chat_detail_screen";
  static const String createProjectRoute = "/create_project_screen";
  static const String createGroupRoute = "/create_group_screen";
  static const String chatSettingRoute = "/chat_setting_screen";
  static const String forgotPasswordRoute = "/forgot_password_screen";
  static const String otpVerificationRoute = "/otp_verification_screen";
  static const String generatePasswordScreen = "/generate_password_screen";
  static const String addUserScreen = "/add_user_screen";
  static const String userListScreen = "/user_list_screen";
  static const String projectListScreen = "/project_list_route";
  static const String groupListScreen = "/group_list_screen";
  static const String createGroupNewScreen = "/new_create_group_screen";
  static const String personalInfoScreen = "/personal_info_screen";
  static const String dashboardScreen = "/dashboard_screen";
  static const String selectCustomUser = "/selectCustomUser";
  static const String mediaViewerScreen = '/mediaViewerScreen';
  static const String projectDetailScreen = '/projectDetailScreen';
//static const String registerRoute = "/register";
//static const String forgotPasswordRoute = "/forgotPassword";
//static const String mainRoute = "/main";
//static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.chatListRoute:
        return MaterialPageRoute(builder: (_) => ChatListScreen());
      case Routes.chatDetailsRoute:
        return MaterialPageRoute(builder: (_) => ChatDetailScreen());
      case Routes.createProjectRoute:
        return MaterialPageRoute(builder: (_) => CreateProjectScreen());
      case Routes.createGroupRoute:
        return MaterialPageRoute(builder: (_) => CreateGroupScreen());
      case Routes.chatSettingRoute:
        return MaterialPageRoute(builder: (_) => ChatSettingScreen());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.generatePasswordScreen:
        Map<String, dynamic>? arguments =
            routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (context) =>
                GeneratePasswordScreen(email: arguments?[ArgConstant.eMail]));
      case Routes.otpVerificationRoute:
        Map<String, dynamic>? arguments =
            routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(
                  email: arguments?[ArgConstant.eMail],
                  type: arguments?[ArgConstant.otpType],
                ));
      case Routes.addUserScreen:
        return MaterialPageRoute(builder: (_) => AddUserScreen());
      case Routes.userListScreen:
        return MaterialPageRoute(builder: (_) => UserListScreen());
      case Routes.projectListScreen:
        return MaterialPageRoute(builder: (_) => ProjectListScreen());
      case Routes.groupListScreen:
        Project? currentProject = routeSettings.arguments as Project?;
        return MaterialPageRoute(
            builder: (_) => GroupListScreen(
                  currentProject: currentProject,
                ));
      case Routes.createGroupNewScreen:
        Project? currentProject = routeSettings.arguments as Project?;
        return MaterialPageRoute(
            builder: (_) => CreateGroupNewScreen(
                  currentProject: currentProject,
                ));
      case Routes.personalInfoScreen:
        return MaterialPageRoute(builder: (_) => PersonalInfoScreen());
      case Routes.dashboardScreen:
        int selectedScreen = (routeSettings.arguments ?? 0) as int;
        return MaterialPageRoute(builder: (_) => MainScreen(selectedScreen: selectedScreen,));
      case Routes.selectCustomUser:
        List<ProjectMember>? selectedUser =
            routeSettings.arguments as List<ProjectMember>?;
        return MaterialPageRoute(
            builder: (_) => SelectUserScreen(selectedContact: selectedUser));
      case Routes.mediaViewerScreen:
        String url = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => MediaViewer(resource: url));
      case Routes.projectDetailScreen:
        // String? projectId = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => const ProjectDetailScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}

import 'package:biz_card/features/authModule/screens/login_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import '../../features/authModule/screens/sign_up_screen.dart';

class FluroRoute {
  static FluroRouter fluroRouter = FluroRouter();

  static var loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const LoginScreen();
  });

  static var signUpHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const SignUpScreen();
  });

  static initRoute() {
    fluroRouter.define("/",
        handler: loginHandler, transitionType: TransitionType.cupertino);
    fluroRouter.define("/signUp",
        handler: signUpHandler, transitionType: TransitionType.cupertino);
  }
}

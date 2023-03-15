import 'package:flutter/material.dart';

class CustomNavigator {
  static pushNavigate(var context, var screenName) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screenName,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  static pushNavigateSimple(var context, var screenName) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => screenName));
  }

  static pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static pushNamedNavigate(var context, var routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static pushAndRemoveAllStack(var context, var routeName) {
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>routeName), (route) => false);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return routeName;
    }), (route) => false);
  }

  static removeFromStack(var context, routeName) {
    Navigator.removeRoute(context, routeName);
  }

  static popUntil(var context, routeName) {
    Navigator.popUntil(context, routeName);
  }

  static pushReplace(var context, var routeName) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (context) => routeName));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
    //   return routeName;
    // }));
  }
}

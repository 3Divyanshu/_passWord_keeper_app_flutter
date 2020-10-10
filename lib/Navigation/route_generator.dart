import 'package:flutter/material.dart';
import 'package:pass_word/form.dart';
import 'package:pass_word/intro.dart';
import 'package:pass_word/main.dart';
import 'package:pass_word/pass_gen.dart';
import 'package:pass_word/setting.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Intro());
      case '/Homepage':
        return MaterialPageRoute(builder: (context) => Homepage());
      case '/form':
        return MaterialPageRoute(builder: (context) => PassForm(isBright: args));
      case '/passGenerator':
        return MaterialPageRoute(builder: (context) => PasswordGen(isBright: args));
      case '/setting':
        return MaterialPageRoute(builder: (context) => Setting(isBright: args));
      default:
        return _errorPage();
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(body: Center(child: Text("No Route")));
    });
  }
}

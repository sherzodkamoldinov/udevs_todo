import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/constants/route_keys.dart';
import 'package:udevs_todo/presentation/pages/on_boarding/on_boarding_page.dart';
import 'package:udevs_todo/presentation/pages/splash/splash_page.dart';
import 'package:udevs_todo/presentation/pages/tabs/tab_page.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return navigateTo(const SplashPage());

      case onBoardingPage:
        return navigateTo(const OnBoardingPage());

      case tab:
        return navigateTo(const TabPage());

      default:
        return navigateTo(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

MaterialPageRoute navigateTo(Widget widget) => MaterialPageRoute(
      builder: (context) => widget,
    );

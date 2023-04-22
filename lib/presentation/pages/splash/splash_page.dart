import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/core/assets/constants/route_keys.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/data/repositories/shared_pref.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      bool? isFirstInit = StorageRepository.getBool(key: StorageKeys.isFirstInit);
      if (isFirstInit != null) {
        Navigator.pushReplacementNamed(context, tab);
      } else {
        Navigator.pushReplacementNamed(context, onBoardingPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Lottie.asset(AppIcons.splash),
      ),
    );
  }
}

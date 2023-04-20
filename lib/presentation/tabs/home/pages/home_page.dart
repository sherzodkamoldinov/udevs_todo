import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/presentation/tabs/home/widgets/home_empty_item.dart';
import 'package:udevs_todo/presentation/tabs/home/widgets/home_with_data_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.aliceBlue,
      body: HomeWithDataItem(),
    );
  }
}

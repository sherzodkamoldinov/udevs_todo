import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';

class HomeEmptyItem extends StatelessWidget {
  const HomeEmptyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.clipBoardImg,
            height: 164,
          ),
          const SizedBox(height: 70),
          Text(
            'No tasks',
            style: RubikFont.w500.copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

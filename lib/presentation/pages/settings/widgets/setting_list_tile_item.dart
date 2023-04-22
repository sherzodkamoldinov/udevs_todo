import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';

class SettingListTileItem extends StatelessWidget {
  const SettingListTileItem({
    Key? key,
    required this.onTap,
    this.color = AppColors.cornflowerBlue,
    this.margin,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final VoidCallback onTap;
  final Color color;
  final double? margin;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin ?? 0),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: RubikFont.w400.copyWith(fontSize: 16, color: AppColors.white)),
            Icon(icon, color: AppColors.white),
          ],
        ),
      ),
    );
    ;
  }
}

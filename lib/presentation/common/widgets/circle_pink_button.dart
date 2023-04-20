import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/icons/app_icons.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';

class CirclePinkButton extends StatelessWidget {
  const CirclePinkButton({
    super.key,
    required this.onTap,
    this.iconPath,
  });

  final VoidCallback onTap;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: AppColors.pinkGradient),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.persianPink.withOpacity(0.47),
              offset: const Offset(0, 7),
              blurRadius: 9,
            )
          ],
        ),
        child: SvgPicture.asset(
          iconPath ?? AppIcons.addIcon,
          height: 25,
        ),
      ),
    );
  }
}

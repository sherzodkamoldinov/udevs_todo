import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';

class CategoryItem extends StatelessWidget {
  final CategoryHiveModel category;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      child: WScaleAnimation(
        onTap: () {},
        child: isSelected
            ? Container(
                height: 30,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 11,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyUtils.toColor(category.color),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                      color: MyUtils.toColor(category.color).withOpacity(0.33),
                    )
                  ],
                ),
                child: Text(
                  category.title,
                  style: RubikFont.w400.copyWith(
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                ),
              )
            : TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: onPressed,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.only(top: 4, right: 5),
                      decoration: BoxDecoration(
                        color: MyUtils.toColor(category.color),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      category.title,
                      style: RubikFont.w400.copyWith(
                        fontSize: 15,
                        color: AppColors.suvaGrey,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

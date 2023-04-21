import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';

class WCheckBox extends StatefulWidget {
  const WCheckBox({
    super.key,
    required this.isSelected,
    required this.onChanged,
    this.isConst = false
  });

  @override
  State<WCheckBox> createState() => _WCheckBoxState();

  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final bool isConst;
}

class _WCheckBoxState extends State<WCheckBox> {
  late bool value;

  @override
  void initState() {
    value = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isConst ? (){}:
        setState(() {
          value = !value;
          widget.onChanged.call(value);
        });
      },
      child: AnimatedContainer(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          color: value ? AppColors.conifer : AppColors.white,
          shape: BoxShape.circle,
          border: !value
              ? Border.all(
                  width: 1.5,
                  color: AppColors.silverNobel,
                )
              : null,
        ),
        duration: const Duration(milliseconds: 50),
        child: const Center(
          child: Icon(
            Icons.check,
            color: AppColors.white,
            size: 15,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';

class WTextField extends StatefulWidget {
  const WTextField({super.key, required this.controller});

  @override
  State<WTextField> createState() => _WTextFieldState();
  final TextEditingController controller;
}

class _WTextFieldState extends State<WTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21.5),
      child: TextField(
        controller: widget.controller,
        cursorColor: AppColors.eclipse,
        cursorWidth: 2,
        cursorHeight: 32,
        focusNode: focusNode,
        style: RubikFont.w400.copyWith(
          color: AppColors.eclipse,
        ),
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.veryLightGrey,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.veryLightGrey,
            ),
          ),
        ),
      ),
    );
  }
}

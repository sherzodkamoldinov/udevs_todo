import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:udevs_todo/bloc/category_bloc/category_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/core/assets/constants/route_keys.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/data/repositories/shared_pref.dart';
import 'package:udevs_todo/presentation/common/widgets/w_button.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  Image.asset(AppIcons.onBoardingImg, height: 195),
                  const SizedBox(height: 113),

                  Text(
                    "Reminders made simple",
                    style: RubikFont.w500.copyWith(fontSize: 22),
                  ),

                  const Spacer(),

                  // start app
                  WButton(
                    onTap: () async {
                      await StorageRepository.putBool(key: StorageKeys.isFirstInit, value: true);
                      BlocProvider.of<CategoryBloc>(context).add(CategoryFirstInit());
                      Navigator.pushReplacementNamed(context, tab);
                    },
                    isLoading: state.categoryStatus.isSubmissionInProgress,
                    height: 56,
                    width: 258,
                    borderRadius: 10,
                    gradientColors: AppColors.greenGradient,
                    shadow: [
                      BoxShadow(
                        blurRadius: 30,
                        color: AppColors.kellyGreen.withOpacity(0.53),
                        offset: const Offset(0, 5),
                      ),
                    ],
                    text: 'Get Started',
                    textStyle: RubikFont.w400.copyWith(
                      fontSize: 15,
                      color: AppColors.alabasterWhite,
                    ),
                  ),
                  const SizedBox(height: 92),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

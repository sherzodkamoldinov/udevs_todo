import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_todo/bloc/setting_bloc/setting_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/route_keys.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
      flexibleSpace: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: 108,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.appBarGradient),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _circleDecorationItem(
                  size: 210,
                  left: -80,
                  top: -105,
                ),
                _circleDecorationItem(
                  size: 90,
                  left: 300,
                  top: -18,
                ),
                Positioned(
                  left: 20,
                  right: 10,
                  bottom: 12,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${state.user.name} 👋",
                            style: RubikFont.w400.copyWith(
                              fontSize: 18,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            BlocProvider.of<TodoBloc>(context, listen: true).getTodosCountByNotDone() == 0
                                ? "Don't have tasks yet 🤨"
                                : "Today you have ${BlocProvider.of<TodoBloc>(context, listen: true).getTodosCountByNotDone()} 🗒 tasks",
                            overflow: TextOverflow.ellipsis,
                            style: RubikFont.w400.copyWith(
                              fontSize: 18,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      
                      // user img and setting button
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.white,
                            child: state.user.imgPath.isNotEmpty
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                          File(state.user.imgPath),
                                          width: MediaQuery.of(context).size.height * 0.2,
                                          height: MediaQuery.of(context).size.height * 0.2,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Center(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.black,
                                              ),
                                            );
                                          },
                                        ),
                                    )
                                    : const Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                                      ),
                          ),
                          const SizedBox(width: 7),
                          WScaleAnimation(
                            onTap: (){
                              Navigator.pushNamed(context, settingPage);
                            },
                            child: const Icon(Icons.more_vert_outlined, color: AppColors.white, size: 28))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 70);

  @override
  Widget get child => throw UnimplementedError();

  Widget _circleDecorationItem({
    required double size,
    double? left,
    double? right,
    double? bottom,
    double? top,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white.withOpacity(0.20),
        ),
      ),
    );
  }
}

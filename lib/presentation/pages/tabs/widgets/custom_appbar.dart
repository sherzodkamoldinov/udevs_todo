import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_todo/bloc/setting_bloc/setting_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          flexibleSpace: Container(
            width: double.infinity,
            height: 108,
            decoration:  const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.appBarGradient),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _circleItem(
                  size: 211,
                  left: -80,
                  top: -105,
                ),
                _circleItem(
                  size: 93,
                  left: 299,
                  top: -18,
                ),
                Positioned(
                  left: 19,
                  right: 19,
                  bottom: 11,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${BlocProvider.of<SettingBloc>(context).state.user.name} 👋",
                            style: RubikFont.w400.copyWith(
                              fontSize: 18,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            BlocProvider.of<TodoBloc>(context,listen: true ).state.todos.isEmpty
                            ? "Don't have tasks yet 🤨"
                            : "Today you have ${BlocProvider.of<TodoBloc>(context, listen: true).getTasksCountByNotDone()} 🗒 tasks",
                            overflow: TextOverflow.ellipsis,
                            style: RubikFont.w400.copyWith(
                              fontSize: 18,
                              color: AppColors.white,
                              
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.white,
                        child: Icon(CupertinoIcons.person),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 69);

  @override
  Widget get child => throw UnimplementedError();

  Widget _circleItem({
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
          color: AppColors.white.withOpacity(0.17),
        ),
      ),
    );
  }
}

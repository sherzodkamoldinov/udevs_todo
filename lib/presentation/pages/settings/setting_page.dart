import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udevs_todo/bloc/setting_bloc/setting_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/repositories/category_repository.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';
import 'package:udevs_todo/presentation/common/widgets/w_text_field.dart';
import 'package:udevs_todo/presentation/pages/settings/add_category.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late TextEditingController con;

  @override
  void initState() {
    con = TextEditingController(text: BlocProvider.of<SettingBloc>(context).state.user.name);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.aliceBlue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.aliceBlue,
        title: Text(
          'Profile Setting',
          style: RubikFont.w400.copyWith(fontSize: 22, color: AppColors.black.withOpacity(0.7)),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                // user image
                WScaleAnimation(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image.
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
                    if (image != null) {
                      BlocProvider.of<SettingBloc>(context).add(UpdateImagePathEvent(imgPath: image.path));
                    }
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(color: AppColors.cornflowerBlue),
                          child: state.status.isSubmissionInProgress
                              ? const Center(child: CircularProgressIndicator())
                              : state.user.imgPath.isNotEmpty
                                  ? Image.file(
                                      File(state.user.imgPath),
                                      width: MediaQuery.of(context).size.height * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    ),
                        ),
                      ),
                      const Positioned(
                        bottom: -2,
                        right: -2,
                        child: Icon(
                          Icons.add,
                          size: 44,
                          color: AppColors.darkGray,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // task info
                Row(
                  children: [
                    _taskInfoItem('All Tasks : ${BlocProvider.of<TodoBloc>(context, listen: true).state.todos.length}', true),
                    _taskInfoItem('Done Tasks : ${BlocProvider.of<TodoBloc>(context, listen: true).getTodosCountByDone()}', false),
                  ],
                ),
                const SizedBox(height: 30),

                // user name with edit button
                _settingListTileItems(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.white,
                          title: Text(
                            'Edit Name',
                            style: RubikFont.w400.copyWith(fontSize: 16, color: AppColors.black),
                          ),
                          content: TextField(controller: con),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<SettingBloc>(context).add(UpdateNameEvent(name: con.text));
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'))
                          ],
                        );
                      },
                    );
                  },
                  text: state.user.name,
                  icon: Icons.edit,
                ),

                const SizedBox(height: 23),

                // add category
                _settingListTileItems(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) => const AddCategory());
                      },
                    );
                  },
                  text: 'Add Category',
                  icon: Icons.add,
                  margin: 10,
                ),

                const SizedBox(height: 23),
                _settingListTileItems(
                  onTap: () {
                    BlocProvider.of<TodoBloc>(context).add(DeleteAllTodosEvent());
                  },
                  text: 'Delete All Todos',
                  icon: Icons.delete,
                  margin: 20,
                  color: Colors.redAccent,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _taskInfoItem(String text, bool isLeft) => Expanded(
        child: Container(
          height: 50,
          margin: isLeft ? const EdgeInsets.only(right: 15) : const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.cornflowerBlue),
          child: Center(
            child: Text(
              text,
              style: RubikFont.w400.copyWith(fontSize: 16, color: AppColors.white),
            ),
          ),
        ),
      );

  Widget _settingListTileItems({
    required VoidCallback onTap,
    Color color = AppColors.cornflowerBlue,
    double? margin,
    required String text,
    required IconData icon,
  }) =>
      WScaleAnimation(
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
}

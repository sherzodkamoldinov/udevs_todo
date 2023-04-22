import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udevs_todo/bloc/setting_bloc/setting_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';
import 'package:udevs_todo/presentation/pages/settings/add_category.dart';
import 'package:udevs_todo/presentation/pages/settings/widgets/edit_name_alert_dialog.dart';
import 'package:udevs_todo/presentation/pages/settings/widgets/setting_list_tile_item.dart';
import 'package:udevs_todo/presentation/pages/settings/widgets/task_info_item.dart';



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
                      // ignore: use_build_context_synchronously
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
                    TaskInfoItem(text: 'All Tasks : ${BlocProvider.of<TodoBloc>(context, listen: true).state.todos.length}', isLeft: true),
                    TaskInfoItem(text: 'Done Tasks : ${BlocProvider.of<TodoBloc>(context, listen: true).getTodosCountByDone()}', isLeft: false),
                  ],
                ),
                const SizedBox(height: 30),

                // user name with edit button
                SettingListTileItem(
                  onTap: () {
                    editNameDialog(context, con);
                  },
                  text: state.user.name,
                  icon: Icons.edit,
                ),

                const SizedBox(height: 23),

                // add category
                SettingListTileItem(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) => const AddCategory());
                      },
                    );
                  },
                  text: 'Add Category',
                  icon: Icons.add,
                  margin: 10,
                ),

                const SizedBox(height: 23),

                // delete todo
                SettingListTileItem(
                  onTap: () {
                    if (BlocProvider.of<TodoBloc>(context).state.todos.isNotEmpty) {
                      BlocProvider.of<TodoBloc>(context).add(DeleteAllTodosEvent());
                    } else {
                      MyUtils.getMyToast(message: 'You Don\'t have tasks yet');
                    }
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
}

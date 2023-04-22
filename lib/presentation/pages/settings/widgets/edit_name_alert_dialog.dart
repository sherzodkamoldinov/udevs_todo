import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_todo/bloc/setting_bloc/setting_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';

void editNameDialog(BuildContext context, TextEditingController con) => showDialog(
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
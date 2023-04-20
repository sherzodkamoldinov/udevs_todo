import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/presentation/common/widgets/circle_pink_button.dart';
import 'package:udevs_todo/presentation/tabs/widgets/add_todo_item.dart';
import 'package:udevs_todo/presentation/tabs/widgets/custom_appbar.dart';
import 'package:udevs_todo/presentation/tabs/home/pages/home_page.dart';
import 'package:udevs_todo/presentation/tabs/tasks/pages/task_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final List<Widget> _screens = [
    const HomePage(),
    const TasksPage(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CirclePinkButton(
        onTap: () {
          // HERE ADD TODOS
          showModalBottomSheet(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddTodoItem(),
          );
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SizedBox(
        height: 76,
        child: BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.darkGray,
          backgroundColor: AppColors.white,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            _bottomNavItem(
              isSelected: _currentIndex == 0,
              label: 'Home',
              iconPath: AppIcons.homeIcon,
            ),
            _bottomNavItem(
              isSelected: _currentIndex == 1,
              label: 'Task',
              iconPath: AppIcons.gridIcon,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavItem({
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        height: 24,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primaryColor : AppColors.silver,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}

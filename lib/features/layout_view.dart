import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/settings/settings_view.dart';
import 'package:todo_app/features/tasks/task_view.dart';
import 'package:todo_app/features/tasks/widget/add_task_bottom_sheet_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../core/settings_provider.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;
  List<Widget> screensList = [const TaskView(), const SettingsView()];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var localization = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => const AddTaskBottomSheetWidget());
        },
        elevation: 2,
        backgroundColor:
            provider.isDark() ? const Color(0xff141922) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        child: CircleAvatar(
          radius: 28,
          backgroundColor:
              provider.isDark() ? const Color(0xff141922) : theme.primaryColor,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: screensList[currentIndex],
      bottomNavigationBar: BottomAppBar(
        // height: 90,
        color: provider.isDark() ? const Color(0xff141922) : Colors.white,
        padding: EdgeInsets.zero,
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/tasks_icn.png"),
              ),
              label: localization.task,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/settings_icn.png"),
              ),
              label: localization.settings,
            ),
          ],
        ),
      ),
    );
  }
}

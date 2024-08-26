import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/settings_provider.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItemWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var localization = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: provider.isDark() ? const Color(0xff141922) : Colors.white,
        // color:Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils.deleteTask(taskModel)
                    .then((value) => EasyLoading.dismiss());
              },
              padding: EdgeInsets.zero,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: localization.delete,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: provider.isDark() ? const Color(0xff141922) : Colors.white,
            // color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Container(
              width: 6,
              height: 140,
              decoration: BoxDecoration(
                color: taskModel.isDone
                    ? const Color(0xFF61E757)
                    : theme.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: taskModel.isDone
                        ? const Color(0xFF61E757)
                        : theme.primaryColor,
                  ),
                ),
                Text(
                  taskModel.description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    color: provider.isDark() ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.alarm, size: 16,
                      color: provider.isDark() ? Colors.white : Colors.black,
                      // color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat("dd MMM yyyy").format(taskModel.selectedDate),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: provider.isDark() ? Colors.white : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
            trailing: taskModel.isDone
                ? Text(
                    localization.done,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF61E757),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      EasyLoading.show();
                      FirebaseUtils.updateTask(taskModel)
                          .then((value) => EasyLoading.dismiss());
                    },
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(Icons.check,
                          size: 25, color: Colors.white),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

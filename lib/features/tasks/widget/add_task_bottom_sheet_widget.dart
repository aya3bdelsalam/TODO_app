import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/settings_provider.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  const AddTaskBottomSheetWidget({super.key});

  @override
  State<AddTaskBottomSheetWidget> createState() =>
      _AddTaskBottomSheetWidgetState();
}

class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
      decoration: BoxDecoration(
        color: provider.isDark() ? const Color(0xff141922) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(localization.add_new_task,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: provider.isDark() ? Colors.white : Colors.black,
                )),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
              controller: titleController,
              decoration: InputDecoration(
                  hintText: localization.enter_task_title,
                  hintStyle: TextStyle(
                    color: provider.isDark() ? Colors.grey : Colors.black,
                  ),
                  errorStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                    fontSize: 16,
                  )),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return (localization.please_enter_your_task_title);
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: localization.enter_task_details,
                  hintStyle: TextStyle(
                    color: provider.isDark() ? Colors.grey : Colors.black,
                  ),
                  errorStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                    fontSize: 16,
                  )),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return (localization.please_enter_your_task_details);
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(localization.select_time,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: provider.isDark() ? Colors.grey : Colors.black,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                getSelectedDate();
              },
              child: Text(DateFormat("dd-MMM-yyyy").format(selectedDate),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: provider.isDark() ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            const Spacer(),
            FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var taskModel = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      selectedDate: selectedDate,
                    );
                    print(taskModel.toFirestore());
                    EasyLoading.show();
                    FirebaseUtils.addTaskToFirestore(taskModel).then((value) {
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      SnackBarService.showSuccessMessage(
                          "Task Successfully Added");
                    });
                  }
                },
                style: FilledButton.styleFrom(
                    backgroundColor: provider.isDark()
                        ? theme.primaryColorLight
                        : theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                child: Text(
                  localization.save,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  getSelectedDate() async {
    var currentDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (currentDate != null) {
      setState(() {
        selectedDate = currentDate;
      });
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/features/tasks/widget/task_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/settings_provider.dart';
import '../../model/task_model.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 15,
                  right: 15,
                ),
                height: mediaQuery.size.height * 0.18,
                width: mediaQuery.size.width,
                // color:theme.primaryColor,
                color: provider.isDark()
                    ? theme.primaryColorLight
                    : theme.primaryColor,
                child: Text(localization.to_do_list,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: provider.isDark()
                          ? const Color(0xff141922)
                          : Colors.white,
                      // color:Colors.white,
                    )),
              ),
              Positioned(
                top: 100,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(
                    controller: _controller,
                    firstDate: DateTime(2024),
                    focusDate: _focusDate,
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    onDateChange: (selectedDate) {
                      setState(() {
                        _focusDate = selectedDate;
                        // print(_focusDate);
                      });
                    },
                    showTimelineHeader: false,
                    timeLineProps: const EasyTimeLineProps(
                      separatorPadding: 10,
                    ),
                    dayProps: EasyDayProps(
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: provider.isDark()
                              ? const Color(0xff141922)
                              : Colors.white,
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: provider.isDark()
                              ? theme.primaryColorLight
                              : theme.primaryColor,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: provider.isDark()
                              ? theme.primaryColorLight
                              : theme.primaryColor,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: provider.isDark()
                              ? theme.primaryColorLight
                              : theme.primaryColor,
                        ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: provider.isDark()
                              ? const Color(0xff141922).withOpacity(0.70)
                              : Colors.white.withOpacity(0.80),
                          // color: Colors.white.withOpacity(0.80),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          // color: Colors.black,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          // color: Colors.black,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          // color: Colors.black,
                        ),
                      ),
                      todayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: provider.isDark()
                              ? const Color(0xff141922).withOpacity(0.70)
                              : Colors.white.withOpacity(0.80),
                          // color: Colors.white.withOpacity(0.80),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          // color: Colors.black,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          // color:Colors.black,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          // color:Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FirebaseUtils.getRealTimeDateFromFirestore(_focusDate),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                    ),
                  );
                }

                List<TaskModel> tasksList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) => TaskItemWidget(
                    taskModel: tasksList[index],
                  ),
                  itemCount: tasksList.length ?? 0,
                );
              }),
        ),
        // Expanded(
        //   child: FutureBuilder<List<TaskModel>>(
        //       future:FirebaseUtils.getOnTimeReadFromFirestore(_focusDate),
        //       builder:
        //   (context,snapshot){
        //         if(snapshot.hasError){
        //           return Text(
        //             snapshot.error.toString(),
        //           );
        //         }
        //         if(snapshot.connectionState ==ConnectionState.waiting){
        //           return Center(
        //             child: CircularProgressIndicator(
        //               color: theme.primaryColor,
        //             ),
        //           );
        //         }
        //
        //         List<TaskModel> tasksList=snapshot.data ?? [];
        //         return  ListView.builder(
        //           itemBuilder: (context,index)=> TaskItemWidget(taskModel:tasksList[index],),
        //           itemCount: tasksList.length ?? 0,
        //         );
        //   }
        //   ),
        // ),
      ],
    );
  }
}

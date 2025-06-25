import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/widgets/add_new_task.dart';
import 'package:task_app/widgets/task.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Task> tasks = [];
  Future<void> loadTasks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringTasks = pref.getString('tasks');
    if (stringTasks != null) {
      List decode = jsonDecode(stringTasks);
      tasks = decode.map((e) => Task.fromJson(e)).toList();
      setState(() {});
    }
  }

  Future<void> saveTasks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List encdoe = tasks.map((e) => e.toJson()).toList();
    String? myTasks = jsonEncode(encdoe);
    pref.setString("tasks", myTasks);
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffed7899),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddNewTask(tasks: tasks,saveData: saveTasks,),
            ))
                .then((_) {
              setState(() {});
            });
          }),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: height * 0.25,
            backgroundColor: const Color(0xffed7899),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "My Todo List",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              background: Center(
                child: Image.asset("images/icons8-todoist-64.png"),
              ),
            ),
          ),
          tasks.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                      height: height,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.2,
                          ),
                          Image.asset(
                            "images/notasks.jfif",
                            width: height * 0.25,
                            height: height * 0.25,
                          )
                        ],
                      )))
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                  childCount: tasks.length,
                  (context, index) => Card(
                    key: ValueKey(tasks[index].id),
                    color: const Color(0xffeeeeee),
                    child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color(0xffed7899),
                            child: Icon(
                              tasks[index].icon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          tasks[index].subtitle,
                        ),
                        title: Text(tasks[index].title,
                            style: TextStyle(
                                decoration: tasks[index].isFinished
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none)),
                        trailing: SizedBox(
                          width: width * 0.27,
                          child: Row(
                            children: [
                              Checkbox(
                                  activeColor: const Color(0xffed7899),
                                  value: tasks[index].isFinished,
                                  onChanged: (val) {
                                    tasks[index].isFinished = val!;
                                    setState(() {});
                                  }),
                              IconButton(
                                  onPressed: () {
                                    // To Delete Task From List
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.rightSlide,
                                      title: 'Warning',
                                      desc: 'Are You Sure ?',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        tasks.removeWhere(
                                            (t) => t.id == tasks[index].id);
                                        saveTasks();
                                        setState(() {});
                                      },
                                    ).show();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        )),
                  ),
                ))
        ],
      ),
    );
  }
}

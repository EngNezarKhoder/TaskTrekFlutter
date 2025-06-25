import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:task_app/widgets/task.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key, required this.tasks, required this.saveData});
  final List<Task> tasks;
  final Future<void> Function() saveData;
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  IconData? icon;
  List categories = [
    {"icon": Icons.person, "iconcolor": Colors.white, "choose": false},
    {"icon": Icons.date_range, "iconcolor": Colors.white, "choose": false},
    {"icon": Icons.home, "iconcolor": Colors.white, "choose": false},
    {
      "icon": Icons.access_alarms_rounded,
      "iconcolor": Colors.white,
      "choose": false
    },
    {
      "icon": Icons.airplanemode_off_outlined,
      "iconcolor": Colors.white,
      "choose": false
    },
  ];
  late GlobalKey<FormState> formstate;
  late TextEditingController titlecontroller;
  late TextEditingController notecontroller;
  @override
  void initState() {
    formstate = GlobalKey();
    titlecontroller = TextEditingController();
    notecontroller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              )),
          title: const Text(
            "Add New Task",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xffed7899),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Task Title",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "The Field Is Empty";
                      }
                      return null;
                    },
                    controller: titlecontroller,
                    cursorColor: const Color(0xffed7899),
                    decoration: const InputDecoration(
                        hintText: "Task Title",
                        hintStyle: TextStyle(
                          color: Color(0xffed7899),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffed7899))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffed7899))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffed7899))),
                        fillColor: Color(0xffeeeeee),
                        filled: true),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    height: height * 0.07,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: const Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        ...List.generate(categories.length, (index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  for (int i = 0; i < categories.length; i++) {
                                    categories[i]['choose'] = false;
                                  }
                                  categories[index]['choose'] = true;
                                  icon = categories[index]['icon'];
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(1),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xffed7899),
                                    border: categories[index]['choose']
                                        ? Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 151, 110, 110))
                                        : null,
                                    shape: BoxShape.circle),
                                child: ClipRRect(
                                  child: Icon(
                                    categories[index]['icon'],
                                    color: Colors.white,
                                  ),
                                ),
                              ));
                        })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const Text(
                    "Notes",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  TextFormField(
                    minLines: 4,
                    maxLines: 6,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "The Field Is Empty";
                      }
                      return null;
                    },
                    controller: notecontroller,
                    cursorColor: const Color(0xffed7899),
                    decoration: const InputDecoration(
                        hintText: "Notes",
                        hintStyle: TextStyle(
                          color: Color(0xffed7899),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffed7899))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffed7899))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffed7899))),
                        fillColor: Color(0xffeeeeee),
                        filled: true),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Center(
                    child: SizedBox(
                      width: width * 0.7,
                      height: height * 0.065,
                      child: MaterialButton(
                        onPressed: () {
                          if (formstate.currentState!.validate()) {
                            if (icon == null) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Warning',
                                desc: 'Please Choose Category',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                            } else {
                              widget.tasks.add(Task(
                                  id: widget.tasks.length,
                                  subtitle: notecontroller.text,
                                  title: titlecontroller.text,
                                  icon: icon!));
                              widget.saveData();
                              FocusScope.of(context).unfocus();
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: const Color(0xffed7899),
                        textColor: Colors.white,
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

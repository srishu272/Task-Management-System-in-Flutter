import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../model/task.dart';
import '../provider/taskProvider.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  final Task task;

  @override
  State<EditTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  

  DateTime? dueDate;

  void _selectDueDate() async {
    // Show the date picker and wait for the selected date
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dueDate = picked;
        dueDateController.text = DateFormat('yyyy-MM-dd').format(dueDate!); // Update the text field
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    dueDateController.text = DateFormat('yyyy-MM-DD').format(widget.task.dueDate);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blueGrey,
              )),
          title: Text(
            'Edit Task',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white54,
          elevation: 1,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/premium_photo-1667143327618-bf16fc8777ba.jpeg',
                  ),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle:
                      TextStyle(color: Colors.black87, fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black87)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.black87, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.black87, width: 2)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Enter valid title";

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle:
                      TextStyle(color: Colors.black87, fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black87)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.black87, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.black87, width: 2)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Enter valid description";

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: _selectDueDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dueDateController,
                        decoration: InputDecoration(
                          labelText: 'Due Date (YYYY-MM-DD)',
                          labelStyle:
                          TextStyle(color: Colors.black87, fontSize: 18),
                          hintText: dueDate == null
                              ? 'Select a date'
                              : DateFormat('yyyy-MM-dd').format(dueDate!),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black87)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: Colors.black87, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: Colors.black87, width: 2)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final task = Task(
                          title: titleController.text,
                          description: descriptionController.text,
                          dueDate: DateTime.parse(dueDateController.text),
                        );
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(task);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Edit Task",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

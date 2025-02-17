import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/provider/taskProvider.dart';
import 'package:task_management_app/screens/add_task_screen.dart';
import 'package:task_management_app/screens/edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tasks',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white54,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTaskScreen()));
                },
                icon: Icon(Icons.add, color: Colors.blueGrey,size: 30,))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/premium_photo-1667143327618-bf16fc8777ba.jpeg',
                  ),
                  fit: BoxFit.fill)),
          child: FutureBuilder(
              future: taskProvider.fetchTasks(),
              builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskProvider.tasks[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditTaskScreen(task: task)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: ListTile(
                                title: Text(task.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                subtitle: Text(task.description,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,overflow: TextOverflow.fade),),
                                leading: Checkbox(
                                  activeColor: Colors.white.withOpacity(0.6),
                                    checkColor: Colors.blueGrey,
                                    value: task.isCompleted,
                                    onChanged: (value) {
                                      task.isCompleted = value!;
                                      taskProvider.updateTask(task);
                                    }),
                                trailing: IconButton(
                                    onPressed: () {
                                      taskProvider.deleteTask(task.id!);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.withOpacity(0.6),
                                    )),
                              ),
                            ),
                          ),
                        );
                      });
              }),
        ),
      ),
    );
  }
}
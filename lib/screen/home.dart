import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misha_assigment/controller/controller.dart';
import 'package:misha_assigment/screen/task_add.dart';


class HomePage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo App')),
      body: Obx(() => ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              var task = taskController.tasks[index];

              return Dismissible(
                key: Key(task.title),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  taskController.deleteTask(index);
                  Get.snackbar("Task Deleted", "${task.title} has been removed.");
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  child: ExpansionTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) => taskController.toggleTaskCompletion(index),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text('Description: ${task.description}'),
                        subtitle: Text('Created at: ${task.time}'),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => TaskAddScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

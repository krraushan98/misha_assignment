import 'package:get/get.dart';
import 'package:misha_assigment/Model/list_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TaskController extends GetxController {
  var tasks = <Task>[].obs;  

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = tasks.map((task) => task.toStorageString()).toList();
    await prefs.setStringList("todoData", taskStrings);
  }

  
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskStrings = prefs.getStringList("todoData");

    if (taskStrings != null) {
      tasks.assignAll(taskStrings.map((task) => Task.fromStorageString(task)).toList());
    }
  }

  
  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
  }

  
  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
    saveTasks();
  }

  
  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasks();
  }
}

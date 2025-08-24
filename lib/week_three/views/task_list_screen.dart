import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_provider.dart';
import '../models/task_model.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 243, 239, 58),
              const Color.fromARGB(255, 234, 231, 208),
              const Color.fromARGB(255, 243, 239, 58),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "My Tasks",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 131, 54, 5),
          
                ),
              ),
            ),
            Expanded(
  child: taskProvider.tasks.isEmpty
     ? Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.task_alt, size: 60, color: Color.fromARGB(255, 131, 54, 5),),
      SizedBox(height: 16),
      Text(
        "No tasks available.\nTap + to add your first task!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
    ],
  )
      : AnimatedList(
          key: _listKey,
          initialItemCount: taskProvider.tasks.length,
          itemBuilder: (context, index, animation) {
            final task = taskProvider.tasks[index];
            return _buildTaskCard(task, index, animation);
          },
        ),
),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color.fromARGB(255, 131, 54, 5),),
        onPressed: () async {
          final newTaskTitle = await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AddTaskScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
          if (newTaskTitle != null && newTaskTitle.toString().isNotEmpty) {
            taskProvider.addTask(newTaskTitle);
            _listKey.currentState!.insertItem(0);
          }
        },
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task, int index, Animation<double> animation) {
  final taskProvider = Provider.of<TaskProvider>(context, listen: false);

  return SizeTransition(
    sizeFactor: animation,
    child: GestureDetector(
      onTap: () => taskProvider.toggleTask(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: task.isDone ? Colors.green.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: 18,
                  decoration: task.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                taskProvider.removeTask(index);
                _listKey.currentState!.removeItem(
                  index,
                  (context, animation) => SizeTransition(
                    sizeFactor: animation,
                    child: Container(), // fade out animation
                  ),
                  duration: const Duration(milliseconds: 300),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
  }
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
         gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 243, 239, 58),
              const Color.fromARGB(255, 234, 231, 208),
              const Color.fromARGB(255, 243, 239, 58),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 131, 54, 5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Color.fromARGB(255, 17, 13, 9),fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0),
                  decoration: InputDecoration(
                    hintText: "Enter task...",
                    hintStyle: const TextStyle(color: Color.fromARGB(217, 142, 135, 135)),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 196, 192, 192).withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    
                    ),
                  ),
                ),
              ),
              FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
                label: const Text(
                  "Add Task",
                  style: TextStyle(color: Color.fromARGB(255, 131, 54, 5),),
                ),
                icon: const Icon(Icons.check, color: Color.fromARGB(255, 131, 54, 5),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
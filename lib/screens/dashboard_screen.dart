import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/task_viewmodel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: vm.tasks.isEmpty
          ? const Center(child: Text("Belum ada task 📭"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.tasks.length,
              itemBuilder: (context, index) {
                final task = vm.tasks[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.task_alt,
                        color: Color(0xFF29B6F6)),
                    title: Text(task.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(task.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => vm.deleteTask(task.id!),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/form');
          Provider.of<TaskViewModel>(context, listen: false).loadTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

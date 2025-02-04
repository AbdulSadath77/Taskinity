// import 'package:taskinity/auth/auth_service.dart';
import 'package:taskinity/components/my_textfield.dart';
import 'package:taskinity/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // text controller
  final TextEditingController _taskController = TextEditingController();

  // firestore service
  final FirestoreService _firestoreService = FirestoreService();
  // final AuthService _authService = AuthService();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // add task
  void addTask() async {
    if (_taskController.text.isNotEmpty) {
      // add task to firestore
      await _firestoreService.addNote(_taskController.text);

      // clear text controller
      _taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Task List'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(children: [
        Expanded(
          child: _buildTaskList(),
        ),

        // user input
        _buildUserInput(),
      ]),
    );
  }

  // build task list
  Widget _buildTaskList() {
    return StreamBuilder(
      stream: _firestoreService.getNotesStream(),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }

        // loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // return task list view
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildTaskItem(doc)).toList(),
        );
      },
    );
  }

  // build task item
  Widget _buildTaskItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ListTile(
      title: Text(data['note']),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _firestoreService.deleteNote(doc.id),
      ),
    );
  }

  // build user input
  Widget _buildUserInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // textfield should take up most of the space
            Expanded(
              child: MyTextField(
                controller: _taskController,
                hintText: 'Add a task',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
            ),

            // add button
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightGreen,
                  width: 2,
                ),
                color: Colors.lightGreen,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: addTask,
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:taskinity/auth/auth_service.dart';
// import 'package:taskinity/components/my_drawer.dart';
// import 'package:taskinity/components/user_tile.dart';
// import 'package:taskinity/pages/chat_page.dart';
// import 'package:taskinity/services/chat/chat_service.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   // chat & auth service
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Home'),
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey,
//         elevation: 0,
//       ),
//       body: _buildUserList(),
//       drawer: const MyDrawer(),
//     );
//   }

//   // build a list of user except for the current logged in user
//   Widget _buildUserList() {
//     return StreamBuilder(
//       stream: _chatService.getUserStream(),
//       builder: (context, snapshot) {
//         // error
//         if (snapshot.hasError) {
//           return const Center(child: Text('Something went wrong!'));
//         }

//         // loading...
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // return const Center(child: CircularProgressIndicator());
//           return const Center(child: Text('Loading...'));
//         }

//         // return list view of users
//         return ListView(
//           children: snapshot.data!
//               .map<Widget>((userData) => _buildUserListItem(userData, context))
//               .toList(),
//         );
//       },
//     );
//   }

//   // build a individual list tile for user
//   Widget _buildUserListItem(
//       Map<String, dynamic> userData, BuildContext context) {
//     // display all users except current user
//     if (userData['email'] != _authService.getCurrentUser()!.email) {
//       return UserTile(
//           text: userData['email'],
//           onTap: () {
//             // tapped on user -> goto chat page
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ChatPage(
//                   receiverEmail: userData["email"],
//                   receiverID: userData["uid"],
//                 ),
//               ),
//             );
//           });
//     } else {
//       return Container();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// import 'package:taskinity/components/my_drawer.dart';
// // import 'package:taskinity/theme/theme_provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Taskinity'),
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey,
//         elevation: 0,
//       ),
//       drawer: const MyDrawer(),
//       body: Center(
//         child: Text('No Tasks!'),
//       ),
//     );
//   }
// }
// ================================================================
// ================================================================
// import 'package:flutter/material.dart';
// import 'package:taskinity/components/my_drawer.dart';
// import 'package:taskinity/services/task/task_service.dart';
// import 'package:taskinity/components/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // text controller
//   final TextEditingController _taskController = TextEditingController();

//   // task service
//   final TaskService _taskService = TaskService();

//   @override
//   void dispose() {
//     _taskController.dispose();
//     super.dispose();
//   }

//   // add task
//   void addTask() async {
//     if (_taskController.text.isNotEmpty) {
//       // add task to firestore
//       await _taskService.addTask(_taskController.text);

//       // clear text controller
//       _taskController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Home'),
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildTaskList(),
//           ),
//           _buildUserInput(),
//         ],
//       ),
//       drawer: const MyDrawer(),
//     );
//   }

//   // build task list
//   Widget _buildTaskList() {
//     return StreamBuilder(
//       stream: _taskService.getTasksStream(),
//       builder: (context, snapshot) {
//         // errors
//         if (snapshot.hasError) {
//           return const Center(child: Text('Something went wrong!'));
//         }

//         // loading...
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // return task list view
//         return ListView(
//           children:
//               snapshot.data!.docs.map((doc) => _buildTaskItem(doc)).toList(),
//         );
//       },
//     );
//   }

//   // build task item
//   Widget _buildTaskItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     return ListTile(
//       title: Text(data['task']),
//       trailing: IconButton(
//         icon: const Icon(Icons.delete),
//         onPressed: () => _taskService.deleteTask(doc.id),
//       ),
//     );
//   }

//   // build user input
//   Widget _buildUserInput() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // textfield should take up most of the space
//             Expanded(
//               child: MyTextField(
//                 controller: _taskController,
//                 hintText: 'Add a task',
//                 obscureText: false,
//                 keyboardType: TextInputType.text,
//               ),
//             ),

//             // add button
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.lightGreen,
//                   width: 2,
//                 ),
//                 color: Colors.lightGreen,
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 onPressed: addTask,
//                 icon: const Icon(Icons.add, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ================================================================
// ================================================================

// import 'package:flutter/material.dart';
// import 'package:taskinity/components/my_drawer.dart';
// import 'package:taskinity/services/task/task_service.dart';
// import 'package:taskinity/components/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // text controller
//   final TextEditingController _taskController = TextEditingController();

//   // services
//   final TaskService _taskService = TaskService();

//   @override
//   void dispose() {
//     _taskController.dispose();
//     super.dispose();
//   }

//   // add task
//   void addTask() async {
//     if (_taskController.text.isNotEmpty) {
//       await _taskService.addTask(_taskController.text);
//       _taskController.clear();
//     }
//   }

//   // update task
//   void updateTask(String taskId, String newTask) async {
//     await _taskService.updateTask(taskId, newTask);
//   }

//   // delete task
//   void deleteTask(String taskId) async {
//     await _taskService.deleteTask(taskId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Taskinity'),
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey,
//         elevation: 0,
//       ),
//       drawer: const MyDrawer(),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildTaskList(),
//           ),
//           _buildUserInput(),
//         ],
//       ),
//     );
//   }

//   // build task list
//   Widget _buildTaskList() {
//     return StreamBuilder(
//       stream: _taskService.getTasksStream(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           print('Error: ${snapshot.error}');
//           return const Center(child: Text('Something went wrong!'));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return ListView(
//           children:
//               snapshot.data!.docs.map((doc) => _buildTaskItem(doc)).toList(),
//         );
//       },
//     );
//   }

//   // build task item
//   Widget _buildTaskItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return ListTile(
//       title: Text(data['task']),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               // Update task logic here
//               updateTask(doc.id, 'Updated Task');
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () => deleteTask(doc.id),
//           ),
//         ],
//       ),
//     );
//   }

//   // build user input
//   Widget _buildUserInput() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: MyTextField(
//                 controller: _taskController,
//                 hintText: 'Add a task',
//                 obscureText: false,
//                 keyboardType: TextInputType.text,
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.lightGreen,
//                   width: 2,
//                 ),
//                 color: Colors.lightGreen,
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 onPressed: addTask,
//                 icon: const Icon(Icons.add, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ================================================================
// ================================================================

// import 'package:flutter/material.dart';
// import 'package:taskinity/components/my_drawer.dart';
// import 'package:taskinity/services/task/task_service.dart';
// import 'package:taskinity/components/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // text controller
//   final TextEditingController _taskController = TextEditingController();
//   String? _editingTaskId;

//   // services
//   final TaskService _taskService = TaskService();

//   @override
//   void dispose() {
//     _taskController.dispose();
//     super.dispose();
//   }

//   // add or update task
//   void addOrUpdateTask() async {
//     if (_taskController.text.isNotEmpty) {
//       if (_editingTaskId == null) {
//         await _taskService.addTask(_taskController.text);
//       } else {
//         await _taskService.updateTask(_editingTaskId!, _taskController.text);
//         _editingTaskId = null;
//       }
//       _taskController.clear();
//     }
//   }

//   // delete task
//   void deleteTask(String taskId) async {
//     try {
//       await _taskService.deleteTask(taskId);
//     } catch (e) {
//       print('Error deleting task: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Taskinity'),
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey,
//         elevation: 0,
//       ),
//       drawer: const MyDrawer(),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildTaskList(),
//           ),
//           _buildUserInput(),
//         ],
//       ),
//     );
//   }

//   // build task list
//   Widget _buildTaskList() {
//     return StreamBuilder(
//       stream: _taskService.getTasksStream(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           print('Error: ${snapshot.error}');
//           return const Center(child: Text('Something went wrong!'));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return ListView(
//           children:
//               snapshot.data!.docs.map((doc) => _buildTaskItem(doc)).toList(),
//         );
//       },
//     );
//   }

//   // build task item
//   Widget _buildTaskItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return ListTile(
//       title: Text(data['task']),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.edit, color: Colors.lightBlueAccent),
//             onPressed: () {
//               setState(() {
//                 _taskController.text = data['task'];
//                 _editingTaskId = doc.id;
//               });
//               FocusScope.of(context).requestFocus(FocusNode());
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.redAccent),
//             onPressed: () => deleteTask(doc.id),
//           ),
//         ],
//       ),
//     );
//   }

//   // build user input
//   Widget _buildUserInput() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: MyTextField(
//                 controller: _taskController,
//                 hintText: 'New task...',
//                 obscureText: false,
//                 keyboardType: TextInputType.text,
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.lightGreen,
//                   width: 2,
//                 ),
//                 color: Colors.lightGreen,
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 onPressed: addOrUpdateTask,
//                 tooltip: 'Add a New Task',
//                 icon: const Icon(Icons.add, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ================================================================
// ================================================================

import 'package:flutter/material.dart';
import 'package:taskinity/components/my_drawer.dart';
import 'package:taskinity/services/task/task_service.dart';
import 'package:taskinity/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final TextEditingController _taskController = TextEditingController();
  String? _editingTaskId;

  // services
  final TaskService _taskService = TaskService();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // add or update task
  void addOrUpdateTask() async {
    if (_taskController.text.isNotEmpty) {
      if (_editingTaskId == null) {
        await _taskService.addTask(_taskController.text);
      } else {
        await _taskService.updateTask(_editingTaskId!, _taskController.text);
        _editingTaskId = null;
      }
      _taskController.clear();
    }
  }

  // delete task
  void deleteTask(String taskId) async {
    try {
      await _taskService.deleteTask(taskId);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  // toggle task completion
  void toggleTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _taskService.updateTaskCompletion(taskId, !isCompleted);
    } catch (e) {
      print('Error updating task completion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Taskinity'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: _buildTaskList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  // build task list
  Widget _buildTaskList() {
    return StreamBuilder(
      stream: _taskService.getTasksStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return const Center(child: Text('Something went wrong!'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Tasks!'));
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildTaskItem(doc)).toList(),
        );
      },
    );
  }

  // build task item
  Widget _buildTaskItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCompleted = data['isCompleted'] ?? false;
    return ListTile(
      leading: Checkbox(
        value: isCompleted,
        onChanged: (bool? value) {
          toggleTaskCompletion(doc.id, isCompleted);
        },
      ),
      title: Text(
        data['task'],
        style: TextStyle(
          decoration:
              isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.lightBlueAccent),
            onPressed: () {
              setState(() {
                _taskController.text = data['task'];
                _editingTaskId = doc.id;
              });
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => deleteTask(doc.id),
          ),
        ],
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
            Expanded(
              child: MyTextField(
                controller: _taskController,
                hintText: 'New task...',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
            ),
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
                onPressed: addOrUpdateTask,
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

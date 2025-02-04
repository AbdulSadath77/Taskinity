// import 'package:taskinity/models/message.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class TaskService {
//   // get instance of firestore
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // get user stream
//   /*
//    List<Map<String, dynamic>> =

//    [
//    {
//    'email': 'text@gmail.com',
//    'id':'',
//    },
//    {
//    'email': 'as@as.com',
//    'id':'',
//    },
//    ]

//    */

//   Stream<List<Map<String, dynamic>>> getUserStream() {
//     return _firestore.collection("Users").snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         // got through each individual user
//         final user = doc.data();

//         // return user
//         return user;
//       }).toList();
//     });
//   }

//   // send message
//   Future<void> sendMessage(String receiverID, message) async {
//     // get current user info
//     final String currentUserID = _auth.currentUser!.uid;
//     final String currentUserEmail = _auth.currentUser!.email!;
//     final Timestamp timestamp = Timestamp.now();

//     // create a new message
//     Message newMessage = Message(
//       senderID: currentUserID,
//       senderEmail: currentUserEmail,
//       receiverID: receiverID,
//       message: message,
//       timestamp: timestamp,
//     );

//     // construct chat room ID for the two users (sorted to ensure uniqueness)
//     List<String> ids = [currentUserID, receiverID];

//     ids.sort(); // sort the ids(this ensures the chatroomID is the same for any 2 people have the same id)
//     String chatRoomID = ids.join('_');

//     // add a new message to database
//     await _firestore
//         .collection("chat_rooms")
//         .doc(chatRoomID)
//         .collection("messages")
//         .add(newMessage.toMap());
//   }

//   // get message
//   Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
//     // construct a chatroom ID for the two users
//     List<String> ids = [userID, otherUserID];
//     ids.sort(); // sort the ids(this ensures the chatroomID is the same for any 2 people)
//     String chatRoomID = ids.join("_");

//     return _firestore
//         .collection("chat_rooms")
//         .doc(chatRoomID)
//         .collection("messages")
//         .orderBy("timestamp", descending: false)
//         .snapshots();
//   }
// }

// ==========================================================
// ==========================================================
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class TaskService {
//   // get instance of firestore
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // get current user
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   // add task
//   Future<void> addTask(String task) async {
//     try {
//       await _firestore.collection('tasks').add({
//         'task': task,
//         'userId': getCurrentUser()?.uid,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print('Error adding task: $e');
//     }
//   }

//   // get tasks stream
//   Stream<QuerySnapshot> getTasksStream() {
//     return _firestore
//         .collection('tasks')
//         .where('userId', isEqualTo: getCurrentUser()?.uid)
//         .snapshots();
//     // .orderBy('timestamp', descending: true)
//   }

//   // update task
//   Future<void> updateTask(String taskId, String task) async {
//     try {
//       await _firestore.collection('tasks').doc(taskId).update({'task': task});
//     } catch (e) {
//       print('Error updating task: $e');
//     }
//   }

//   // delete task
//   Future<void> deleteTask(String taskId) async {
//     try {
//       await _firestore.collection('tasks').doc(taskId).delete();
//     } catch (e) {
//       print('Error deleting task: $e');
//     }
//   }
// }

// ==========================================================
// ==========================================================
// ==========================================================
// ==========================================================

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class TaskService {
//   // get instance of firestore
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // get current user
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   // add task
//   Future<void> addTask(String task) async {
//     try {
//       await _firestore.collection('tasks').add({
//         'task': task,
//         'userId': getCurrentUser()?.uid,
//         'isCompleted': false,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print('Error adding task: $e');
//     }
//   }

//   // get tasks stream
//   Stream<QuerySnapshot> getTasksStream() {
//     return _firestore
//         .collection('tasks')
//         .where('userId', isEqualTo: getCurrentUser()?.uid)
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }

//   // update task
//   Future<void> updateTask(String taskId, String task) async {
//     try {
//       await _firestore.collection('tasks').doc(taskId).update({'task': task});
//     } catch (e) {
//       print('Error updating task: $e');
//     }
//   }

//   // update task completion
//   Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
//     try {
//       await _firestore.collection('tasks').doc(taskId).update({'isCompleted': isCompleted});
//     } catch (e) {
//       print('Error updating task completion: $e');
//     }
//   }

//   // delete task
//   Future<void> deleteTask(String taskId) async {
//     try {
//       await _firestore.collection('tasks').doc(taskId).delete();
//     } catch (e) {
//       print('Error deleting task: $e');
//     }
//   }
// }

// ==========================================================
// ==========================================================
// ==========================================================
// ==========================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // add task
  Future<void> addTask(String task) async {
    try {
      await _firestore.collection('tasks').add({
        'task': task,
        'userId': getCurrentUser()?.uid,
        'isCompleted': false,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  // get tasks stream
  Stream<QuerySnapshot> getTasksStream() {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: getCurrentUser()?.uid)
        // .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // update task
  Future<void> updateTask(String taskId, String task) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({'task': task});
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  // update task completion
  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update({'isCompleted': isCompleted});
    } catch (e) {
      print('Error updating task completion: $e');
    }
  }

  // delete task
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}

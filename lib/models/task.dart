import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String userId;
  final String task;
  final Timestamp timestamp;

  Task({
    required this.id,
    required this.userId,
    required this.task,
    required this.timestamp,
  });

  // convert to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'task': task,
      'timestamp': timestamp,
    };
  }

  // create a Task from a map
  factory Task.fromMap(Map<String, dynamic> map, String documentId) {
    return Task(
      id: documentId,
      userId: map['userId'],
      task: map['task'],
      timestamp: map['timestamp'],
    );
  }
}

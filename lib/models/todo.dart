// // import 'package:cloud_firestore/cloud_firestore.dart';

// class TodoModel {
//   String todoId;
//   String content;
//   bool done;

//   TodoModel({
//     this.todoId = '',
//     this.content = '',
//     this.done = false,
//   });

//   TodoModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
//     todoId = documentSnapshot!.id;
//     content = (documentSnapshot.data()! as Map)['content'] as String;
//     done = (documentSnapshot.data()! as Map)['done'] as bool;
//   }
// }

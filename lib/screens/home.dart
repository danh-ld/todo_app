// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _todoController = TextEditingController();
  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amateur Coder Todo"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     key: const ValueKey("signOut"),
        //     icon: const Icon(Icons.exit_to_app),
        //     onPressed: () {
        //       Auth(auth: widget.auth).signOut();
        //     },
        //   )
        // ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: const ValueKey("addField"),
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    key: const ValueKey("addButton"),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != "") {
                        setState(() {
                          todos = [_todoController.text, ...todos];
                          _todoController.clear();
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Your TodosaaaaaaaaaaaaaTodosaaaaaaaaaaaaaTodosaaaaaaaaaaaaa1",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (_, index) {
              return TodoCard(
                todo: todos[index],
              );
            },
          )),
        ],
      ),
    );
  }
}

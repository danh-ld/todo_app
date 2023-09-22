import 'package:flutter/material.dart';
import 'package:todo_app/screens/home.dart';

void driverLog(String source, String message) {
  print('[$source] $message');
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    driverLog('FlutterError', details.toString());
  };
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Root(),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

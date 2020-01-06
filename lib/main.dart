import 'package:flutter/material.dart';
import 'package:flutter_jaguar_orm/post.dart';
import 'package:flutter_jaguar_orm/user.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(MyApp());
  await testInsertMany();
}

Future testInsertMany() async {
  String dbPath = await getDatabasesPath();
  SqfliteAdapter adapter = SqfliteAdapter(path.join(dbPath, "test"));
  await adapter.connect();

  UserBean userBean = UserBean(adapter);
  PostBean postBean = PostBean(adapter);
  userBean.createTable(ifNotExists: true);
  postBean.createTable(ifNotExists: true);

  List<User> users = [
    User(name: "1"),
    User(name: "2"),
  ];

  userBean.insertMany(users, cascade: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

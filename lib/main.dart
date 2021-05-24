import "package:flutter/material.dart";
import "./threads_list.dart";
import "./structures.dart";
import "./dummy.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diplomat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
	  debugShowCheckedModeBanner: false,
      home: MyHomePage(title: "Diplomat"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
  	Drawer drawer = Drawer(child: ThreadList(sample_threads()));
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        child: Container(
			height: kToolbarHeight,
			child: AppBar(title: Text(widget.title), primary: false),
		),
      ),
	  drawer: drawer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '7573 You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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

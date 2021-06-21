import "package:flutter/material.dart";
import "./threads_list.dart";
import "./structures.dart";
import "./dummy.dart";
import "package:path_provider/path_provider.dart";
import "dart:async";
import "dart:io";
import "./backend/backend.dart";
import "./settings.dart";
import "./ui_util.dart";
import "./thread_interface.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main() async {
	//BEGIN_BACKEND_SETUP
	Directory doc_dir = await getApplicationDocumentsDirectory();
	Directory storage_dir = Directory(doc_dir.path + "/backend");
	backend = Backend(storage_dir);
	//END_BACKEND_SETUP

	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return BlocProvider.value(
			value: SettingsNotifier(),
			child: MaterialApp(
				title: 'Diplomat',
				theme: ThemeData(
					primarySwatch: Colors.blue,
				),
			debugShowCheckedModeBanner: false,
				home: MyHomePage(title: "Diplomat"),
			)
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
		AppBar bar = AppBar(title: Text(widget.title), primary: false);
		BlocProvider.of<SettingsNotifier>(context, listen: true).hello();
		print(context);
		return Scaffold(
			appBar: Settings.ui_appbar_bottom.value ? null : bar,
			bottomNavigationBar: Settings.ui_appbar_bottom.value ? make_app_bar_bottom(bar) : null,
			drawer: drawer,
			body: ThreadInterface(sample_threads()[0]),
			/*floatingActionButton: FloatingActionButton(
				//onPressed: _incrementCounter,
				onPressed: () {
					Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage([""])));
				},
				tooltip: 'Increment',
				child: Icon(Icons.add),
			),*/ 
		);
	}
}

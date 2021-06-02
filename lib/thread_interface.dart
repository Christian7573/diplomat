import "package:flutter/material.dart";
import "./structures.dart";

class ThreadInterface extends StatelessWidget {
	Thread thread;
	ThreadInterface(this.thread);

	@override Widget build(BuildContext context) {
		Color transparent = Color.fromARGB(0, 0, 0, 0);
		return Column(children: [
			Expanded(child: Padding(
				padding: EdgeInsets.all(10),
				child: Text("Test")
			)),
			Padding(padding: EdgeInsets.all(10), child: Row(children: [
				FloatingActionButton(
					onPressed: () {},
					child: Icon(Icons.attach_file),
					elevation: 0,
					mini: true,
					foregroundColor: Theme.of(context).accentColor,
					backgroundColor: transparent,
					hoverColor: Color.fromARGB(0,255,0,0),
					hoverElevation: 0,
				),
				Expanded(child: TextField()),
				Container(width: 10),
				FloatingActionButton(
					child: Icon(Icons.send),
					onPressed: (){},
					elevation: 0,
					mini: true,
				)
			]) )
		]);
	}
}

class _MessageTile extends StatelessWidget {
	final Message message;
	final Author author;
	_MessageTile(this.message, this.author);

	@override Widget build(BuildContext context) {
		return ListTile(
			title: Text(this.author.name),
			subtitle: Text(this.message.content),
		);
	}
}

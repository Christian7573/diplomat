import "package:flutter/material.dart";
import "./structures.dart";
import "./multiaddr.dart";
import "./settings.dart";

class ThreadInterface extends StatelessWidget {
	Thread thread;
	ThreadInterface(this.thread);

	@override Widget build(BuildContext context) {
		Color transparent = Color.fromARGB(0, 0, 0, 0);
		return Column(children: [
			Expanded(child: Padding(
				padding: EdgeInsets.all(10),
				child: _Messages(thread)
			)),
			Padding(padding: EdgeInsets.all(10), child: Row(children: [
				FloatingActionButton(
					onPressed: () {
						Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage([""])));
					},
					child: Icon(Icons.attach_file),
					elevation: 0,
					mini: true,
					foregroundColor: Theme.of(context).accentColor,
					backgroundColor: transparent,
					hoverColor: Color.fromARGB(0,255,0,0),
					hoverElevation: 0,
					heroTag: "thread_interface_attachment"
				),
				Expanded(child: TextField()),
				Container(width: 10),
				FloatingActionButton(
					child: Icon(Icons.send),
					onPressed: (){},
					elevation: 0,
					mini: true,
					heroTag: "thread_interface_send"
				)
			]) )
		]);
	}
}

class _Messages extends StatefulWidget {
	final Thread thread;
	_Messages(this.thread);
	State<_Messages> createState() => new _MessagesState();
}
class _MessagesState extends State<_Messages> {
	@override Widget build(BuildContext contest) {
		return ListView.builder(
			itemCount: widget.thread.message_batches.fold(0, (count, batch) { return count! + batch.messages.length; }),
			itemBuilder: (BuildContext context, int item_number) {
				//TODO make badn't
				int i = 0;
				while (item_number >= widget.thread.message_batches[i].messages.length) {
					i++;
					item_number -= widget.thread.message_batches[i].messages.length;
				}
				return _MessageTile(widget.thread.message_batches[i].messages[item_number], Author(Multiaddr.parse("/dummy")!, "Dummy"));
			}
		);
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
			leading: CircleAvatar(
				backgroundColor: Color.fromARGB(255,0,200,255),
			)
		);
	}
}

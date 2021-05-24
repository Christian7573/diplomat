import "package:flutter/material.dart";
import "./structures.dart";

class ThreadList extends StatelessWidget {
	final List<Thread> threads;
	
	ThreadList(this.threads);

	@override Widget build(BuildContext context) {
		return ListView(
			children: this.threads.map((thread) => _ThreadListItem(thread)).cast<Widget>().toList()
		);
	}
}

/*class _ThreadListState extends State<ThreadList> {
	Map<Multiaddr, bool> expansion_state = Map<Multiaddr, bool>();
	@override Widget build(BuildContext build) {
		return ListView(
			children: this.widget.threads.map((thread) => _ThreadListItem(thread, this.expansion_state)).cast<Widget>().toList()
		);
	}
}*/

class _ThreadListItem extends StatelessWidget {
	final Thread thread;
	/*bool open;
	_ThreadListItem(this.thread, Map<Multiaddr, bool> expansion_state)
	  : this.open = expansion_state[thread.addr] ?? false
	{
	}*/
	_ThreadListItem(this.thread);

	@override Widget build(BuildContext build) {
		return ExpansionTile(
			key: PageStorageKey(this.thread.addr),
			title: Text(this.thread.name),
			children: this.thread.children.map((thread) => _ThreadListItem(thread)).cast<_ThreadListItem>().toList(),
		);
	}
}

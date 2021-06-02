import "./multiaddr.dart";

class Thread {
	Multiaddr addr;
	String name;
	List<Thread> children = [];

	Thread(this.addr, this.name, {List<Thread>? children}) {
		if (children != null) this.children = children;
	}
}

class Message {
	Multiaddr addr;
	Multiaddr author;
	String content;

	Message(this.addr, this.author, this.content);
}

class Author {
	Multiaddr addr;
	String name;

	Author(this.addr, this.name);
}

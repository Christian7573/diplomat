import "./multiaddr.dart";

class Thread {
	Multiaddr addr;
	String name;
	List<Thread> children = [];

	Thread(this.addr, this.name, {List<Thread>? children}) {
		if (children != null) this.children = children;
	}
}

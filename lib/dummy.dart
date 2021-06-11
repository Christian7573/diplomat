import "./structures.dart";
import "./multiaddr.dart";

List<Thread> sample_threads() {
	Thread dummy1 = Thread(Multiaddr.parse("/thread/lolrandom")!, "Dummy Thread");
	dummy1.message_batches.add(MessageBatch([
		Message(Multiaddr.parse("/dummy")!, Multiaddr.parse("/dummy")!, "Hello")
	]));
	return [
		dummy1,
		Thread(
			Multiaddr.parse("/thread/lolrandom2")!, "Dummy Thread 2",
			children: [
				Thread(Multiaddr.parse("/thread/lolrandom_child")!, "Dummy Thread 3")
			]
		)
	];
}

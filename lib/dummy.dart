import "./structures.dart";
import "./multiaddr.dart";

List<Thread> sample_threads() {
	return [
		Thread(Multiaddr.parse("/thread/lolrandom")!, "Dummy Thread"),
		Thread(
			Multiaddr.parse("/thread/lolrandom2")!, "Dummy Thread 2",
			children: [
				Thread(Multiaddr.parse("/thread/lolrandom_child")!, "Dummy Thread 3")
			]
		)
	];
}

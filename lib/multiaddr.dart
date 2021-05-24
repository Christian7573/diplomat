class Multiaddr {
	List<MultiaddrComponent> components;
	Multiaddr(this.components);

	static Multiaddr? parse(String addr) {
		if (addr[0] != '/') return null;		
		List<MultiaddrComponent> components = [];
		Iterator<String> bits = addr.substring(1).split("/").iterator;
		while (bits.moveNext()) {
			switch (bits.current.toLowerCase()) {
				case "thread": {
					MultiaddrThreadComponent? comp = MultiaddrThreadComponent.parse(bits);
					if (comp == null) return null;
					components.add(comp);
				} break;

				default: {

				} break;
			}
		}
		return Multiaddr(components);
	}

	@override String toString() {
		if (this.components.isEmpty) return "/";
		return this.components.fold("", (prev, component) => prev + component.toString());
	}
	@override bool operator==(Object other) => this.toString() == other.toString();
	int get hashCode => this.toString().hashCode;
}

enum MultiaddrComponentType {
	Thread
}

abstract class MultiaddrComponent {
	MultiaddrComponentType get type;
	@override bool operator==(Object other) => this.toString() == other.toString();
	int get hashCode => this.toString().hashCode;
}

class MultiaddrThreadComponent extends MultiaddrComponent {
	String id;
	MultiaddrThreadComponent(this.id);
	MultiaddrComponentType get type => MultiaddrComponentType.Thread;
	static MultiaddrThreadComponent? parse(Iterator<String> bits) {
		if (!bits.moveNext()) return null;
		return MultiaddrThreadComponent(bits.current);
	}
	@override String toString() => "/thread/$id";
}

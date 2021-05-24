import "package:flutter/material.dart";

class Settings {

}

class Setting<T> {
	final String name;
	final T Function() default_value;
	T? _value;
	T get value => _value ?? default_value();
	Setting(this.name, this.default_value);	
}

class SettingsPage extends StatefulWidget {
	final List<String> initial_route;
	SettingsPage(this.initial_route);
	@override _SettingsPageState createState() => _SettingsPageState(this.initial_route);
}

class _SettingsPageState extends State<SettingsPage> {
	List<String> route;
	_SettingsPageState(this.route);

	@override Widget build(BuildContext context) {
	throw "Lmao";
	}
}

import "package:flutter/material.dart";
import "./backend/backend.dart";
import "./ui_util.dart";

List<Setting<dynamic>> _all_settings = [];
class Settings {
	static Setting<bool> ui_appbar_bottom = Setting<bool>("ui_appbar_bottom", "Bottom Appbar", () => false, _all_settings);
}

class _SettingsPaneData {
	final String name;
	final String title;
	final List<dynamic> contents;
	_SettingsPaneData(this.name, this.title, this.contents);
	List<_SettingsPane> build_panes(List<String> route, _SettingsPageState state) {
		dynamic? selected_item = null;
		if (route.length > 1) {
			for (dynamic content in this.contents) {
				if (content is _SettingsPaneData && content.name == route[0]) {
					selected_item = content;
					break;
				}
			}
		} else {
			for (dynamic content in this.contents) {
				if (content is Setting && content.name == route[0]) {
					selected_item = content;
					break;
				}
			}
		}
		List<_SettingsPane> my_pane = [_SettingsPane(this.title, this.contents, selected_item, state)];
		if (route.length > 1 && selected_item != null) my_pane += selected_item.build_panes(route.sublist(1), state);
		return my_pane;
	}
}
_SettingsPaneData _pane_data = _SettingsPaneData("main", "Settings", [
	Settings.ui_appbar_bottom		
]);


class Setting<T> {
	final String name;
	final String display_name;
	final T Function() default_value;
	T? _value;
	T get value => _value ?? default_value();
	set value(T value) { this._value = value; }
	Setting(this.name, this.display_name, this.default_value, List<Setting<dynamic>> all_settings) {
		all_settings.add(this);
	}	
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
		MediaQueryData query = MediaQuery.of(context);
		List<_SettingsPane> raw_open_panes = _pane_data.build_panes(this.route, this);
		const double lesser_pane_width = 500 + 15;
		const double right_padding = 30;
		double horizontal_estate = query.size.width - right_padding; //BORK POTENTIAL null safety
		double greater_pane_width = horizontal_estate - (((horizontal_estate / lesser_pane_width).floor() - 1) * lesser_pane_width);
		if (greater_pane_width < lesser_pane_width) greater_pane_width = horizontal_estate;

		int i = -1;
		const double left_padding = right_padding;
		List<Widget> panes = raw_open_panes.map((pane) {
			i += 1;
			late double width;
			if (i == raw_open_panes.length - 1) width = greater_pane_width;
			else width = lesser_pane_width;
			if (raw_open_panes.length == 1) width = horizontal_estate;
			return Container(
				width: width,
				padding: EdgeInsets.fromLTRB(left_padding, 0, 0, 0),
				child: pane
			);
		}).toList();

		ListView scroll = ListView(
			scrollDirection: Axis.horizontal,
			padding: EdgeInsets.fromLTRB(0, right_padding, right_padding, right_padding),
			reverse: true,
			children: panes,
		);


		AppBar appbar = AppBar(title: Text("Settings"));
		return Scaffold(
			appBar: Settings.ui_appbar_bottom.value ? null : appbar,
			bottomNavigationBar: Settings.ui_appbar_bottom.value ? make_app_bar_bottom(appbar) : null,
			body: scroll
		);
	}

	void change_setting<T>(Setting<T> setting, T value) {
		setState(() { setting.value = value; });
	}
}

class _SettingsPane extends StatelessWidget {
	final List<dynamic> settings;
	final dynamic? selected_item;
	final String title;
	final _SettingsPageState state;
	_SettingsPane(this.title, this.settings, this.selected_item, this.state);
	@override Widget build(BuildContext context) {
		return ListView(
			children: [
				Padding(
					padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
					child: Text(this.title, style: Theme.of(context).textTheme.headline5)
				)
			].cast<Widget>() + this.settings.map((dynamic setting) {
				late Widget card;
				if (setting is Setting<bool>) card = _BooleanCard(setting, this.state);
				else throw "Unimplemented setting type";
				return Container(
					decoration: const BoxDecoration( border: const Border( top: BorderSide() ) ),
					child: card
				);
			}).cast<Widget>().toList()
		);
	}
}

Padding card_padding(Widget child, { Key? key }) {
	return Padding(
		padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
		child: child,
		key: key
	);
}

class _BooleanCard extends StatelessWidget {
	final Setting<bool> setting;
	final _SettingsPageState state;
	_BooleanCard(this.setting, this.state);
	@override Widget build(BuildContext context) {
		return card_padding( Row (
			key: PageStorageKey(this.setting.name),
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				Expanded(child: Text(this.setting.display_name)),
				Switch(value: this.setting.value, onChanged: (bool newValue) {
					this.state.change_setting(this.setting, newValue);
				}),
			],
		) );
	}
}

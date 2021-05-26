import "dart:async";
import "dart:io";

late Backend backend;

class Backend {
	Directory storage_folder;
	Backend(this.storage_folder);

	File get settings_file => File(this.storage_folder.path + "/settings");
	Future<String> get_settings_file() async {
		return await this.settings_file.readAsString();
	}
	Future<void> put_settings_file(String contents) async {
		await this.settings_file.writeAsString(contents);
	}
}

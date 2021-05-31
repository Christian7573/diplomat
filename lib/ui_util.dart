import "package:flutter/material.dart";

BottomAppBar make_app_bar_bottom(AppBar bar) {
	return BottomAppBar( child: Container( height: kToolbarHeight, child: bar ) );
}

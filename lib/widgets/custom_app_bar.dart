import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  
  return AppBar(
    title: const Text('Edit Profile'),
    leading: IconButton(
      icon: const Icon(CupertinoIcons.moon_stars),
      onPressed: () => Navigator.of(context).pop(),
    ),
    elevation: 0,
    actions: <Widget>[
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();
            final themeSwitcher = ThemeSwitcher.of(context);
            themeSwitcher.changeTheme(theme: theme);
          },
        ),
      )
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/theme_view_model.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeViewModel>(context);
    final provider = Provider.of<ThemeViewModel>(context, listen: false);
    return Switch.adaptive(
        activeColor: Colors.blue,
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          provider.buttonTheme(value);
        });
  }
}

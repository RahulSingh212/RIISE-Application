// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class ScreenControllerProvider with ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  int selectedPageIndex = 0;
}
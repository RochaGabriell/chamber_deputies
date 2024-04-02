import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:chamber_deputies/src/screens/deputy_details.dart';
import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/screens/home.dart';
import 'package:chamber_deputies/src/screens/deputies.dart';

Map<String, String> routesMap = {
  'Home': '/',
  'Deputies': '/deputies',
  'DeputyDetails': '/deputy-details',
  'Comissions': '/comissions',
};

Route browserRouter(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );

    case '/deputies':
      return MaterialPageRoute(
        builder: (context) => const Deputies(),
      );

    case '/deputy-details':
      return MaterialPageRoute(
        builder: (context) =>
            DeputyDetails(deputy: settings.arguments as DeputiesModels),
      );

    case '/comissions':
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );

    default:
      return MaterialPageRoute(builder: (context) => const Home());
  }
}

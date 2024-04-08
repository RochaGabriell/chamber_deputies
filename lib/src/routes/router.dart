import 'package:flutter/material.dart';

// Home
import 'package:chamber_deputies/src/screens/home.dart';
// Deputies
import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:chamber_deputies/src/screens/deputy_details/deputy_details.dart';
import 'package:chamber_deputies/src/screens/deputies/deputies.dart';
// Fronts
import 'package:chamber_deputies/src/models/fronts.dart';
import 'package:chamber_deputies/src/screens/fronts.dart';
import 'package:chamber_deputies/src/screens/fronts_details/front_details.dart';
// About
import 'package:chamber_deputies/src/screens/about.dart';

Map<String, String> routesMap = {
  'Home': '/',
  'Deputies': '/deputies',
  'DeputyDetails': '/deputy-details',
  'Fronts': '/fronts',
  'FrontsDetails': '/fronts-details',
  'About': '/about',
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
        builder: (context) => DeputyDetails(
          deputy: settings.arguments as DeputiesModels,
        ),
      );

    case '/fronts':
      return MaterialPageRoute(
        builder: (context) => const Fronts(),
      );

    case '/fronts-details':
      return MaterialPageRoute(
        builder: (context) => FrontDetails(
          front: settings.arguments as FrontsModels,
        ),
      );

    case '/about':
      return MaterialPageRoute(
        builder: (context) => const About(),
      );

    default:
      return MaterialPageRoute(builder: (context) => const Home());
  }
}

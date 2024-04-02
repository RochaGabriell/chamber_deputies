import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chamber Deputies',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(4, 34, 116, 1),
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      onGenerateRoute: browserRouter,
      initialRoute: routesMap['Home'],
      debugShowCheckedModeBanner: true,
    );
  }
}

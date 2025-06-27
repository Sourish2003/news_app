import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';

import 'config/routes/routes.dart';
import 'features/news_list/view/news_list_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final alice = Alice(
  navigatorKey: navigatorKey,
  showNotification: kDebugMode,
  showInspectorOnShake: kDebugMode,
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



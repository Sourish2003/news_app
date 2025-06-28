import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'config/Theme/theme_config.dart';
import 'config/routes/routes_config.dart';

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
    return MultiProvider(
      providers: providers,
      child: OverlaySupport.global(
        child: MaterialApp.router(
          routerConfig: routerConfig,
          debugShowCheckedModeBanner: false,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: Stack(
              children: [FlutterEasyLoading(child: child)],
            ),
          ),
        ),
      ),
    );
  }
}

var providers = [
  ChangeNotifierProvider(create: (context) => ThemeConfig()),
];

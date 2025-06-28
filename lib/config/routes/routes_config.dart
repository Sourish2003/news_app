import 'package:go_router/go_router.dart';
import '../../features/news_list/view/news_list_screen.dart';
import '../../main.dart';

final GoRouter routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MyHomePage(title: 'NEWS'),
    ),
  ],
);

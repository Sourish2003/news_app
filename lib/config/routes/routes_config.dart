import 'package:go_router/go_router.dart';
import '../../features/news_detail/view/news_detail_screen.dart';
import '../../features/news_list/model/news_list_model.dart';
import '../../features/news_list/view/news_list_screen.dart';
import '../../main.dart';

final GoRouter routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const NewsListScreen(),
    ),
    GoRoute(
      path: "/news-detail",
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final article = extra['article'] as Article;
        final searchQuery = extra['searchQuery'] as String? ?? '';

        return NewsDetailScreen(
          article: article,
          searchQuery: searchQuery,
        );
      },
    ),
  ],
);
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../news_list/model/news_list_model.dart';

class NewsDetailViewModel extends ChangeNotifier {
  Article? _article;
  String _searchQuery = '';

  Article? get article => _article;

  String get searchQuery => _searchQuery;

  void setArticle(Article article, String searchQuery) {
    _article = article;
    _searchQuery = searchQuery;
    notifyListeners();
  }

  // Share article
  Future<void> shareArticle() async {
    if (_article != null) {
      final text = '${_article!.title}\n\nRead more: ${_article!.url}';
      await Share.share(text);
    }
  }

  Future<bool> openInBrowser() async {
    if (_article == null || _article!.url.isEmpty) {
      return false;
    }

    try {
      String url = _article!.url;

      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        return true;
      } else {
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
        );
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error opening URL: $e');
      }
      return false;
    }
  }

  // Format date
  String getFormattedDate() {
    if (_article == null) return '';

    final date = _article!.publishedAt;
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

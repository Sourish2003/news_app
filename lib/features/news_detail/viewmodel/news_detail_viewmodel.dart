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
      await SharePlus.instance.share(ShareParams(text: text));
    }
  }

  // Open article in browser
  Future<bool> openInBrowser() async {
    if (_article != null && _article!.url.isNotEmpty) {
      final Uri url = Uri.parse(_article!.url);
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
        );
        return true;
      }
    }
    return false;
  }

  // Format date
  String getFormattedDate() {
    if (_article == null) return '';

    final date = _article!.publishedAt;
    final months = ['January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
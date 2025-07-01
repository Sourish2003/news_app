import 'package:flutter/foundation.dart';

import '../../../utils/api_helpers/api_status.dart';
import '../model/news_list_model.dart';
import '../repository/news_list_repository.dart';

class NewsListViewModel extends ChangeNotifier {
  final NewsListRepository _repository = NewsListRepository();

  // States
  bool _isLoading = false;
  List<Article> _articles = [];
  String _errorMessage = '';
  String _selectedCategory = '';
  String _searchQuery = '';

  // Getters
  bool get isLoading => _isLoading;

  List<Article> get articles => _articles;

  String get errorMessage => _errorMessage;

  String get selectedCategory => _selectedCategory;

  String get searchQuery => _searchQuery;

  // Initialize with default news
  NewsListViewModel() {
    fetchNews();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Set articles
  void _setArticles(List<Article> articles) {
    _articles = articles;
    notifyListeners();
  }

  // Set selected category
  void setSelectedCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _searchQuery = '';
      notifyListeners();
      fetchNewsByCategory(category);
    }
  }

  // Fetch news
  Future<void> fetchNews({String? query}) async {
    _setLoading(true);
    _setError('');

    try {
      final response = await _repository.fetchNewsList(query: query);

      if (response is Success) {
        NewsModel newsModel = response.response as NewsModel;
        _setArticles(newsModel.articles);
      } else if (response is Failure) {
        _setError(response.response.toString());
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Search news
  Future<void> searchNews(String query) async {
    _searchQuery = query;
    _selectedCategory = '';
    if (query.isNotEmpty) {
      await fetchNews(query: query);
    } else {
      await fetchNews();
    }
  }

  // Fetch news by category
  Future<void> fetchNewsByCategory(String category) async {
    await fetchNews(query: category);
  }

  // Refresh news
  Future<void> refreshNews() async {
    if (_searchQuery.isNotEmpty) {
      await fetchNews(query: _searchQuery);
    } else if (_selectedCategory.isNotEmpty) {
      await fetchNews(query: _selectedCategory);
    } else {
      await fetchNews();
    }
  }

  // Calculate reading time based on content
  String calculateReadingTime(Article article) {
    const int wordsPerMinute = 200;
    const int imageReadingTimeSeconds = 12;

    // Count words in title, description, and content
    String fullText =
        '${article.title} ${article.description} ${article.content}';
    int wordCount =
        fullText.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;

    // Check for [+nnnn chars] pattern and add extra time
    RegExp extraContentPattern =
        RegExp(r'\[\+(\d+)\s*chars?\]', caseSensitive: false);
    Match? match = extraContentPattern.firstMatch(article.content);
    if (match != null) {
      int extraChars = int.tryParse(match.group(1) ?? '0') ?? 0;
      // Assuming average 5 characters per word
      int extraWords = (extraChars / 5).round();
      wordCount += extraWords;
    }

    // Calculate reading time in minutes
    double readingTimeMinutes = wordCount / wordsPerMinute;

    // Add time for image if present
    if (article.urlToImage.isNotEmpty) {
      readingTimeMinutes += imageReadingTimeSeconds / 60;
    }

    // Round to nearest minute, minimum 1 minute
    int totalMinutes = readingTimeMinutes.round();
    if (totalMinutes < 1) totalMinutes = 1;

    return '$totalMinutes min Read';
  }
}

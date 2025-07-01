import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/config/Theme/themes.dart';
import 'package:provider/provider.dart';
import '../../../utils/components/loading_overlay.dart';
import '../../../utils/extensions/context_extension.dart';
import '../model/news_list_model.dart';
import '../viewmodel/news_list_viewmodel.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize viewmodel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsListViewModel>();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsListViewModel>(
      builder: (context, viewModel, child) {
        return LoadingOverlay(
          isLoading: viewModel.isLoading,
          loadingText: 'Fetching news...',
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Padding(
                padding: EdgeInsets.only(left: context.screenWidth * 0.07 - 16),
                child: Text(
                  'NEWS',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              actions: [
                Padding(
                  padding:
                      EdgeInsets.only(right: context.screenWidth * 0.07 - 16),
                  child: Text(
                    _getCurrentDate(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () => viewModel.refreshNews(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.07,
                  vertical: context.screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    Text(
                      'Hey, James!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      'Discover Latest\nNews',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                    ),
                    const SizedBox(height: 20),

                    // Search Bar
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search For News',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: surfaceBackground),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            onSubmitted: (value) {
                              viewModel.searchNews(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              viewModel.searchNews(_searchController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.screenHeight * 0.05),

                    // Categories
                    _buildCategories(viewModel),
                    SizedBox(height: context.screenHeight * 0.06),

                    // News List
                    Expanded(
                      child: _buildNewsList(viewModel),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategories(NewsListViewModel viewModel) {
    final categories = [
      {'name': 'Politics', 'icon': FontAwesomeIcons.microphoneLines},
      {'name': 'Movies', 'icon': Icons.movie_creation_rounded},
      {'name': 'Sports', 'icon': Icons.sports_cricket_rounded},
      {'name': 'Crime', 'icon': FontAwesomeIcons.gun},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((category) {
        final isSelected = viewModel.selectedCategory == category['name'];
        return GestureDetector(
          onTap: () {
            viewModel.setSelectedCategory(category['name'] as String);
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFFF8B0B0) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: isSelected ? Colors.red : customBlackColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category['name'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? customBlackColor : Colors.black54,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNewsList(NewsListViewModel viewModel) {
    if (viewModel.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${viewModel.errorMessage}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.refreshNews(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (viewModel.articles.isEmpty && !viewModel.isLoading) {
      return const Center(
        child: Text('No news articles found'),
      );
    }

    return ListView.builder(
      itemCount: viewModel.articles.length,
      itemBuilder: (context, index) {
        final article = viewModel.articles[index];
        return _buildNewsItem(article, viewModel.searchQuery);
      },
    );
  }

  Widget _buildNewsItem(Article article, String searchQuery) {
    final viewModel = Provider.of<NewsListViewModel>(context);
    return GestureDetector(
      onTap: () {
        // Navigate to detail screen
        context.push('/news-detail', extra: {
          'article': article,
          'searchQuery': searchQuery,
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: article.urlToImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: article.urlToImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return Container(
                          width: 100,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    )
                  : Container(
                      width: 100,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image),
                    ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        viewModel.calculateReadingTime(article),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(width: context.screenWidth * 0.01),
                      Text(
                        '• ',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'Today',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
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
    return '${now.day} ${months[now.month - 1]}, ${now.year}';
  }
}

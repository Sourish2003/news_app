import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../widgets/reusable_snack_bar.dart';
import '../../news_list/model/news_list_model.dart';
import '../viewmodel/news_detail_viewmodel.dart';

class NewsDetailScreen extends StatefulWidget {
  final Article article;
  final String searchQuery;

  const NewsDetailScreen({
    super.key,
    required this.article,
    required this.searchQuery,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late NewsDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = NewsDetailViewModel();
    _viewModel.setArticle(widget.article, widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<NewsDetailViewModel>(
        builder: (context, viewModel, child) {
          final article = viewModel.article;
          if (article == null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeftLong,
                      color: Colors.black),
                  onPressed: () => context.pop(),
                ),
              ),
              body: const Center(child: Text('No article data')),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => context.pop(),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Source and Date
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              article.source.name.isNotEmpty
                                  ? article.source.name[0].toUpperCase()
                                  : 'N',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 25,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        ),
                        // const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.getFormattedDate(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              article.source.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Title with highlighted search query
                    _buildHighlightedText(
                      article.title,
                      viewModel.searchQuery,
                      Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ) ??
                          const TextStyle(),
                    ),
                    const SizedBox(height: 16),

                    // Description
                    Text(
                      article.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final success = await viewModel.openInBrowser();
                              if (!success && mounted) {
                                ReusableSnackBar.showErrSnackBar(
                                  context,
                                  'Could not open article',
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Read Story',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => viewModel.shareArticle(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Share Now',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Image
                    if (article.urlToImage.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          article.urlToImage,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Content with highlighted search query
                    _buildHighlightedText(
                      article.content,
                      viewModel.searchQuery,
                      TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Build text with highlighted search query
  Widget _buildHighlightedText(String text, String query, TextStyle style) {
    if (query.isEmpty) {
      return Text(text, style: style);
    }

    final matches = RegExp(query, caseSensitive: false).allMatches(text);
    if (matches.isEmpty) {
      return Text(text, style: style);
    }

    final spans = <TextSpan>[];
    int lastMatchEnd = 0;

    for (final match in matches) {
      // Add text before match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: style,
        ));
      }

      // Add matched text with red underline
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: style.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationThickness: 2,
        ),
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining text
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: style,
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}

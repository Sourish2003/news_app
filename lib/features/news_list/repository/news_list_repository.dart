import '../../../data/remote_data/network/base_api_service.dart';
import '../../../utils/api_helpers/api_status.dart';
import '../model/news_list_model.dart';

class NewsListRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<Object> fetchNewsList({String? query, String? category}) async {
    try {
      Map<String, dynamic> queryParams = {
        'apiKey': '838fec976d7b4f0abdf753433b5d6b95',
      };

      // Add query or category parameter
      if (query != null && query.isNotEmpty) {
        queryParams['q'] = query;
      } else if (category != null && category.isNotEmpty) {
        queryParams['q'] = category;
      } else {
        // Default query if nothing specified
        queryParams['q'] = 'latest';
      }

      // Add date parameters for fresh content
      DateTime now = DateTime.now();
      DateTime monthAgo = now.subtract(const Duration(days: 30));
      queryParams['from'] = monthAgo.toIso8601String().split('T')[0];
      queryParams['sortBy'] = 'publishedAt';

      dynamic response = await _apiService.getResponse('/everything',
          queryParams: queryParams);

      if (response is Success) {
        NewsModel newsModel =
            NewsModel.fromJson(response.response as Map<String, dynamic>);
        return Success(code: response.code, response: newsModel);
      }
      return response;
    } catch (e) {
      return Failure(code: 103, response: e.toString());
    }
  }
}

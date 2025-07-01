import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../config/constants/api_constants.dart';
import '../../../config/constants/app_constants.dart';
import '../../../utils/api_helpers/api_helper.dart';
import '../../../utils/api_helpers/api_status.dart';
import '../../catch_data/shared_preference_catch.dart';

class NetworkApiService {
  ApiHelper apiHelper = ApiHelper();

  Future getResponse(String url, {Map<String, dynamic>? queryParams}) async {
    dynamic responseJson;
    log(Uri.parse(ApiConstants.baseUrl + url).toString());
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + url)
          .replace(queryParameters: queryParams);

      log(uri.toString());

      final request = http.Request('GET', uri);
      request.headers.addAll(await customApiHeader());

      // Create a client using alice
      final client = http.Client();

      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      // // Log the request and response in Alice
      // if (kDebugMode) {
      //   alice.onHttpResponse(response, body: null);
      // }

      responseJson = apiHelper.returnResponse(response);
    } on SocketException {
      throw Failure(
        code: NO_INTERNET,
        response: 'No Internet Connection',
      );
    }
    return responseJson;
  }

  Future<Map<String, String>> customApiHeader({String contentType = ""}) async {
    String token = await getAccessToken(); //application/json
    if (contentType.isNotEmpty) {
      return {'Authorization': 'Bearer $token', 'content-type': contentType};
    } else {
      return {'Authorization': 'Bearer $token'};
    }
  }

  getAccessToken() async {
    // String token = await getStrPrefs(key: access_token) ?? "";
    String token = await getStrPrefs(key: access_token) ?? "";
    return token;
  }
}

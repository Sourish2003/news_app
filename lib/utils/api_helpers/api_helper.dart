import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../config/constants/app_constants.dart';
import 'api_status.dart';

class ApiHelper {
  var logger = Logger();

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case SUCCESS:
        var responseJson = json.decode(response.body.toString());
        logger.log(Level.debug, responseJson);
        return Success(
            code: response.statusCode, response: jsonDecode(response.body));
      case INVALID_API_RESPONSE:
        throw Failure(
            code: response.statusCode, response: "Invalid API Response");
      case UNAUTHORISED_ERROR || FORBIDDEN_ERROR:
        throw Failure(
            code: response.statusCode, response: "Unauthorized Error");
      case INVALID_FORMAT:
        throw Failure(
            code: response.statusCode, response: "Invalid Format Response");
      default:
        throw Failure(code: response.statusCode, response: "Other Error");
    }
  }
}

import 'package:logger/logger.dart';

class ReusableLoggerService {
  Logger logger = Logger();

  errorLog(String msg) {
    logger.e(msg);
  }

  infoLog(String msg) {
    logger.i(msg);
  }

  debugLog(String msg) {
    logger.d(msg);
  }

  warningLog(String msg) {
    logger.w(msg);
  }
}

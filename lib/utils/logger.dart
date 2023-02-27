import 'package:logger/logger.dart';

class Log {
  static Logger? _instance;

  static void init() {
    _instance = Logger(
      printer: PrettyPrinter(stackTraceBeginIndex: 4),
    );
  }

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _instance?.v(message, error, stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _instance?.d(message, error, stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _instance?.i(message, error, stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _instance?.w(message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _instance?.e(message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _instance?.wtf(message, error, stackTrace);
  }
}

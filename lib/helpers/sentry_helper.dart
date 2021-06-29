
import 'package:sentry/sentry.dart';
import 'package:untitled2/keys/api_keys.dart';

class SentryHelper {

  final dynamic exception;
  final dynamic stackTrace;

  SentryHelper({
    this.exception,
    this.stackTrace
  });

  Future<void> report() async {
    SentryOptions options =SentryOptions(dsn:kSentryDomainNameSystem );
    print(this.exception);
    print(this.stackTrace);

    await SentryClient(options )
        // .captureException(
      // exception: exception,
      // stackTrace: stackTrace
    // );
 ; }
}
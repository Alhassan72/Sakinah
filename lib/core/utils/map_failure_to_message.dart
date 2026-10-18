import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/core/strings/failure_string.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailure;
    case CacheFailure:
      return cacheFailure;
    case NetworkFailure:
      return offlineFailure;
    default:
      return unexpectedFailure;
  }
}

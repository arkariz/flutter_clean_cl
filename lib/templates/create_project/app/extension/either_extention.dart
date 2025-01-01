import 'package:dartz/dartz.dart';
import '../exception/custome_failure.dart';

extension EitherExtension<L, R> on Either<L, R> {
  B handleError<B>({
    B Function(L l)? additionalFunctionFailure,
    B Function(L l)? overrideFailure,
    required B Function(L l) onFailure,
    required B Function(R r) onSuccess,
    required B Function(DecodeFailedFailure failure) onDecodeFailed,
    required B Function(NoInternetFailure failure) onNoInternet,
    required B Function(RequestTimeoutFailure failure) onRequestTimeout,
    required B Function(BadResponseFailure failure) onBadResponse,
    required B Function(FirebaseAuthFailure failure) onFirebaseAuth,
  }) {
    return fold(
      (error) {
        if (additionalFunctionFailure != null) {
          additionalFunctionFailure(error);
        }

        if (overrideFailure != null) {
          return overrideFailure(error);
        } else if (error is NoInternetFailure) {
          return onNoInternet(error);
        } else if(error is DecodeFailedFailure) {
          return onDecodeFailed(error);
        } else if (error is RequestTimeoutFailure) {
          return onRequestTimeout(error);
        } else if (error is BadResponseFailure) {
          return onBadResponse(error);
        } else if (error is FirebaseAuthFailure) {
          return onFirebaseAuth(error);
        } else {
          return onFailure(error);
        }
      },
      (result) {
        return onSuccess(result);
      }
    );
  }
}
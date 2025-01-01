import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../app/exception/custome_exception.dart';
import '../../../app/exception/custome_failure.dart';

class RepositoryHandler {
  Future<Either<Failure, T>> handleOperation<T>({
    required Future<T?> Function() operationOnline,
    Future<T?> Function()? opperationOffline,
  }) async {
    if (!await checkinternet() && opperationOffline != null) {
      try {
        final result = await opperationOffline();
        return Right(result as T);
      } on LocalStorageException catch (_) {
        return const Left(LocalStorageFailure());
      } catch (e) {
        return Left(GeneralFailure(message: e.toString()));
      }
    }

    try {
      final result = await operationOnline();
      return Right(result as T);
    } on RequestTimeoutException catch (_) {
      return const Left(RequestTimeoutFailure());
    } on DecodeFailedException catch (_) {
      return const Left(DecodeFailedFailure());
    } on NoInternetException catch (_){
      return const Left(NoInternetFailure());
    } on DataNotfoundException catch (_) {
      return const Left(DataNotfoundFailure());
    } on LocalStorageException catch (_) {
      return const Left(LocalStorageFailure());
    } on BadResponseException catch (e) {
      return Left(BadResponseFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  Future<bool> checkinternet() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return true;
    } else {
      return false;
    }
  }
}
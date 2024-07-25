import 'package:fpdart/fpdart.dart';

import '../Error/failure.dart';

abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

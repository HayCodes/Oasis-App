import 'package:dartz/dartz.dart';

typedef AsyncEither<R> = Future<Either<String, R>>;

typedef AsyncEither2<L, R> = Future<Either<L, R>>;

typedef SyncEither<R> = Either<String, R>;

typedef DynamicMap = Map<String, dynamic>;

typedef AppConfig = ({String baseUrl});

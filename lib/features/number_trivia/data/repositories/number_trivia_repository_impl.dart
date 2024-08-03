import 'package:dartz/dartz.dart';
import 'package:tdd_demo/core/error/exceptions.dart';
import 'package:tdd_demo/core/error/failures.dart';
import 'package:tdd_demo/core/network/network_info.dart';
import 'package:tdd_demo/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_demo/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_demo/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_demo/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_demo/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia as NumberTrivia);
      } on ServerException {
        return const Left(ServerFailure('Error!'));
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia as NumberTrivia);
      } on CacheException {
        return const Left(CacheFailure('Error!'));
      }
    }
  }
}

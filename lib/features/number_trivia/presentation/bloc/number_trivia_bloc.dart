import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_demo/core/util/input_converter.dart';
import 'package:tdd_demo/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_demo/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_demo/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
    this.getConcreteNumberTrivia,
    this.getRandomNumberTrivia,
    this.inputConverter,
  ) : super(Empty()) {
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  void _onGetTriviaForConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) {
    // final inputEither =
    //     inputConverter.stringToUnsignedInteger(event.numberString);
    //
    // inputEither.fold(
    //   (failure) async* {
    //     yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
    //   },
    //   (integer) async* {
    //     yield Loading();
    //     final failureOrTrivia =
    //         await getConcreteNumberTrivia(Params(number: integer));
    //     yield* _eitherLoadedOrErrorState(failureOrTrivia);
    //   },
    // );
  }

  void _onGetTriviaForRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) {
    // yield Loading();
    // final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    // yield * _eitherLoadedOrErrorState(failureOrTrivia);
  }

  // Stream<NumberTriviaState> _eitherLoadedOrErrorState(
  //   Either<Failure, NumberTrivia> failureOrTrivia,
  // ) async* {
  //   yield failureOrTrivia.fold(
  //     (failure) => Error(message: _mapFailureToMessage(failure)),
  //     (trivia) => Loaded(trivia: trivia),
  //   );
  // }
  //
  // String _mapFailureToMessage(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case ServerFailure:
  //       return SERVER_FAILURE_MESSAGE;
  //     case CacheFailure:
  //       return CACHE_FAILURE_MESSAGE;
  //     default:
  //       return 'Unexpected error';
  //   }
  // }
}

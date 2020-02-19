import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_architect/core/util/input_converter.dart';
import 'package:flutter_architect/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_architect/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(this.getConcreteNumberTrivia, this.getRandomNumberTrivia, this.inputConverter);

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    // TODO: Add Logic
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architect/core/util/input_converter.dart';
import 'package:flutter_architect/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_architect/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    // TODO: Add Logic
  }
}

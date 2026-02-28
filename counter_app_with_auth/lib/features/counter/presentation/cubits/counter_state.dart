part of 'counter_cubit.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}

class CounterValue extends CounterState {
  final int value;
  
  CounterValue(this.value);

}

class CounterError extends CounterState{
  final String error;

  CounterError({required this.error});
}

class CounterLoading extends CounterState{}

class CounterLoaded extends CounterState{
  final int value;

  CounterLoaded(this.value);
}



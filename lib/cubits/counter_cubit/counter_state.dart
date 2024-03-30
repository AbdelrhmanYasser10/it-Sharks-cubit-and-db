part of 'counter_cubit.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}

//states
class IncrementedCounter extends CounterState{}
class DecrementedCounter extends CounterState{}
class MultiplyCounter extends CounterState{}
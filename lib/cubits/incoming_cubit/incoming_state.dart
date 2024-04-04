part of 'incoming_cubit.dart';

@immutable
sealed class IncomingState {}

final class IncomingInitial extends IncomingState {}


class IncomingDataLoading extends IncomingState{}

class IncomingDataSuccessfully extends IncomingState{
  final List<Incoming> data;
  IncomingDataSuccessfully({required this.data});
}

class IncomingDataError extends IncomingState{
  final String message;
  IncomingDataError({required this.message});
}
part of 'delete_cubit.dart';

@immutable
sealed class DeleteState {}

final class DeleteInitial extends DeleteState {}

class GetCodeFromDatabaseLoading extends DeleteState{}
class GetCodeFromDatabaseError extends DeleteState{
  final String message;
  GetCodeFromDatabaseError({required this.message});
}
//Successfully
class ThereIsNoCode extends DeleteState{}
class ThereIsCode extends DeleteState{}


class DeletedSuccessfully extends DeleteState{}
class DeletedError extends DeleteState{}
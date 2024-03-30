part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class GetDataLoading extends AppState{}
class GetDataSuccessfully extends AppState{
  final List<Stock> data;
  GetDataSuccessfully({required this.data});
}
class GetDataSuccessError extends AppState{
  final String message;
  GetDataSuccessError({required this.message});
}
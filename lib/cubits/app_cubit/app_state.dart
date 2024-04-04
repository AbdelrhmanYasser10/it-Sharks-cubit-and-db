part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class GetDataLoading extends AppState {}

class GetDataSuccessfully extends AppState {
  final List<Stock> data;
  GetDataSuccessfully({required this.data});
}

class GetDataSuccessError extends AppState {
  final String message;
  GetDataSuccessError({required this.message});
}

class GetNamesLoading extends AppState {}

class GetNamesSuccessfully extends AppState {
  final List<Stock> data;
  GetNamesSuccessfully({required this.data});
}

class GetNamesSuccessError extends AppState {
  final String message;
  GetNamesSuccessError({required this.message});
}

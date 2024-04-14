part of 'dismissed_cubit.dart';

@immutable
sealed class DismissedState {}

final class DismissedInitial extends DismissedState {}

class QRCodeNotFound extends DismissedState{}
class OverQuantity extends DismissedState{}
class SellingSuccessfully extends DismissedState{}

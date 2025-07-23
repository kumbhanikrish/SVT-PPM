part of 'kits_cubit.dart';

@immutable
sealed class KitsState {}

final class KitsInitial extends KitsState {}

final class GetKitsState extends KitsState {
  final Map<String, dynamic> kitData;

  GetKitsState({required this.kitData});
}

part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

sealed class StoreNumberState {}

final class StoreNumberInitial extends StoreNumberState {}

final class StoreNumberLoaded extends StoreNumberState {
  final String flag;
  final String code;
  StoreNumberLoaded(this.code, {required this.flag});
}

sealed class StoreWpNumberState {}

final class StoreWpNumberInitial extends StoreWpNumberState {}

final class StoreWpNumberLoaded extends StoreWpNumberState {
  final String flag;
  final String code;
  StoreWpNumberLoaded(this.code, {required this.flag});
}

// village state
sealed class VillageState {}

final class VillageInitial extends VillageState {}

final class VillageLoaded extends VillageState {
  final List<VillageModel> villageList;
  final String villageName;

  VillageLoaded({required this.villageList, required this.villageName});
}

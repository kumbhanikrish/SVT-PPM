part of 'role_schemes_registration_cubit.dart';

sealed class RoleSchemesRegistrationState {}

final class RoleSchemesRegistrationInitial
    extends RoleSchemesRegistrationState {}

final class SchemesRegistrationState extends RoleSchemesRegistrationState {
  final List<SchemesRegistrationModel> schemesRegistrationList;

  SchemesRegistrationState({required this.schemesRegistrationList});
}

final class SchemesRegistrationChangeStatusSuccessState
    extends RoleSchemesRegistrationState {}

final class SchemesRegistrationChangeStatusSuccessFiledState
    extends RoleSchemesRegistrationState {}

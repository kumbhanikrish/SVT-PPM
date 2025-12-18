part of 'role_schemas_registration_cubit.dart';

sealed class RoleSchemasRegistrationState {}

final class RoleSchemasRegistrationInitial
    extends RoleSchemasRegistrationState {}

final class SchemasRegistrationState extends RoleSchemasRegistrationState {
  final List<SchemasRegistrationModel> schemasRegistrationList;

  SchemasRegistrationState({required this.schemasRegistrationList});
}

final class SchemasRegistrationChangeStatusSuccessState
    extends RoleSchemasRegistrationState {}

final class SchemasRegistrationChangeStatusSuccessFiledState
    extends RoleSchemasRegistrationState {}

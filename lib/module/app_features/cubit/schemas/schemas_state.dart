part of 'schemas_cubit.dart';

@immutable
sealed class SchemasState {}

final class SchemasInitial extends SchemasState {}

final class GetSchemasState extends SchemasState {
  final List<SchemasModel> schemasModel;

  GetSchemasState({required this.schemasModel});
}

part of 'schemas_cubit.dart';

@immutable
sealed class SchemasState {}

final class SchemasInitial extends SchemasState {}

final class GetSchemasState extends SchemasState {
  final List<SchemasModel> schemasModel;
  final List<VillagePresidentModel> villagePresidentList;

  GetSchemasState({
    required this.schemasModel,
    required this.villagePresidentList,
  });
}

@immutable
sealed class MemberSelectState {}

final class MemberSelectInitial extends MemberSelectState {}

class MemberSelectionChanged extends MemberSelectState {
  final Set<int> selectedMemberIds;
  MemberSelectionChanged(this.selectedMemberIds);
}

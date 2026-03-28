part of 'schemes_cubit.dart';

@immutable
sealed class SchemesState {}

final class SchemesInitial extends SchemesState {}

final class GetSchemesState extends SchemesState {
  final List<SchemesModel> schemesModel;
  final List<VillagePresidentModel> villagePresidentList;

  GetSchemesState({
    required this.schemesModel,
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

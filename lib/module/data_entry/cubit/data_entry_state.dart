part of 'data_entry_cubit.dart';

@immutable
sealed class DataEntryState {}

final class DataEntryInitial extends DataEntryState {}

final class DataEntryLoaded extends DataEntryState {
  final int totalMember;

  DataEntryLoaded({required this.totalMember});
}

sealed class ChangeBorder2State {}

final class ChangeBorder2Initial extends ChangeBorder2State {}

final class ChangeBorder2Loaded extends ChangeBorder2State {
  final String changeLetters;

  ChangeBorder2Loaded({required this.changeLetters});
}

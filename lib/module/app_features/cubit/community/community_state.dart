part of 'community_cubit.dart';

@immutable
sealed class CommunityState {}

final class CommunityInitial extends CommunityState {}

final class GetCommunityMembersState extends CommunityState {
  final Map<String,dynamic> communityMembersModel;

  GetCommunityMembersState({required this.communityMembersModel});
}

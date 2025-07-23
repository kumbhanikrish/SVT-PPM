part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetHomeState extends HomeState {
  final HomeModel homeModel;
  final List<LoginModel> noOfMemberList;

  GetHomeState({required this.homeModel, required this.noOfMemberList});
}

part of 'benefit_cubit.dart';

@immutable
abstract class BenefitState {}

class BenefitInitial extends BenefitState {}

class BenefitLoading extends BenefitState {}

class GetBenefitState extends BenefitState {
  final Map<String, dynamic> benefitData;
  GetBenefitState({required this.benefitData});
}

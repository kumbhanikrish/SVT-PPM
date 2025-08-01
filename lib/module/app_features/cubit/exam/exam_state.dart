part of 'exam_cubit.dart';

@immutable
sealed class ExamState {}

final class ExamInitial extends ExamState {}

final class GetExamState extends ExamState {
  final Map<String, dynamic> examData;

  GetExamState({required this.examData});
}

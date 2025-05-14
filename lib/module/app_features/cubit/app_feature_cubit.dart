import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_feature_state.dart';

class AppFeatureCubit extends Cubit<AppFeatureState> {
  AppFeatureCubit() : super(AppFeatureInitial());
}

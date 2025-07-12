import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_setting_project_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_state.dart';

class SettingProjectBloc
    extends Bloc<SettingProjectEvent, SettingProjectState> {
  final GetSettingProjectUseCase getSettingProjectUseCase;

  SettingProjectBloc({required this.getSettingProjectUseCase})
    : super(SettingProjectInitial()) {
    on<GetSetting>(_onGetSetting);
  }

  Future<void> _onGetSetting(
    GetSetting event,
    Emitter<SettingProjectState> emit,
  ) async {
    emit(SettingProjectLoading());
    try {
      final setting = await getSettingProjectUseCase.execute(event.id);
      emit(SettingProjectLoaded(setting: setting));
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }
}

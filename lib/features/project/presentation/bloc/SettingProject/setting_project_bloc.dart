import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/project/data/models/setting_model.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_setting_project_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_state.dart';

class SettingProjectBloc
    extends Bloc<SettingProjectEvent, SettingProjectState> {
  final GetSettingProjectUseCase getSettingProjectUseCase;

  SettingProjectBloc({required this.getSettingProjectUseCase})
    : super(SettingProjectInitial()) {
    on<GetSetting>(_onGetSetting);
    on<ChangePrice>(_onChangePrice);
    on<ChangeCoin>(_onChangeCoin);
  }

  Future<void> _onGetSetting(
    GetSetting event,
    Emitter<SettingProjectState> emit,
  ) async {
    emit(SettingProjectLoading());
    try {
      final setting = await getSettingProjectUseCase.execute(event.id);
      emit(SettingProjectLoaded(setting: setting, update: false));
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }

  void _onChangePrice(
    ChangePrice event,
    Emitter<SettingProjectState> emit,
  ) async {
    final currentState = state as SettingProjectLoaded;
    try {
      final newData = SettingModel(
        id: currentState.setting.id,
        bill: currentState.setting.bill,
        price: event.price,
        coin: currentState.setting.coin,
        idProject: currentState.setting.idProject,
      );
      emit(SettingProjectLoaded(setting: newData, update: true));
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }

  void _onChangeCoin(
    ChangeCoin event,
    Emitter<SettingProjectState> emit,
  ) async {
    final currentState = state as SettingProjectLoaded;
    try {
      final newData = SettingModel(
        id: currentState.setting.id,
        bill: currentState.setting.bill,
        price: currentState.setting.price,
        coin: event.coin,
        idProject: currentState.setting.idProject,
      );
      emit(SettingProjectLoaded(setting: newData, update: true));
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }
}

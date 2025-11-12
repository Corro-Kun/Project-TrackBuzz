import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/project/data/models/setting_model.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_setting_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_state_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/update_setting_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_state.dart';

class SettingProjectBloc
    extends Bloc<SettingProjectEvent, SettingProjectState> {
  final GetSettingProjectUseCase getSettingProjectUseCase;
  final GetStateProjectUseCase getStateProjectUseCase;
  final UpdateSettingUseCase updateSettingUseCase;

  SettingProjectBloc({
    required this.getSettingProjectUseCase,
    required this.getStateProjectUseCase,
    required this.updateSettingUseCase,
  }) : super(SettingProjectInitial()) {
    on<GetSetting>(_onGetSetting);
    on<ChangeState>(_onChangeState);
    on<ChangeBill>(_onChangeBill);
    on<ChangeDescription>(_onChangeDescription);
    on<ChangePrice>(_onChangePrice);
    on<ChangeCoin>(_onChangeCoin);
    on<UpdateSetting>(_onUpdateSetting);
  }

  Future<void> _onGetSetting(
    GetSetting event,
    Emitter<SettingProjectState> emit,
  ) async {
    emit(SettingProjectLoading());
    try {
      final setting = await getSettingProjectUseCase.execute(event.id);
      final state = await getStateProjectUseCase.execute(event.id);

      emit(SettingProjectLoaded(setting: setting, state: state, update: false));
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }

  void _onChangeState(
    ChangeState event,
    Emitter<SettingProjectState> emit,
  ) async {
    final currentState = state as SettingProjectLoaded;
    try {
      emit(
        SettingProjectLoaded(
          setting: currentState.setting,
          state: event.state,
          update: true,
        ),
      );
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }

  void _onChangeBill(
    ChangeBill event,
    Emitter<SettingProjectState> emit,
  ) async {
    final currentState = state as SettingProjectLoaded;
    try {
      final newData = SettingModel(
        id: currentState.setting.id,
        bill: event.bill,
        description: currentState.setting.description,
        price: currentState.setting.price,
        coin: currentState.setting.coin,
        idProject: currentState.setting.idProject,
      );
      emit(
        SettingProjectLoaded(
          setting: newData,
          state: currentState.state,
          update: true,
        ),
      );
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }

  void _onChangeDescription(
    ChangeDescription event,
    Emitter<SettingProjectState> emit,
  ) async {
    final currentState = state as SettingProjectLoaded;
    try {
      final newData = SettingModel(
        id: currentState.setting.id,
        bill: currentState.setting.bill,
        description: event.description,
        price: currentState.setting.price,
        coin: currentState.setting.coin,
        idProject: currentState.setting.idProject,
      );
      emit(
        SettingProjectLoaded(
          setting: newData,
          state: currentState.state,
          update: true,
        ),
      );
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
        description: currentState.setting.description,
        price: event.price,
        coin: currentState.setting.coin,
        idProject: currentState.setting.idProject,
      );
      emit(
        SettingProjectLoaded(
          setting: newData,
          state: currentState.state,
          update: true,
        ),
      );
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
        description: currentState.setting.description,
        price: currentState.setting.price,
        coin: event.coin,
        idProject: currentState.setting.idProject,
      );
      emit(
        SettingProjectLoaded(
          setting: newData,
          state: currentState.state,
          update: true,
        ),
      );
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }

  Future<void> _onUpdateSetting(
    UpdateSetting event,
    Emitter<SettingProjectState> emit,
  ) async {
    final currentState = state as SettingProjectLoaded;
    try {
      await updateSettingUseCase.execute(
        currentState.setting,
        currentState.state,
      );
      emit(
        SettingProjectLoaded(
          setting: currentState.setting,
          state: currentState.state,
          update: false,
        ),
      );
    } catch (e) {
      emit(SettingProjectError(message: e.toString()));
    }
  }
}

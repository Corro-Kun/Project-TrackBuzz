import 'package:get_it/get_it.dart';
import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/data/datasource/record_datasource.dart';
import 'package:trackbuzz/features/project/data/datasource/setting_datasource.dart';
import 'package:trackbuzz/features/project/data/repositories/project_repository.dart';
import 'package:trackbuzz/features/project/data/repositories/record_repository.dart';
import 'package:trackbuzz/features/project/data/repositories/setting_repository.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';
import 'package:trackbuzz/features/project/data/services/record_service.dart';
import 'package:trackbuzz/features/project/data/services/setting_service.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/repositories/record_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/repositories/setting_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/usecase/create_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_list_project_user_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_record_of_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_setting_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/update_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/update_setting_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_bloc.dart';
import 'package:trackbuzz/features/track/data/datasource/chronometer_datasource.dart';
import 'package:trackbuzz/features/track/data/repositories/chronometer_repository.dart';
import 'package:trackbuzz/features/track/data/services/chronometer_service.dart';
import 'package:trackbuzz/features/track/data/services/project_chronometer_service.dart';
import 'package:trackbuzz/features/track/domain/repositories/chronometer_repositories_abstract.dart';
import 'package:trackbuzz/features/track/domain/usecase/get_current_record_use_case.dart';
import 'package:trackbuzz/features/track/domain/usecase/get_list_project_chronometer_use_case.dart';
import 'package:trackbuzz/features/track/domain/usecase/start_record_chronometer_use_case.dart';
import 'package:trackbuzz/features/track/domain/usecase/stop_record_chronometer_use_case.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_bloc.dart';
import 'package:trackbuzz/features/track/presentation/bloc/chronometer/chronometer_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ListProjectBloc(getListProject: sl()));
  sl.registerFactory(
    () => ProjectBloc(getProjectUseCase: sl(), updateProjectUseCase: sl()),
  );
  sl.registerFactory(
    () => SettingProjectBloc(
      getSettingProjectUseCase: sl(),
      updateSettingUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ProjectChronometerBloc(getListProjectChronometerUseCase: sl()),
  );
  sl.registerFactory(
    () => ChronometerBloc(
      getCurrentRecordUseCase: sl(),
      startRecordChronometerUseCase: sl(),
      stopRecordChronometerUseCase: sl(),
    ),
  );
  sl.registerFactory(() => RecordBloc(getRecordOfProjectUseCase: sl()));

  // User cases
  sl.registerLazySingleton(() => GetListProjectUserCase(sl()));
  sl.registerLazySingleton(() => CreateProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetSettingProjectUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSettingUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetListProjectChronometerUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentRecordUseCase(sl()));
  sl.registerLazySingleton(() => StartRecordChronometerUseCase(sl()));
  sl.registerLazySingleton(() => StopRecordChronometerUseCase(sl()));
  sl.registerLazySingleton(() => GetRecordOfProjectUseCase(sl()));

  // Services
  sl.registerLazySingleton(() => ProjectService(sl()));
  sl.registerLazySingleton(() => SettingService(sl()));
  sl.registerLazySingleton(() => ProjectChronometerService(sl()));
  sl.registerLazySingleton(() => ChronometerService(sl()));
  sl.registerLazySingleton(() => RecordService(sl()));

  // Repository
  sl.registerLazySingleton<ProjectRepositoryAbstract>(
    () => ProjectRepository(sl()),
  );
  sl.registerLazySingleton<SettingRepositoryAbstract>(
    () => SettingRepository(sl()),
  );
  sl.registerLazySingleton<ChronometerRepositoriesAbstract>(
    () => ChronometerRepository(sl()),
  );
  sl.registerLazySingleton<RecordRepositoryAbstract>(
    () => RecordRepository(sl()),
  );

  // Datasource
  sl.registerLazySingleton(() => ProjectDatasource());
  sl.registerLazySingleton(() => SettingDatasource());
  sl.registerLazySingleton(() => ChronometerDatasource());
  sl.registerLazySingleton(() => RecordDatasource());
}

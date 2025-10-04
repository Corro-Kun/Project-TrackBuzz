import 'package:get_it/get_it.dart';
import 'package:trackbuzz/features/project/data/datasource/activity_datasource.dart';
import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/data/datasource/record_datasource.dart';
import 'package:trackbuzz/features/project/data/datasource/setting_datasource.dart';
import 'package:trackbuzz/features/project/data/repositories/activity_repository.dart';
import 'package:trackbuzz/features/project/data/repositories/project_repository.dart';
import 'package:trackbuzz/features/project/data/repositories/record_repository.dart';
import 'package:trackbuzz/features/project/data/repositories/setting_repository.dart';
import 'package:trackbuzz/features/project/data/services/activity_service.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';
import 'package:trackbuzz/features/project/data/services/record_service.dart';
import 'package:trackbuzz/features/project/data/services/setting_service.dart';
import 'package:trackbuzz/features/project/domain/repositories/activity_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/repositories/record_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/repositories/setting_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/usecase/create_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/delete_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_activity_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_list_project_user_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_record_of_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_seconds_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_setting_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/update_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/update_setting_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_bloc.dart';
import 'package:trackbuzz/features/report/data/datasource/report_datasource.dart';
import 'package:trackbuzz/features/report/data/repositories/report_repositories.dart';
import 'package:trackbuzz/features/report/data/services/report_services.dart';
import 'package:trackbuzz/features/report/domain/repositories/report_repositories_abstract.dart';
import 'package:trackbuzz/features/report/domain/usecase/get_report_use_case.dart';
import 'package:trackbuzz/features/report/domain/usecase/get_total_report_use_case.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_bloc.dart';
import 'package:trackbuzz/features/task/data/datasource/task_datasource.dart';
import 'package:trackbuzz/features/task/data/repositories/task_repository.dart';
import 'package:trackbuzz/features/task/data/services/task_service.dart';
import 'package:trackbuzz/features/task/domain/repositories/task_repository_abstract.dart';
import 'package:trackbuzz/features/task/domain/usecase/create_task_use_case.dart';
import 'package:trackbuzz/features/task/domain/usecase/delete_task_use_case.dart';
import 'package:trackbuzz/features/task/domain/usecase/get_list_task_use_case.dart';
import 'package:trackbuzz/features/task/domain/usecase/update_task_use_case.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_bloc.dart';
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
    () => ProjectChronometerBloc(
      getListProjectChronometerUseCase: sl(),
      getListTaskUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ChronometerBloc(
      getCurrentRecordUseCase: sl(),
      startRecordChronometerUseCase: sl(),
      stopRecordChronometerUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => RecordBloc(
      getRecordOfProjectUseCase: sl(),
      getSecondsUseCase: sl(),
      getActivityUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ReportBloc(getReportUseCase: sl(), getTotalReportUseCase: sl()),
  );
  sl.registerFactory(
    () => TaskBloc(getListTaskUseCase: sl(), deleteTaskUseCase: sl()),
  );

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
  sl.registerLazySingleton(() => GetReportUseCase(sl()));
  sl.registerLazySingleton(() => GetTotalReportUseCase(sl()));
  sl.registerLazySingleton(() => GetSecondsUseCase(sl()));
  sl.registerLazySingleton(() => CreateTaskUseCase(sl()));
  sl.registerLazySingleton(() => GetListTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetActivityUseCase(sl()));

  // Services
  sl.registerLazySingleton(() => ProjectService(sl()));
  sl.registerLazySingleton(() => SettingService(sl()));
  sl.registerLazySingleton(() => ProjectChronometerService(sl()));
  sl.registerLazySingleton(() => ChronometerService(sl()));
  sl.registerLazySingleton(() => RecordService(sl()));
  sl.registerLazySingleton(() => ReportServices(sl()));
  sl.registerLazySingleton(() => TaskService(sl()));
  sl.registerLazySingleton(() => ActivityService(sl()));

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
  sl.registerLazySingleton<ReportRepositoriesAbstract>(
    () => ReportRepositories(sl()),
  );
  sl.registerLazySingleton<TaskRepositoryAbstract>(() => TaskRepository(sl()));
  sl.registerLazySingleton<ActivityRepositoryAbstract>(
    () => ActivityRepository(sl()),
  );

  // Datasource
  sl.registerLazySingleton(() => ProjectDatasource());
  sl.registerLazySingleton(() => SettingDatasource());
  sl.registerLazySingleton(() => ChronometerDatasource());
  sl.registerLazySingleton(() => RecordDatasource());
  sl.registerLazySingleton(() => ReportDatasource());
  sl.registerLazySingleton(() => TaskDatasource());
  sl.registerLazySingleton(() => ActivityDatasource());
}

import 'package:get_it/get_it.dart';
import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/data/datasource/setting_datasource.dart';
import 'package:trackbuzz/features/project/data/repositories/project_repository.dart';
import 'package:trackbuzz/features/project/data/repositories/setting_repository.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';
import 'package:trackbuzz/features/project/data/services/setting_service.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/repositories/setting_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/usecase/create_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_list_project_user_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_setting_project_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ListProjectBloc(getListProject: sl()));
  sl.registerFactory(() => ProjectBloc(getProjectUseCase: sl()));

  // User cases
  sl.registerLazySingleton(() => GetListProjectUserCase(sl()));
  sl.registerLazySingleton(() => CreateProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetSettingProjectUseCase(sl()));

  // Services
  sl.registerLazySingleton(() => ProjectService(sl()));
  sl.registerLazySingleton(() => SettingService(sl()));

  // Repository
  sl.registerLazySingleton<ProjectRepositoryAbstract>(
    () => ProjectRepository(sl()),
  );
  sl.registerLazySingleton<SettingRepositoryAbstract>(
    () => SettingRepository(sl()),
  );

  // Datasource
  sl.registerLazySingleton(() => ProjectDatasource());
  sl.registerLazySingleton(() => SettingDatasource());
}

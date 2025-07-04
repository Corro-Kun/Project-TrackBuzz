import 'package:get_it/get_it.dart';
import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/data/repositories/project_repository.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';
import 'package:trackbuzz/features/project/domain/usecase/create_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_list_project_user_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ListProjectBloc(getListProject: sl()));

  // User cases
  sl.registerLazySingleton(() => GetListProjectUserCase(sl()));
  sl.registerLazySingleton(() => CreateProjectUseCase(sl()));

  // Services
  sl.registerLazySingleton(() => ProjectService(sl()));

  // Repository
  sl.registerLazySingleton<ProjectRepositoryAbstract>(
    () => ProjectRepository(sl()),
  );

  // Datasource
  sl.registerLazySingleton(() => ProjectDatasource());
}

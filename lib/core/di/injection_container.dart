import 'package:get_it/get_it.dart';
import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/data/repositories/project_repository.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';
import 'package:trackbuzz/features/project/domain/usecase/create_project_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // User cases
  sl.registerLazySingleton(() => CreateProjectUseCase(sl()));

  // Services
  sl.registerLazySingleton(() => ProjectService(sl()));

  // Repository
  sl.registerLazySingleton(() => ProjectRepository(sl()));

  // Datasource
  sl.registerLazySingleton(() => ProjectDatasource());
}

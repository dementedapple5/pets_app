import 'package:get_it/get_it.dart';
import 'package:pets_app/data/local/db/database_helper.dart';
import 'package:pets_app/data/local/db/event_local_data_source.dart';
import 'package:pets_app/data/local/db/pet_local_data_source.dart';
import 'package:pets_app/data/local/repositories/event_repository_impl.dart';
import 'package:pets_app/data/local/repositories/pet_repository_impl.dart';
import 'package:pets_app/domain/repositories/event_repository.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/add_pet/add_pet_cubit.dart';
import 'package:pets_app/presentation/blocs/home/home_cubit.dart';

/// Service Locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
///
/// This function sets up the dependency injection container with all
/// necessary dependencies organized by layers:
/// - External (Database)
/// - Data Sources
/// - Repositories
/// - Cubits/BLoCs
Future<void> initializeDependencies() async {
  // ========================================
  // External Dependencies
  // ========================================

  // Database Helper - Singleton
  // We create a single instance that will be shared across the app
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Initialize database
  await sl<DatabaseHelper>().database;

  // ========================================
  // Data Sources
  // ========================================

  // Pet Data Source - Factory
  // Each time we request PetLocalDataSource, we get the same instance
  sl.registerLazySingleton<PetLocalDataSource>(() => PetLocalDataSourceImpl());

  // Event Data Source - Factory
  sl.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSourceImpl(),
  );

  // ========================================
  // Repositories
  // ========================================

  // Pet Repository - Singleton
  // Depends on PetLocalDataSource
  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(petDataSource: sl<PetLocalDataSource>()),
  );

  // Event Repository - Singleton
  // Depends on EventLocalDataSource
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(eventLocalDataSource: sl<EventLocalDataSource>()),
  );

  // ========================================
  // BLoCs / Cubits
  // ========================================

  // HomeCubit - Factory
  // We use factory because we want a fresh instance for each screen
  // Depends on PetRepository
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(petRepository: sl<PetRepository>()),
  );

  // AddPetCubit - Factory
  // Fresh instance each time we navigate to add pet screen
  // Depends on PetRepository
  sl.registerFactory<AddPetCubit>(
    () => AddPetCubit(petRepository: sl<PetRepository>()),
  );

  // Note: PetDetailsCubit is NOT registered here because it requires
  // a Pet parameter that changes per instance. It will be created
  // manually in the UI with injected repositories.
}

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await sl.reset();
}

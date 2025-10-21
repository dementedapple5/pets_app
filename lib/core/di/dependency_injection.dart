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
import 'package:pets_app/presentation/ui/utils/notification_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // ========================================
  // Services
  // ========================================

  sl.registerLazySingleton<NotificationService>(() => NotificationService());
  await sl<NotificationService>().initialize();

  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  await sl<DatabaseHelper>().database;

  // ========================================
  // Data Sources
  // ========================================

  sl.registerLazySingleton<PetLocalDataSource>(() => PetLocalDataSourceImpl());

  sl.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSourceImpl(),
  );

  // ========================================
  // Repositories
  // ========================================

  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(petDataSource: sl<PetLocalDataSource>()),
  );

  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(eventLocalDataSource: sl<EventLocalDataSource>()),
  );

  // ========================================
  // BLoCs / Cubits
  // ========================================

  sl.registerFactory<HomeCubit>(
    () => HomeCubit(petRepository: sl<PetRepository>()),
  );

  sl.registerFactory<AddPetCubit>(
    () => AddPetCubit(petRepository: sl<PetRepository>()),
  );
}

Future<void> resetDependencies() async {
  await sl.reset();
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pets_app/core/di/dependency_injection.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/add_pet/add_pet_cubit.dart';
import 'package:pets_app/presentation/blocs/home/home_cubit.dart';
import 'package:pets_app/presentation/ui/pages/add_pet_page.dart';
import 'package:pets_app/presentation/ui/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:pets_app/presentation/ui/pages/pet_details_page.dart';

/// Entry point of the application
///
/// Initializes all dependencies before running the app
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await initializeDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Pets App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('es', '')],
    );
  }
}

/// Router configuration
///
/// All routes use GetIt (sl) to inject dependencies into BLoC providers
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        // Get HomeCubit from DI container
        create: (context) => sl<HomeCubit>()..getPets(),
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/add-pet',
      builder: (context, state) => BlocProvider(
        // Get AddPetCubit from DI container
        create: (context) => sl<AddPetCubit>(),
        child: const AddPetPage(),
      ),
    ),
    GoRoute(
      path: '/pet-details',
      builder: (context, state) => PetDetailsPage(pet: state.extra as Pet),
    ),
  ],
);

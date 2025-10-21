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
import 'package:pets_app/presentation/ui/theme/app_theme.dart';
import 'package:pets_app/presentation/ui/utils/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  // Request notification permissions
  await sl<NotificationService>().requestPermissions();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Pets App',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
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

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => sl<HomeCubit>()..getPets(),
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/add-pet',
      builder: (context, state) => BlocProvider(
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

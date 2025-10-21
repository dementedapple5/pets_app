import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pets_app/presentation/blocs/home/home_cubit.dart';
import 'package:pets_app/presentation/blocs/home/home_state.dart';
import 'package:pets_app/presentation/ui/utils/image_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pets),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/add-pet').whenComplete(() {
                if (context.mounted) {
                  context.read<HomeCubit>().getPets();
                }
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.pets.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noPetsFound),
            );
          }
          return ListView.builder(
            itemCount: state.pets.length,
            itemBuilder: (context, index) {
              final pet = state.pets[index];
              return Column(
                children: [
                  ListTile(
                    leading: ImageUtils.getCircleAvatarImage(pet.imageUrl),
                    title: Text(
                      pet.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      pet.breed,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onTap: () {
                      context.push('/pet-details', extra: pet);
                    },
                  ),
                  Divider(
                    endIndent: 16,
                    indent: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

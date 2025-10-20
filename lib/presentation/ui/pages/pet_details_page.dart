import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/core/di/dependency_injection.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/event_repository.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_state.dart';
import 'package:pets_app/presentation/ui/utils/image_utils.dart';
import 'package:pets_app/presentation/ui/widgets/pet_details/edit_pet_bottom_sheet.dart';
import 'package:pets_app/presentation/ui/widgets/pet_details/add_event_bottom_sheet.dart';

class PetDetailsPage extends StatelessWidget {
  final Pet pet;
  const PetDetailsPage({super.key, required this.pet});

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void showEditPetBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => EditPetBottomSheet(pet: pet, petDetailsContext: context),
    );
  }

  void showDeletePetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.deletePet),
          content: Text(
            AppLocalizations.of(context)!.areYouSureDeletePet(pet.name),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<PetDetailsCubit>().deletePet();
              },
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    );
  }

  void showAddEventBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => AddEventBottomSheet(pet: pet, petDetailsContext: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetDetailsCubit(
        petRepository: sl<PetRepository>(),
        eventRepository: sl<EventRepository>(),
        pet: pet,
      )..getPetEvents(),
      child: BlocConsumer<PetDetailsCubit, PetDetailsState>(
        listener: (context, state) {
          if (state.isPetDeleted) {
            showSnackBar(
              context,
              AppLocalizations.of(context)!.petDeletedSuccessfully,
            );
            Navigator.of(context).pop();
          }
          if (state.isPetEdited) {
            showSnackBar(
              context,
              AppLocalizations.of(context)!.petEditedSuccessfully,
            );
          }
          if (state.isEventAdded) {
            showSnackBar(
              context,
              AppLocalizations.of(context)!.eventAddedSuccessfully,
            );
            context.read<PetDetailsCubit>().getPetEvents();
          }
          if (state.isEventUpdated) {
            showSnackBar(
              context,
              AppLocalizations.of(context)!.eventUpdatedSuccessfully,
            );
            Navigator.of(context).pop();
          }
          if (state.isEventDeleted) {
            showSnackBar(
              context,
              AppLocalizations.of(context)!.eventDeletedSuccessfully,
            );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.pet.name),
              actions: [
                IconButton(
                  onPressed: () {
                    showEditPetBottomSheet(context);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDeletePetDialog(context);
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    showAddEventBottomSheet(context);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            body: state.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.pet.imageUrl.isNotEmpty)
                          ImageUtils.getImageWidget(
                            imagePath: state.pet.imageUrl,
                            width: double.infinity,
                            height: 250,
                          )
                        else
                          Container(
                            width: double.infinity,
                            height: 250,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.pet.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildInfoRow(
                                AppLocalizations.of(context)!.species,
                                state.pet.species,
                              ),
                              _buildInfoRow(
                                AppLocalizations.of(context)!.breed,
                                state.pet.breed,
                              ),
                              _buildInfoRow(
                                AppLocalizations.of(context)!.gender,
                                state.pet.gender,
                              ),
                              _buildInfoRow(
                                AppLocalizations.of(context)!.age,
                                state.pet.age.toString(),
                              ),
                              _buildInfoRow(
                                AppLocalizations.of(context)!.weight,
                                state.pet.weight.toString(),
                              ),
                              SizedBox(height: 24),
                              Text(
                                AppLocalizations.of(context)!.events,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              if (state.events == null || state.events!.isEmpty)
                                Text(
                                  AppLocalizations.of(context)!.noEventsYet,
                                  style: TextStyle(color: Colors.grey),
                                )
                              else
                                ...state.events!.map(
                                  (event) => Column(
                                    children: [
                                      ListTile(
                                        title: Text(event.name),
                                        subtitle: Text(
                                          '${event.description}\n${formatDate(event.date)} - ${event.location}',
                                        ),
                                        isThreeLine: true,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}

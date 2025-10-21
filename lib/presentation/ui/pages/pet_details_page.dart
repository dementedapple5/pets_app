import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/core/di/dependency_injection.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/domain/repositories/event_repository.dart';
import 'package:pets_app/domain/repositories/pet_repository.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_state.dart';
import 'package:pets_app/presentation/ui/utils/image_utils.dart';
import 'package:pets_app/presentation/ui/utils/notification_service.dart';
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

  void showEditEventBottomSheet(BuildContext context, Event event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => AddEventBottomSheet(
        pet: pet,
        petDetailsContext: context,
        event: event,
      ),
    );
  }

  void showDeleteEventDialog(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(dialogContext)!.deleteEvent),
          content: Text(
            AppLocalizations.of(
              dialogContext,
            )!.areYouSureDeleteEvent(event.name),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(AppLocalizations.of(dialogContext)!.cancel),
            ),
            TextButton(
              onPressed: () {
                context.read<PetDetailsCubit>().deleteEvent(event.id);
              },
              child: Text(AppLocalizations.of(dialogContext)!.delete),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetDetailsCubit(
        petRepository: sl<PetRepository>(),
        eventRepository: sl<EventRepository>(),
        notificationService: sl<NotificationService>(),
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
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount: state.events!.length,
                                    itemExtent: 200,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final event = state.events![index];
                                      return _buildEventItem(context, event);
                                    },
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

  Widget _buildEventItem(BuildContext context, Event event) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month, color: theme.colorScheme.secondary),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  formatDateTime(event.date),
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    showEditEventBottomSheet(context, event);
                  } else if (value == 'delete') {
                    showDeleteEventDialog(context, event);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 16),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.edit),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.delete),
                      ],
                    ),
                  ),
                ],
                child: Icon(
                  Icons.more_vert,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          Text(
            event.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          if (event.description.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              event.description,
              style: TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (event.location.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              event.location,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
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

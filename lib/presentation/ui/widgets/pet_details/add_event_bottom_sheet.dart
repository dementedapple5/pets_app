import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/ui/widgets/shared/custom_textfield.dart';
import 'package:pets_app/presentation/ui/widgets/shared/primary_button.dart';
import 'package:pets_app/l10n/app_localizations.dart';

class AddEventBottomSheet extends StatefulWidget {
  final Pet pet;
  final BuildContext petDetailsContext;
  final Event? event; // null for add mode, Event for edit mode
  const AddEventBottomSheet({
    super.key,
    required this.pet,
    required this.petDetailsContext,
    this.event,
  });

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool notificationEnabled = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();

    // Pre-populate fields if editing an existing event
    if (widget.event != null) {
      nameController.text = widget.event!.name;
      descriptionController.text = widget.event!.description;
      locationController.text = widget.event!.location;
      selectedDate = widget.event!.date;
      selectedTime = TimeOfDay.fromDateTime(widget.event!.date);
      notificationEnabled = widget.event!.notificationEnabled;

      dateController.text = "${widget.event!.date.toLocal()}".split(' ')[0];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Set time text after context is available
    if (widget.event != null && selectedTime != null) {
      timeController.text = selectedTime!.format(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event == null
                    ? AppLocalizations.of(context)!.addEvent
                    : AppLocalizations.of(context)!.editEvent,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                labelText: AppLocalizations.of(context)!.eventName,
                hintText: AppLocalizations.of(context)!.eventNameHint,
                controller: nameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: AppLocalizations.of(context)!.description,
                hintText: AppLocalizations.of(context)!.eventDescriptionHint,
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 3,
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: AppLocalizations.of(context)!.date,
                hintText: AppLocalizations.of(context)!.selectDate,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: AppLocalizations.of(context)!.time,
                hintText: AppLocalizations.of(context)!.selectTime,
                controller: timeController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                readOnly: true,
                onTap: () => _selectTime(context),
                suffixIcon: Icon(Icons.access_time),
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: AppLocalizations.of(context)!.location,
                hintText: AppLocalizations.of(context)!.locationHint,
                controller: locationController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: notificationEnabled,
                    activeColor: theme.colorScheme.onSurface,
                    checkColor: theme.colorScheme.surface,
                    onChanged: (value) {
                      setState(() {
                        notificationEnabled = value ?? true;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.enableNotificationReminder,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      title: AppLocalizations.of(context)!.cancel,
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: theme.colorScheme.outline,
                      textColor: theme.colorScheme.surface,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      backgroundColor: theme.colorScheme.onSurface,
                      textColor: theme.colorScheme.surface,
                      title: widget.event == null
                          ? AppLocalizations.of(context)!.addEvent
                          : AppLocalizations.of(context)!.updateEvent,
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.pleaseEnterEventName,
                              ),
                            ),
                          );
                          return;
                        }
                        if (selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.pleaseSelectDate,
                              ),
                            ),
                          );
                          return;
                        }
                        if (selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.pleaseSelectTime,
                              ),
                            ),
                          );
                          return;
                        }

                        // Combine date and time
                        final eventDateTime = DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        );

                        if (widget.event == null) {
                          // Add new event
                          final newEvent = Event(
                            id: const Uuid().v4(),
                            name: nameController.text,
                            petId: widget.pet.id,
                            description: descriptionController.text,
                            date: eventDateTime,
                            location: locationController.text,
                            notificationEnabled: notificationEnabled,
                          );

                          widget.petDetailsContext
                              .read<PetDetailsCubit>()
                              .addEvent(newEvent);
                        } else {
                          // Update existing event
                          final updatedEvent = widget.event!.copyWith(
                            name: nameController.text,
                            description: descriptionController.text,
                            date: eventDateTime,
                            location: locationController.text,
                            notificationEnabled: notificationEnabled,
                          );

                          widget.petDetailsContext
                              .read<PetDetailsCubit>()
                              .updateEvent(updatedEvent);
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

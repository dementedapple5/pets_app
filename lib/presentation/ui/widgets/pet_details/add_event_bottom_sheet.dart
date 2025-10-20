import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:pets_app/domain/entities/event.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/ui/widgets/shared/custom_textfield.dart';
import 'package:pets_app/presentation/ui/widgets/shared/primary_button.dart';

class AddEventBottomSheet extends StatefulWidget {
  final Pet pet;
  final BuildContext petDetailsContext;
  const AddEventBottomSheet({
    super.key,
    required this.pet,
    required this.petDetailsContext,
  });

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController dateController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    dateController.dispose();
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

  @override
  Widget build(BuildContext context) {
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
                'Add Event',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              CustomTextField(
                labelText: 'Event Name',
                hintText: 'e.g., Veterinary Checkup',
                controller: nameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: 'Description',
                hintText: 'Enter event details',
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 3,
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: 'Date',
                hintText: 'Select a date',
                controller: dateController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: 'Location',
                hintText: 'e.g., Pet Clinic',
                controller: locationController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      title: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      title: 'Add Event',
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter event name')),
                          );
                          return;
                        }
                        if (selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a date')),
                          );
                          return;
                        }

                        final newEvent = Event(
                          id: const Uuid().v4(),
                          name: nameController.text,
                          petId: widget.pet.id,
                          description: descriptionController.text,
                          date: selectedDate!,
                          location: locationController.text,
                        );

                        widget.petDetailsContext
                            .read<PetDetailsCubit>()
                            .addEvent(newEvent);
                        context.pop();
                      },
                      backgroundColor: Colors.blue,
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

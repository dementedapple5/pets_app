import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/pet_details/pet_details_cubit.dart';
import 'package:pets_app/presentation/ui/widgets/shared/custom_textfield.dart';
import 'package:pets_app/presentation/ui/widgets/shared/primary_button.dart';

class EditPetBottomSheet extends StatefulWidget {
  final Pet pet;
  final BuildContext petDetailsContext;

  const EditPetBottomSheet({
    super.key,
    required this.pet,
    required this.petDetailsContext,
  });

  @override
  State<EditPetBottomSheet> createState() => _EditPetBottomSheetState();
}

class _EditPetBottomSheetState extends State<EditPetBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController breedController;
  late TextEditingController ageController;
  late TextEditingController weightController;
  late String selectedGender;

  final List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.pet.name);
    breedController = TextEditingController(text: widget.pet.breed);
    ageController = TextEditingController(text: widget.pet.age.toString());
    weightController = TextEditingController(
      text: widget.pet.weight.toString(),
    );
    selectedGender = widget.pet.gender;
  }

  @override
  void dispose() {
    nameController.dispose();
    breedController.dispose();
    ageController.dispose();
    weightController.dispose();
    super.dispose();
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
                'Edit Pet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              CustomTextField(
                labelText: 'Name',
                hintText: 'Enter pet name',
                controller: nameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: 'Breed',
                hintText: 'Enter pet breed',
                controller: breedController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: genders.map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedGender = value;
                    });
                  }
                },
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: 'Age',
                hintText: 'Enter age in years',
                controller: ageController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12),
              CustomTextField(
                labelText: 'Weight',
                hintText: 'Enter weight in kg',
                controller: weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      title: 'Cancel',
                      backgroundColor: Colors.black26,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      title: 'Save',
                      onPressed: () {
                        final updatedPet = Pet(
                          id: widget.pet.id,
                          name: nameController.text,
                          breed: breedController.text,
                          species: widget.pet.species,
                          gender: selectedGender,
                          age:
                              int.tryParse(ageController.text) ??
                              widget.pet.age,
                          weight:
                              double.tryParse(weightController.text) ??
                              widget.pet.weight,
                          imageUrl: widget.pet.imageUrl,
                        );
                        widget.petDetailsContext
                            .read<PetDetailsCubit>()
                            .editPet(updatedPet);
                        Navigator.pop(context);
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

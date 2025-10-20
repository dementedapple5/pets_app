import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:pets_app/domain/entities/pet.dart';
import 'package:pets_app/presentation/blocs/add_pet/add_pet_cubit.dart';
import 'package:pets_app/presentation/blocs/add_pet/add_pet_state.dart';
import 'package:pets_app/presentation/ui/utils/image_picker_helper.dart';
import 'package:pets_app/presentation/ui/widgets/shared/custom_textfield.dart';
import 'package:pets_app/presentation/ui/widgets/shared/primary_button.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _speciesController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String _selectedGender = 'Male';
  String? _selectedImagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _speciesController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectImageSource),
        content: Text(AppLocalizations.of(context)!.chooseHowToAddImage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImageFromCamera();
            },
            child: Text(AppLocalizations.of(context)!.camera),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImageFromGallery();
            },
            child: Text(AppLocalizations.of(context)!.gallery),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final imagePath = await ImagePickerHelper.pickImageFromCamera();
    if (imagePath != null) {
      setState(() {
        _selectedImagePath = imagePath;
        _imageUrlController.clear();
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final imagePath = await ImagePickerHelper.pickImageFromGallery();
    if (imagePath != null) {
      setState(() {
        _selectedImagePath = imagePath;
        _imageUrlController.clear();
      });
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedImagePath == null && _imageUrlController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.pleaseSelectImageOrUrl),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final imagePath = _selectedImagePath ?? _imageUrlController.text;

      final pet = Pet(
        id: const Uuid().v4(),
        name: _nameController.text,
        breed: _breedController.text,
        species: _speciesController.text,
        gender: _selectedGender,
        age: int.parse(_ageController.text),
        weight: double.parse(_weightController.text),
        imageUrl: imagePath,
      );
      context.read<AddPetCubit>().addPet(pet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addPet),
        centerTitle: true,
      ),
      body: BlocListener<AddPetCubit, AddPetState>(
        listener: (context, state) {
          if (state.pet != null && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.petAddedSuccessfully,
                ),
              ),
            );
            Navigator.of(context).pop();
          } else if (state.errorMessage != null && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Selection
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      if (_selectedImagePath != null)
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(_selectedImagePath!)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 200,
                          color: Colors.black12,
                          child: const Center(
                            child: Icon(Icons.image, size: 50),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PrimaryButton(
                              onPressed: _showImagePickerDialog,
                              title: _selectedImagePath != null
                                  ? AppLocalizations.of(context)!.changeImage
                                  : AppLocalizations.of(context)!.selectImage,
                            ),
                            if (_selectedImagePath != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  AppLocalizations.of(context)!.imageSelected,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Pet Name
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.petName,
                  hintText: AppLocalizations.of(context)!.enterPetName,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterPetName;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Species
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.species,
                  hintText: AppLocalizations.of(context)!.speciesHint,
                  controller: _speciesController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterSpecies;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Breed
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.breed,
                  hintText: AppLocalizations.of(context)!.enterBreed,
                  controller: _breedController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterBreed;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedGender,
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.gender,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text(AppLocalizations.of(context)!.male),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text(AppLocalizations.of(context)!.female),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value ?? 'Male';
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Age
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.ageYears,
                  hintText: AppLocalizations.of(context)!.enterAgeInYears,
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterAge;
                    }
                    if (int.tryParse(value) == null) {
                      return AppLocalizations.of(
                        context,
                      )!.pleaseEnterValidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Weight
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.weightKg,
                  hintText: AppLocalizations.of(context)!.enterWeightInKg,
                  controller: _weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterWeight;
                    }
                    if (double.tryParse(value) == null) {
                      return AppLocalizations.of(
                        context,
                      )!.pleaseEnterValidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Submit Button
                BlocBuilder<AddPetCubit, AddPetState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      title: AppLocalizations.of(context)!.addPet,
                      onPressed: state.isLoading
                          ? null
                          : () => _submitForm(context),
                      isLoading: state.isLoading,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

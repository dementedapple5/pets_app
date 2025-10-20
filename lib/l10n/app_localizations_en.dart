// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pets App';

  @override
  String get pets => 'Pets';

  @override
  String get addPet => 'Add Pet';

  @override
  String get noPetsFound => 'No pets found';

  @override
  String get petName => 'Pet Name';

  @override
  String get enterPetName => 'Enter pet name';

  @override
  String get pleaseEnterPetName => 'Please enter pet name';

  @override
  String get species => 'Species';

  @override
  String get speciesHint => 'e.g., Dog, Cat, Bird';

  @override
  String get pleaseEnterSpecies => 'Please enter species';

  @override
  String get breed => 'Breed';

  @override
  String get enterBreed => 'Enter breed';

  @override
  String get pleaseEnterBreed => 'Please enter breed';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get age => 'Age';

  @override
  String get ageYears => 'Age (years)';

  @override
  String get enterAgeInYears => 'Enter age in years';

  @override
  String get pleaseEnterAge => 'Please enter age';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get weight => 'Weight';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get enterWeightInKg => 'Enter weight in kg';

  @override
  String get pleaseEnterWeight => 'Please enter weight';

  @override
  String get selectImage => 'Select Image';

  @override
  String get changeImage => 'Change Image';

  @override
  String get imageSelected => 'Image selected';

  @override
  String get selectImageSource => 'Select Image Source';

  @override
  String get chooseHowToAddImage => 'Choose how you want to add an image';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get pleaseSelectImageOrUrl =>
      'Please select an image or enter an image URL';

  @override
  String get petAddedSuccessfully => 'Pet added successfully';

  @override
  String get petEditedSuccessfully => 'Pet edited successfully';

  @override
  String get petDeletedSuccessfully => 'Pet deleted successfully';

  @override
  String get deletePet => 'Delete Pet';

  @override
  String areYouSureDeletePet(String petName) {
    return 'Are you sure you want to delete $petName?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get events => 'Events';

  @override
  String get noEventsYet => 'No events yet';

  @override
  String get eventAddedSuccessfully => 'Event added successfully';

  @override
  String get eventUpdatedSuccessfully => 'Event updated successfully';

  @override
  String get eventDeletedSuccessfully => 'Event deleted successfully';
}

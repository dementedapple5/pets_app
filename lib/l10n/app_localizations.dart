import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Pets App'**
  String get appTitle;

  /// Title for the pets list page
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get pets;

  /// Title for the add pet page
  ///
  /// In en, this message translates to:
  /// **'Add Pet'**
  String get addPet;

  /// Message shown when no pets are found
  ///
  /// In en, this message translates to:
  /// **'No pets found'**
  String get noPetsFound;

  /// Label for pet name field
  ///
  /// In en, this message translates to:
  /// **'Pet Name'**
  String get petName;

  /// Hint text for pet name field
  ///
  /// In en, this message translates to:
  /// **'Enter pet name'**
  String get enterPetName;

  /// Validation message for pet name field
  ///
  /// In en, this message translates to:
  /// **'Please enter pet name'**
  String get pleaseEnterPetName;

  /// Label for species field
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get species;

  /// Hint text for species field
  ///
  /// In en, this message translates to:
  /// **'e.g., Dog, Cat, Bird'**
  String get speciesHint;

  /// Validation message for species field
  ///
  /// In en, this message translates to:
  /// **'Please enter species'**
  String get pleaseEnterSpecies;

  /// Label for breed field
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get breed;

  /// Hint text for breed field
  ///
  /// In en, this message translates to:
  /// **'Enter breed'**
  String get enterBreed;

  /// Validation message for breed field
  ///
  /// In en, this message translates to:
  /// **'Please enter breed'**
  String get pleaseEnterBreed;

  /// Label for gender field
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Label for age field
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// Label for age field with unit
  ///
  /// In en, this message translates to:
  /// **'Age (years)'**
  String get ageYears;

  /// Hint text for age field
  ///
  /// In en, this message translates to:
  /// **'Enter age in years'**
  String get enterAgeInYears;

  /// Validation message for age field
  ///
  /// In en, this message translates to:
  /// **'Please enter age'**
  String get pleaseEnterAge;

  /// Validation message for numeric fields
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// Label for weight field
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Label for weight field with unit
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKg;

  /// Hint text for weight field
  ///
  /// In en, this message translates to:
  /// **'Enter weight in kg'**
  String get enterWeightInKg;

  /// Validation message for weight field
  ///
  /// In en, this message translates to:
  /// **'Please enter weight'**
  String get pleaseEnterWeight;

  /// Button text to select an image
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// Button text to change an image
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// Text shown when an image is selected
  ///
  /// In en, this message translates to:
  /// **'Image selected'**
  String get imageSelected;

  /// Title for image source selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Image Source'**
  String get selectImageSource;

  /// Content for image source selection dialog
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to add an image'**
  String get chooseHowToAddImage;

  /// Camera option for image selection
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Gallery option for image selection
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Validation message for image selection
  ///
  /// In en, this message translates to:
  /// **'Please select an image or enter an image URL'**
  String get pleaseSelectImageOrUrl;

  /// Success message when pet is added
  ///
  /// In en, this message translates to:
  /// **'Pet added successfully'**
  String get petAddedSuccessfully;

  /// Success message when pet is edited
  ///
  /// In en, this message translates to:
  /// **'Pet edited successfully'**
  String get petEditedSuccessfully;

  /// Success message when pet is deleted
  ///
  /// In en, this message translates to:
  /// **'Pet deleted successfully'**
  String get petDeletedSuccessfully;

  /// Title for delete pet dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Pet'**
  String get deletePet;

  /// Confirmation message for deleting a pet
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {petName}?'**
  String areYouSureDeletePet(String petName);

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Title for events section
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// Message shown when no events exist
  ///
  /// In en, this message translates to:
  /// **'No events yet'**
  String get noEventsYet;

  /// Success message when event is added
  ///
  /// In en, this message translates to:
  /// **'Event added successfully'**
  String get eventAddedSuccessfully;

  /// Success message when event is updated
  ///
  /// In en, this message translates to:
  /// **'Event updated successfully'**
  String get eventUpdatedSuccessfully;

  /// Success message when event is deleted
  ///
  /// In en, this message translates to:
  /// **'Event deleted successfully'**
  String get eventDeletedSuccessfully;

  /// Title for add event form
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get addEvent;

  /// Label for event name field
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get eventName;

  /// Hint text for event name field
  ///
  /// In en, this message translates to:
  /// **'e.g., Veterinary Checkup'**
  String get eventNameHint;

  /// Label for description field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Hint text for event description field
  ///
  /// In en, this message translates to:
  /// **'Enter event details'**
  String get eventDescriptionHint;

  /// Label for date field
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Hint text for date selection
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectDate;

  /// Label for time field
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Hint text for time selection
  ///
  /// In en, this message translates to:
  /// **'Select a time'**
  String get selectTime;

  /// Label for location field
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Hint text for location field
  ///
  /// In en, this message translates to:
  /// **'e.g., Pet Clinic'**
  String get locationHint;

  /// Label for notification toggle
  ///
  /// In en, this message translates to:
  /// **'Enable notification reminder'**
  String get enableNotificationReminder;

  /// Validation message for event name
  ///
  /// In en, this message translates to:
  /// **'Please enter event name'**
  String get pleaseEnterEventName;

  /// Validation message for date
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get pleaseSelectDate;

  /// Validation message for time
  ///
  /// In en, this message translates to:
  /// **'Please select a time'**
  String get pleaseSelectTime;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'App de Mascotas';

  @override
  String get pets => 'Mascotas';

  @override
  String get addPet => 'Agregar Mascota';

  @override
  String get noPetsFound => 'No se encontraron mascotas';

  @override
  String get petName => 'Nombre de la Mascota';

  @override
  String get enterPetName => 'Ingrese el nombre de la mascota';

  @override
  String get pleaseEnterPetName => 'Por favor ingrese el nombre de la mascota';

  @override
  String get species => 'Especie';

  @override
  String get speciesHint => 'ej., Perro, Gato, Ave';

  @override
  String get pleaseEnterSpecies => 'Por favor ingrese la especie';

  @override
  String get breed => 'Raza';

  @override
  String get enterBreed => 'Ingrese la raza';

  @override
  String get pleaseEnterBreed => 'Por favor ingrese la raza';

  @override
  String get gender => 'Género';

  @override
  String get male => 'Macho';

  @override
  String get female => 'Hembra';

  @override
  String get age => 'Edad';

  @override
  String get ageYears => 'Edad (años)';

  @override
  String get enterAgeInYears => 'Ingrese la edad en años';

  @override
  String get pleaseEnterAge => 'Por favor ingrese la edad';

  @override
  String get pleaseEnterValidNumber => 'Por favor ingrese un número válido';

  @override
  String get weight => 'Peso';

  @override
  String get weightKg => 'Peso (kg)';

  @override
  String get enterWeightInKg => 'Ingrese el peso en kg';

  @override
  String get pleaseEnterWeight => 'Por favor ingrese el peso';

  @override
  String get selectImage => 'Seleccionar Imagen';

  @override
  String get changeImage => 'Cambiar Imagen';

  @override
  String get imageSelected => 'Imagen seleccionada';

  @override
  String get selectImageSource => 'Seleccionar Fuente de Imagen';

  @override
  String get chooseHowToAddImage => 'Elija cómo desea agregar una imagen';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get pleaseSelectImageOrUrl =>
      'Por favor seleccione una imagen o ingrese una URL de imagen';

  @override
  String get petAddedSuccessfully => 'Mascota agregada exitosamente';

  @override
  String get petEditedSuccessfully => 'Mascota editada exitosamente';

  @override
  String get petDeletedSuccessfully => 'Mascota eliminada exitosamente';

  @override
  String get deletePet => 'Eliminar Mascota';

  @override
  String areYouSureDeletePet(String petName) {
    return '¿Está seguro de que desea eliminar $petName?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get events => 'Eventos';

  @override
  String get noEventsYet => 'Aún no hay eventos';

  @override
  String get eventAddedSuccessfully => 'Evento agregado exitosamente';

  @override
  String get eventUpdatedSuccessfully => 'Evento actualizado exitosamente';

  @override
  String get eventDeletedSuccessfully => 'Evento eliminado exitosamente';

  @override
  String get addEvent => 'Agregar Evento';

  @override
  String get eventName => 'Nombre del Evento';

  @override
  String get eventNameHint => 'ej., Chequeo Veterinario';

  @override
  String get description => 'Descripción';

  @override
  String get eventDescriptionHint => 'Ingrese los detalles del evento';

  @override
  String get date => 'Fecha';

  @override
  String get selectDate => 'Seleccione una fecha';

  @override
  String get time => 'Hora';

  @override
  String get selectTime => 'Seleccione una hora';

  @override
  String get location => 'Ubicación';

  @override
  String get locationHint => 'ej., Clínica Veterinaria';

  @override
  String get enableNotificationReminder =>
      'Habilitar recordatorio de notificación';

  @override
  String get pleaseEnterEventName => 'Por favor ingrese el nombre del evento';

  @override
  String get pleaseSelectDate => 'Por favor seleccione una fecha';

  @override
  String get pleaseSelectTime => 'Por favor seleccione una hora';
}

## pets_app

### a) Descripción general del proyecto
Aplicación Flutter para gestionar mascotas y sus eventos (vacunas, visitas al veterinario, recordatorios, fotos, etc.). Pensada para uso local en el dispositivo, con una interfaz simple y traducciones en español/inglés.

### b) Decisiones técnicas y justificación
- **Flutter + Dart**: una sola base de código para iOS/Android con rendimiento nativo.
- **Arquitectura por capas (Clean)**: `data` / `domain` / `presentation` separan responsabilidades y facilitan pruebas y evolución.
- **BLoC para estado**: estados predecibles y fáciles de testear; la carpeta `presentation/blocs` concentra la lógica de UI.
- **Persistencia local**: `sqflite` para datos estructurados y `shared_preferences` para preferencias simples; `path_provider` para rutas del sistema.
- **Multimedia**: `image_picker` para adjuntar imágenes al crear mascotas.
- **i18n**: `flutter_localizations` con archivos `.arb` en `lib/l10n` para mantener las cadenas de forma ordenada.

### c) Arquitectura (breve esquema)
``` 
lib/
  core/
    di/               // inyección de dependencias
  data/
    local/            // fuentes de datos locales (DAO/adapters)
  domain/
    entities/         // modelos de dominio
    repositories/     // contratos de repositorios
  presentation/
    blocs/            // lógica de presentación (BLoC)
    ui/               // pantallas y widgets
  l10n/               // localización (ARB + clases generadas)
  main.dart           // punto de entrada
```

### d) Instrucciones de ejecución
Requisitos: Flutter instalado y toolchains de iOS/Android configurados.

```bash
flutter --version
flutter pub get

# (iOS, primera vez)
cd ios && pod install && cd ..

# Ejecutar en dispositivo/emulador
flutter run

# Pruebas
flutter test
```


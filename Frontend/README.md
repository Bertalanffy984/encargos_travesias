# Travecias (Frontend)

Aplicación **Flutter / Dart** — encomiendas en la comunidad **Travecias** (Redes Comunitarias · Universidad de la Amazonia · Ingeniería de Sistemas).

**Flujo:**
- Alguien **solicita**: texto + fotos + origen/destino + pago → publica.
- Otro **acepta** o hace **contraoferta**.
- **Actividad** muestra avisos tipo “Carlos aceptó tu encomienda · 17 sep 2026”.

Este repositorio deja el **frontend preparado** para que otro integrante conecte el **backend**, **MySQL** y las rutas REST reales.

Prompt para rehacer mockups en Figma: `docs/FIGMA_PROMPT_TRAVECIAS.md`.

## Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart 3.3+)
- Editor (VS Code / Android Studio)

## Primera vez en el equipo

Si aún no existen carpetas `android/`, `ios/`, `web/`, etc., genera el proyecto Flutter **sin borrar** `lib/`:

```bash
cd d:\proyectos_programacion\Redes2
flutter create . --project-name entrecomunidad --org com.redescomunitarias
flutter pub get
```

Copia variables de entorno:

```bash
copy .env.example .env
```

Edita `.env` con la URL del backend cuando esté lista:

```env
API_BASE_URL=http://localhost:3000/api
```

## Logos oficiales

Coloca los PNG **oficiales** (no inventar ni usar iconos genéricos) en:

```
assets/images/
  logo_universidad.png
  logo_sistemas.png
  logo_redes_comunitarias.png
  logo_entrecomunidad.png
```

Respetar la proporción original de cada imagen.

## Guía de estilos (resumen)

| Elemento | Valor |
|----------|--------|
| Verde Amazonia | `#007A33` |
| Rojo institucional | `#E20613` |
| Azul Sistemas | `#0085CA` |
| Fondo | `#F8F9FA` |
| Texto | `#212529` |
| Títulos | Montserrat 600–700 |
| Cuerpo / botones | Roboto 400 / 500 |

Tema central: `lib/core/theme/`. Componentes reutilizables: `lib/shared/widgets/`.

## Backend (para el compañero)

- Configuración: `lib/core/config/api_config.dart` y `.env`
- Cliente HTTP base: `lib/core/network/api_client.dart`
- Endpoints placeholder: `ApiEndpoints` en `api_config.dart`
- Prueba rápida en la app: botón **Probar /health** en la pantalla de inicio

Implementar en el servidor un `GET /health` (o ajustar la ruta en `ApiEndpoints`) y actualizar el contrato de API cuando exista.

## Ejecutar

```bash
flutter run
```

### Windows: error de symlinks / plugins

Si aparece:

`Building with plugins requires symlink support`

1. **Recomendado:** activar **Modo de desarrollador**  
   `start ms-settings:developers` → activar *Modo de desarrollador* → cerrar y abrir la terminal → `flutter run -d windows`.

2. **Alternativa:** abrir PowerShell **como administrador** y ejecutar `flutter run -d windows` (permite crear symlinks sin modo desarrollador).

3. **Sin instalar nada más:** ejecutar en navegador (no requiere symlinks):

   ```bash
   flutter run -d chrome
   ```

## Estructura

```
lib/
  core/          # tema, colores, API, red
  features/      # pantallas por módulo (splash, home, …)
  shared/        # widgets institucionales
assets/images/   # logos
```

Los diseños de alta fidelidad en **Figma** se integrarán sobre esta base sin cambiar la identidad institucional.

## Referencias de estética (GitHub, Material 3)

Patrones adaptados (no copia literal) desde repos públicos:

- [flutter-showcase-app](https://github.com/momentous-developments/flutter-showcase-app) — tema M3, radios, inputs
- [Social-Mate-Flutter-App](https://github.com/AmrSalahDev/Social-Mate-Flutter-App) — feed, composer, barra con botón central
- [Cronicle](https://github.com/Sevaaru/Cronicle) — rail de filtros y discover
- [lap-fitness](https://github.com/iurman/lap-fitness) — feed social en Flutter + M3

UI actual: composer, filtros, feed, explorar en grid, barra inferior con crear, colores institucionales.

# Integración backend y MySQL

El frontend **no** incluye servidor ni acceso directo a MySQL. La integración es vía **API REST** (o GraphQL, si el equipo lo define).

## Pasos sugeridos

1. Levantar el backend con las rutas acordadas (auth, usuarios, comunidades, etc.).
2. Exponer `GET /api/health` (o cambiar `ApiEndpoints.health` en `lib/core/config/api_config.dart`).
3. Configurar en el frontend `.env`:

   ```env
   API_BASE_URL=https://tu-servidor/api
   ```

4. Ampliar `ApiClient` con token JWT en headers cuando exista login.
5. Crear servicios en `lib/features/<modulo>/data/` que llamen a `ApiClient` y modelos Dart desde JSON.

6. **Probar API sin ensuciar la UI:** en la app, Perfil → tocar 7 veces `EntreComunidad v0.1.0` → hoja de desarrollo con `/health`.

## CORS y plataformas

- **Web**: el backend debe permitir el origen del front.
- **Android emulador**: `localhost` del PC suele ser `10.0.2.2`.
- **Dispositivo físico**: usar IP LAN del servidor, no `localhost`.

## Contrato de API

Documentar en este repo (OpenAPI/Postman) cuando esté definido. Actualizar `ApiEndpoints` para que coincida con las rutas reales.

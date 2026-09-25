# Estrategia de automatización

## Alcance
API de usuarios de ServeRest: listado, alta, consulta por ID, modificación y eliminación.

## Pirámide / nivel
Las pruebas están en nivel API/servicio. Buscan feedback rápido, determinista y sin dependencia de UI.

## Patrones
- Configuración centralizada.
- Factory para test data.
- Helpers reutilizables.
- Contract/schema validation.
- Arrange / Act / Assert implícito en cada escenario.
- Create → exercise → verify → cleanup.
- Tags para suites selectivas.

## Riesgos controlados
- Colisión de emails: UUID.
- Dependencia de datos existentes: creación dinámica.
- Basura de pruebas: cleanup.
- Contratos inconsistentes: esquemas JSON reutilizables.
- Diagnóstico lento: features separados por endpoint.

## Casos
Positivos: CRUD completo y persistencia.
Negativos: ID inexistente, email duplicado, formato inválido y conflicto al actualizar.

## Mejoras posibles
- Tests data-driven adicionales.
- Validación contra OpenAPI.
- Retry controlado para fallas transitorias.
- Publicación de reportes en CI.
- Integración con Allure / Xray si el equipo lo requiere.

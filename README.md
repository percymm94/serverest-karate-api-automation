# ServeRest - Karate API Automation

Suite automatizada para el reto Backend de la API de Usuarios de ServeRest.

## Objetivo

Validar las operaciones CRUD de `/usuarios` con escenarios positivos, negativos, validación de contratos JSON, datos dinámicos y limpieza de datos.

## Stack

- Java 17+
- Maven 3.9+
- Karate DSL 2.0.0
- JUnit 6 integration / JUnit Platform
- ServeRest: https://serverest.dev

## Estructura

```text
src/test/java
├── karate-config.js
├── runners
│   └── UsersTest.java
├── features/users
│   ├── get-users.feature
│   ├── post-user.feature
│   ├── get-user-by-id.feature
│   ├── put-user.feature
│   └── delete-user.feature
├── helpers/users
│   ├── create-user.feature
│   └── delete-user.feature
├── data
│   └── user-factory.js
└── schemas
    ├── user-schema.json
    └── users-list-schema.json
```

## Pre-requisitos

```bash
java -version
mvn -version
```

Se recomienda JDK 17 o superior.

## Ejecución

Toda la regresión:

```bash
mvn clean test
```

Smoke:

```bash
mvn clean test "-Dkarate.options=--tags @smoke"
```

Regresión:

```bash
mvn clean test "-Dkarate.options=--tags @regression"
```

Solo positivos:

```bash
mvn clean test "-Dkarate.options=--tags @positive"
```

Solo negativos:

```bash
mvn clean test "-Dkarate.options=--tags @negative"
```

Ambiente QA:

```bash
mvn clean test "-Dkarate.env=qa"
```

En PowerShell se recomienda mantener entre comillas los argumentos `-D...`.

## Reporte

Al terminar, abrir:

```text
target/karate-reports/karate-summary.html
```

## Estrategia de automatización

La suite se organiza por recurso y endpoint. Cada operación CRUD tiene su feature independiente para facilitar mantenimiento, ejecución selectiva y diagnóstico.

Principios utilizados:

1. **Independencia:** los tests que necesitan un usuario crean sus propios datos.
2. **Datos dinámicos:** el correo usa UUID para evitar colisiones.
3. **Cleanup:** los escenarios que crean usuarios eliminan sus datos al finalizar.
4. **Reutilización:** creación/eliminación técnica se encapsula en `helpers`.
5. **Contrato:** los objetos de usuario se validan contra esquemas reutilizables.
6. **Validaciones funcionales:** se comprueban status HTTP, mensajes, IDs y persistencia.
7. **Positivos y negativos:** se cubren CRUD válido, ID inexistente, email duplicado y payload inválido.
8. **Tags:** `@smoke`, `@regression`, `@positive`, `@negative`, más tags por verbo HTTP.

## Cobertura

| Operación | Positivo | Negativo / borde |
|---|---|---|
| GET /usuarios | Lista + contrato | N/A |
| POST /usuarios | Alta válida | Email duplicado, email inválido |
| GET /usuarios/{id} | Consulta existente | ID inexistente |
| PUT /usuarios/{id} | Actualización existente | Email en uso |
| DELETE /usuarios/{id} | Eliminación | ID inexistente |

## Decisiones de diseño

No se usan IDs fijos porque ServeRest es un entorno compartido. Los datos se generan en runtime y los escenarios verifican el estado final del recurso cuando aporta valor.

`karate-config.js` centraliza URL, timeouts y ambiente. `user-factory.js` centraliza la generación de payloads. Los JSON de `schemas` evitan duplicar contratos.

## CI/CD

La suite queda preparada para integrarse con GitHub Actions ejecutando `mvn clean test`. Como mejora adicional se puede publicar `target/karate-reports` como artifact del pipeline.

## Publicar en GitHub

```bash
git init
git add .
git commit -m "feat: add ServeRest Karate API automation challenge"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/serverest-karate-api-automation.git
git push -u origin main
```

Reemplaza `TU_USUARIO` por tu usuario de GitHub.

SIGNAL v0.1 — Alcance mínimo (MVP)

Objetivo principal:

Crear una aplicación de escritorio ligera que funcione como diario personal con estética retro sci-fi y que ocasionalmente genere eventos misteriosos.

Si una funcionalidad no ayuda directamente a esa frase, sale del MVP.

Funcionalidades obligatorias
1. Crear entradas de journal

El usuario puede:

- crear una entrada
- editar una entrada
- eliminar una entrada
- guardar automáticamente

Estructura:

Date: 16 MAY 2026

Hoy vi una película y me dieron ganas de crear algo.
2. Persistencia local

Guardar localmente:

entradas
señales
configuración

Tecnología:

SQLite

o:

SQLite + JSON
3. Timeline

Mostrar historial cronológico:

16 MAY

Entry created

14 MAY

Entry created

13 MAY

Signal detected
4. Pantalla de señales

Mostrar anomalías recibidas:

TRANSMISSION #001

"...we remember..."
5. Sistema básico de anomalías

Reglas simples:

baja probabilidad al abrir la app
baja probabilidad al crear una entrada
mensajes predefinidos

Ejemplo:

UNKNOWN SIGNAL DETECTED

No:

❌ IA
❌ análisis semántico
❌ aprendizaje

Solo eventos simples.

6. Experiencia visual mínima

Obligatorio:

tema oscuro
tipografía monoespaciada
efecto CRT suave
animaciones pequeñas
sonidos al escribir

No obligatorio:

❌ lluvia
❌ shaders complejos
❌ partículas

7. Sonido

Solo:

sonido suave al escribir
sonido glitch/anomalía
sonido ambiente opcional
Estructura de pantallas
Home
SIGNAL ARCHIVE

STATUS: ACTIVE
UNREAD SIGNALS: 2

> Journal
> Timeline
> Signals
Journal

Editor principal.

Timeline

Historial.

Signals

Lista de anomalías.

Settings
volumen
activar/desactivar CRT
activar/desactivar sonidos
Fuera del MVP

Estas ideas existen, pero quedan explícitamente fuera:

Integraciones

❌ Letterboxd
❌ Obsidian
❌ Google Drive
❌ Discord

IA

❌ generación inteligente
❌ análisis de recuerdos
❌ interpretación automática

Historia compleja

❌ narrativa oculta grande
❌ finales múltiples

Efectos avanzados

❌ lluvia
❌ partículas
❌ shaders pesados
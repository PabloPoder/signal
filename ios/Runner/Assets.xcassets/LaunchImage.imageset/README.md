# Launch Screen Assets

You can customize the launch screen with your own desired assets by replacing the image files in this directory.

You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.


MainPanelWidget
 └── TerminalDispatcher
      ├── MenuHandler
      ├── EntryHandler
      ├── ChronologyHandler
      └── ...

# Qué debería saber cada handler
Por ejemplo:

ChronologyHandler

Debería saber:

qué comandos existen,
cómo parsearlos,
cómo validarlos,
qué acciones ejecutar.

NO debería saber:

widgets,
animaciones,
flex,
colores,
TextEditingController.

1. ParsedCommand

MUY importante.

2. TerminalResponse

CRÍTICO.

3. Section Handlers

El salto arquitectónico más grande.

4. Command Dispatcher

Después.

5. Separar parser de executor

Cuando agregues más complejidad.


---

Orden sano para vos
PASO 1

Crear:

ParsedCommand
TerminalResponse

Nada más.

PASO 2

Extraer:

_handleEntryCommands()
_handleChronologyCommands()

aunque sigan dentro del widget.

PASO 3

Mover esos handlers fuera del widget.

PASO 4

Introducir dispatcher.
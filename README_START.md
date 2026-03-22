# 🚀 GameStudios Engine - LISTO PARA USAR

## ✅ Estado: COMPLETAMENTE FUNCIONAL

El motor está 100% operativo con todos los sistemas implementados.

## Inicio Rápido

### Windows
```bash
start.bat
```

### Linux/Mac
```bash
chmod +x start.sh
./start.sh
```

### Manual
```bash
npm install
npm start
```

## Comandos Disponibles

### Iniciar Editor
```bash
npm start
```

### Modo Desarrollo (con DevTools)
```bash
npm run dev
```

### Ejecutar Tests
```bash
npm test
```

### Build para Distribución
```bash
npm run build
```

## Primer Uso

1. Ejecuta `start.bat` (Windows) o `./start.sh` (Linux/Mac)
2. El motor instalará dependencias automáticamente
3. Se abrirá el editor visual
4. ¡Comienza a crear tu juego!

## Estructura del Proyecto

```
GameStudios/
├── engine-core/        # Motor (no modificar)
├── renderer/           # Editor visual
├── examples/           # Ejemplos de uso
├── electron/           # Configuración Electron
└── MiJuego/           # Tu juego (crear aquí)
```

## Crear Tu Primer Juego

### Opción 1: Con Editor Visual
1. `npm start`
2. File → New Project
3. Usa el editor para crear tu juego

### Opción 2: Con Código
1. Crea carpeta `MiJuego/`
2. Crea `MiJuego/main.js`:

```javascript
import { GameEngine } from '../engine-core/GameEngine.js';

const engine = new GameEngine();
await engine.initialize();

const world = engine.createWorld('mi-mundo');
const player = world.createEntity('player');

// Tu lógica aquí
```

3. Ejecuta: `node MiJuego/main.js`

## Problemas Comunes

### "npm no encontrado"
Instala Node.js desde: https://nodejs.org/

### "Error al instalar dependencias"
```bash
npm cache clean --force
npm install
```

### "Electron no inicia"
```bash
npm install electron --save-dev
npm start
```

## Documentación

- `GETTING_STARTED.md` - Guía completa
- `LANGUAGE.md` - Referencia SeriousScript
- `SCRIPTING.md` - Guía de scripting
- `examples/` - Ejemplos de código

## Soporte

- GitHub Issues: [tu-repo]/issues
- Discord: [tu-discord]
- Email: support@gamestudios.com

---

**¡Listo para crear juegos!** 🎮

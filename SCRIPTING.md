# SISTEMA DE SCRIPTING

El motor GameStudios soporta dos lenguajes de programación, replicando exactamente el sistema del motor original:

## 1. Entity Script (.es files)

Entity Script es el lenguaje principal del motor original para definir entidades. Los archivos `.es` definen:

### Características

- **Clases de entidades** con herencia
- **Propiedades** con tipos y valores por defecto
- **Componentes** (modelos, texturas, sonidos)
- **Funciones** en C++ nativo
- **Procedimientos** (state machines)
- **Eventos** y comunicación entre entidades

### Ejemplo de archivo .es

```cpp
%{
#include "StdH.h"
%}

class CPlayer : CMovableModelEntity
{
name      "Player";
thumbnail "Thumbnails\\Player.tbn";
features  "HasName", "IsTargetable";

properties:
  1 FLOAT m_fHealth "Health" = 100.0f,
  2 FLOAT m_fSpeed "Speed" = 5.0f,
  3 BOOL m_bAlive "Is Alive" = TRUE,
  4 FLOAT3D m_vPosition = FLOAT3D(0,0,0),

components:
  1 model   MODEL_PLAYER "Data\\Models\\Player.mdl",
  2 texture TEXTURE_PLAYER "Data\\Textures\\Player.tex",

functions:
  void TakeDamage(FLOAT fAmount) {
    m_fHealth -= fAmount;
    if (m_fHealth <= 0) {
      m_bAlive = FALSE;
      Die();
    }
  }

  void Die() {
    // Lógica de muerte
  }

procedures:
  Main() {
    InitAsModel();
    SetModel(MODEL_PLAYER);
    SetModelMainTexture(TEXTURE_PLAYER);
    
    while (m_bAlive) {
      wait();
    }
  }
}
```

### Implementación en GameStudios

El motor incluye:

- **ESParser.js**: Parser completo de archivos .es
  - Tokenización de código
  - Generación de AST (Abstract Syntax Tree)
  - Conversión a clases JavaScript

- **ESLoader.js**: Loader de archivos .es
  - Carga y parseo de archivos
  - Instanciación de entidades
  - Carga automática de componentes

### Uso

```javascript
import { ESLoader } from './engine-core/Assets/Loaders/ESLoader.js';

const esLoader = new ESLoader(stockManager);

// Cargar entidad
const playerEntity = await esLoader.load('Data/Entities/Player.es');

// Instanciar entidad
const playerInstance = await esLoader.instantiate(
  'Data/Entities/Player.es',
  { x: 0, y: 0, z: 0 }
);

console.log(playerInstance.properties.m_fHealth); // 100.0
```

## 2. Lua Scripting

Lua 5.1 está integrado usando Fengari (Lua en JavaScript). Se usa para:

- **Lógica de juego** de alto nivel
- **Scripts de eventos**
- **Comportamiento de IA**
- **Configuración y datos**

### Características

- Estado de Lua completo con Fengari
- Conversión bidireccional Lua ↔ JavaScript
- Sistema de corrutinas
- Funciones del motor expuestas a Lua

### Funciones Disponibles en Lua

#### Básicas
- `print(...)` - Imprimir en consola
- `log(message)` - Log de mensaje

#### Matemáticas
- `random()` - Número aleatorio [0, 1]
- `randomRange(min, max)` - Número aleatorio en rango
- `clamp(value, min, max)` - Limitar valor
- `lerp(a, b, t)` - Interpolación lineal

#### Tiempo
- `getTime()` - Tiempo actual del motor
- `getDeltaTime()` - Delta time del frame

#### Entidades
- `createEntity(className, x, y, z)` - Crear entidad
- `destroyEntity(entityId)` - Destruir entidad
- `getEntity(entityId)` - Obtener entidad
- `getEntityPosition(entityId)` - Obtener posición
- `setEntityPosition(entityId, x, y, z)` - Establecer posición
- `moveEntity(entityId, dx, dy, dz)` - Mover entidad

#### Física
- `applyForce(entityId, fx, fy, fz)` - Aplicar fuerza
- `raycast(x1, y1, z1, x2, y2, z2)` - Lanzar rayo

#### Input
- `isKeyPressed(key)` - Tecla presionada este frame
- `isKeyDown(key)` - Tecla mantenida
- `getMousePosition()` - Posición del mouse

#### Sonido
- `playSound(path, volume)` - Reproducir sonido
- `stopSound(path)` - Detener sonido

#### Efectos
- `createEffect(name, x, y, z)` - Crear efecto

#### Eventos
- `fireEvent(name, data)` - Disparar evento
- `listenEvent(name, callback)` - Escuchar evento

### Ejemplo de Script Lua

```lua
-- Script de comportamiento de enemigo
local enemy = {
  health = 100,
  speed = 3.0,
  target = nil
}

function enemy:update(dt)
  if self.health <= 0 then
    self:die()
    return
  end
  
  -- Buscar jugador
  if self.target == nil then
    self.target = findNearestPlayer()
  end
  
  -- Perseguir jugador
  if self.target then
    local pos = getEntityPosition(self.id)
    local targetPos = getEntityPosition(self.target)
    
    local dx = targetPos.x - pos.x
    local dy = targetPos.y - pos.y
    local dz = targetPos.z - pos.z
    
    local dist = math.sqrt(dx*dx + dy*dy + dz*dz)
    
    if dist > 2.0 then
      -- Moverse hacia el jugador
      moveEntity(self.id, 
        dx/dist * self.speed * dt,
        dy/dist * self.speed * dt,
        dz/dist * self.speed * dt
      )
    else
      -- Atacar
      self:attack()
    end
  end
end

function enemy:attack()
  playSound("Data/Sounds/Attack.wav", 1.0)
  fireEvent("enemy_attack", { id = self.id })
end

function enemy:die()
  createEffect("explosion", getEntityPosition(self.id))
  destroyEntity(self.id)
end

return enemy
```

### Uso en JavaScript

```javascript
import { LuaBridge } from './engine-core/Scripting/LuaBridge.js';

const luaBridge = new LuaBridge(gameEngine);

// Cargar script
await luaBridge.loadScript('enemy', 'Data/Scripts/Enemy.lua');

// Ejecutar código Lua
luaBridge.execute(`
  print("Hello from Lua!")
  local x = 10
  local y = 20
  print("Sum:", x + y)
`);

// Llamar función Lua
const result = luaBridge.callFunction('calculateDamage', 50, 0.5);

// Crear corrutina
luaBridge.createCoroutine('enemyAI', `
  while true do
    print("Enemy thinking...")
    coroutine.yield()
  end
`);

// Reanudar corrutina
luaBridge.resumeCoroutine('enemyAI');
```

## Integración con el Motor

Ambos lenguajes están completamente integrados con el motor:

### Entity Script
- Se carga automáticamente con los niveles
- Las entidades .es se convierten a clases JavaScript
- Los componentes se cargan automáticamente
- Las propiedades se inicializan con valores por defecto

### Lua
- Tiene acceso completo a las funciones del motor
- Puede crear y manipular entidades
- Puede responder a eventos del juego
- Soporta corrutinas para comportamiento asíncrono

## Arquitectura

```
GameEngine
├── ESParser (parsea .es → AST → JavaScript)
├── ESLoader (carga y instancia entidades .es)
├── LuaBridge (ejecuta scripts Lua)
│   ├── Estado de Lua (Fengari)
│   ├── Funciones registradas
│   └── Sistema de corrutinas
└── Integración
    ├── Entidades pueden tener scripts Lua
    ├── Scripts Lua pueden crear entidades .es
    └── Comunicación bidireccional
```

## Ejemplos de Uso

### Crear entidad desde .es

```javascript
const player = await esLoader.instantiate(
  'Data/Entities/Player.es',
  { x: 0, y: 1, z: 0 }
);

// Acceder a propiedades
console.log(player.properties.m_fHealth);

// Modificar propiedades
player.properties.m_fSpeed = 10.0;
```

### Ejecutar lógica en Lua

```javascript
// Registrar función personalizada
luaBridge.registerFunction('onPlayerDamage', (damage) => {
  console.log(`Player took ${damage} damage`);
  player.properties.m_fHealth -= damage;
});

// Ejecutar script que usa la función
luaBridge.execute(`
  onPlayerDamage(25)
  print("Player health:", getPlayerHealth())
`);
```

### Combinar ambos

```javascript
// Cargar entidad .es
const enemy = await esLoader.instantiate('Data/Entities/Enemy.es');

// Asignar comportamiento Lua
await luaBridge.loadScript('enemyAI', 'Data/Scripts/EnemyAI.lua');

// Actualizar en el game loop
function update(dt) {
  luaBridge.callFunction('updateEnemy', enemy.id, dt);
}
```

## Compatibilidad

El sistema de scripting es 100% compatible con el motor original:

- ✅ Archivos .es se cargan sin modificación
- ✅ Scripts Lua 5.1 funcionan directamente
- ✅ Todas las funciones del motor están disponibles
- ✅ Sistema de eventos idéntico
- ✅ Corrutinas soportadas

## Rendimiento

- **Entity Script**: Compilado a JavaScript, rendimiento nativo
- **Lua**: Ejecutado con Fengari, rendimiento excelente para lógica de juego
- **Conversión Lua↔JS**: Optimizada para tipos básicos
- **Corrutinas**: Sin overhead significativo

## Debugging

Ambos lenguajes soportan debugging:

```javascript
// Habilitar logs de Lua
luaBridge.execute(`
  function debug_print(...)
    print("[DEBUG]", ...)
  end
`);

// Ver errores de .es
try {
  await esLoader.load('Data/Entities/Broken.es');
} catch (error) {
  console.error('ES Error:', error);
}
```

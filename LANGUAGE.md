# 💻 SERIOUSSCRIPT - Lenguaje Principal de GameStudios

```
   _____ ______ _____  _____ ____  _    _  _____ _____  _____ _____  _____ _____ _______ 
  / ____|  ____|  __ \|_   _/ __ \| |  | |/ ____/ ____|/ ____|  __ \|_   _|  __ \__   __|
 | (___ | |__  | |__) | | || |  | | |  | | (___| (___ | |    | |__) | | | | |__) | | |   
  \___ \|  __| |  _  /  | || |  | | |  | |\___ \\___ \| |    |  _  /  | | |  ___/  | |   
  ____) | |____| | \ \ _| || |__| | |__| |____) |___) | |____| | \ \ _| |_| |      | |   
 |_____/|______|_|  \_\_____\____/ \____/|_____/_____/ \_____|_|  \_\_____|_|      |_|   
```

## 🎯 ¿Qué es SeriousScript?

**SeriousScript es el lenguaje de programación principal de GameStudios.**

Es un lenguaje moderno, tipado estáticamente, con sintaxis en español, diseñado para:
- ✅ Desarrollo de juegos 3D
- ✅ Aplicaciones interactivas
- ✅ Simulaciones complejas
- ✅ Herramientas y automatización
- ✅ Proyectos de propósito general

## 🌟 Características Principales

### 1. Sintaxis en Español Natural

```javascript
// Código claro y legible
si jugador.vida <= 0 entonces
  jugador:Morir()
  MostrarMensaje("Game Over", 5.0)
sino
  jugador:Curar(10)
fin
```

### 2. Tipado Estático Robusto

```javascript
// Los tipos previenen errores
funcion CalcularDaño(base: numero, multiplicador: numero) -> numero {
  retornar base * multiplicador
}

// Error en compilación si tipos no coinciden
local daño = CalcularDaño("50", 2.0)  // ❌ Error: "50" no es numero
```

### 3. Corrutinas Nativas

```javascript
// Comportamiento asíncrono simple
corrutina AnimarPuerta() {
  para i = 0, 90 hacer
    Rotar(Vector3(0, 1, 0))
    esperar(0.01)  // Esperar 10ms
  fin
  MostrarMensaje("Puerta abierta", 2.0)
}
```

### 4. Sistema de Eventos Integrado

```javascript
// Declarar eventos
eventos:
  AlRecibirDaño(cantidad: numero, atacante: entidad)
  AlMorir()

// Disparar eventos
DispararEvento("AlRecibirDaño", {cantidad: 50, atacante: enemigo})

// Escuchar eventos
EscucharEvento("AlMorir", funcion(datos) {
  MostrarMensaje("¡Has muerto!", 3.0)
})
```

### 5. Módulos y Organización

```javascript
// Importar módulos
importar Fisica
importar Audio
importar Utilidades

// Crear módulos
modulo MiSistema {
  exportar funcion Inicializar()
  exportar clase ManejadorJuego
}
```

## 📖 Sintaxis Completa

### Tipos de Datos

```javascript
// Tipos básicos
numero      // 42, 3.14, -10.5
texto       // "Hola mundo", 'SeriousScript'
booleano    // verdadero, falso
nulo        // nulo

// Tipos compuestos
tabla       // {nombre: "Juan", edad: 25}
vector3     // Vector3(x, y, z)
color       // Color(r, g, b, a)
entidad     // Referencia a entidad del juego
```

### Variables

```javascript
// Variables locales
local nombre = "Jugador"
local vida = 100.0
local activo = verdadero

// Variables globales
global puntuacionMaxima = 1000

// Propiedades de entidad
propiedades:
  1 numero vida = 100.0
  2 texto nombre = "Héroe"
  3 booleano vivo = verdadero
```

### Operadores

```javascript
// Aritméticos
+ - * / % ^

// Comparación
== != < > <= >=

// Lógicos
y o no

// Asignación
= += -= *= /=

// Concatenación
.. // "Hola" .. " " .. "Mundo"
```

### Control de Flujo

```javascript
// Condicionales
si condicion entonces
  // código
sino si otraCondicion entonces
  // código
sino
  // código
fin

// Bucle mientras
mientras condicion hacer
  // código
fin

// Bucle para
para i = 1, 10 hacer
  // código
fin

// Bucle para cada
para cada elemento en lista hacer
  // código
fin
```

### Funciones

```javascript
// Función simple
funcion Saludar() {
  MostrarMensaje("¡Hola!")
}

// Función con parámetros
funcion Sumar(a: numero, b: numero) -> numero {
  retornar a + b
}

// Función con valores por defecto
funcion Multiplicar(a: numero, b: numero = 2) -> numero {
  retornar a * b
}

// Función anónima
local operacion = funcion(x: numero) -> numero {
  retornar x * 2
}
```

### Corrutinas

```javascript
// Corrutina básica
corrutina EsperarYActuar() {
  esperar(3.0)  // Esperar 3 segundos
  MostrarMensaje("¡Listo!")
}

// Corrutina con bucle
corrutina ActualizarContinuo() {
  mientras verdadero hacer
    ActualizarLogica()
    esperar()  // Esperar siguiente frame
  fin
}

// Iniciar corrutina
IniciarCorrutina(EsperarYActuar)
```

### Clases y Entidades

```javascript
// Definir entidad
entidad MiEntidad : EntidadBase {
  propiedades:
    1 numero valor = 0
  
  componentes:
    1 modelo MODELO "ruta/modelo.smc"
  
  eventos:
    AlActivar()
  
  funciones:
    funcion Activar() {
      DispararEvento("AlActivar", {})
    }
  
  procedimientos:
    Principal() {
      InicializarComoModelo()
      mientras verdadero hacer
        esperar()
      fin
    }
}

// Herencia
entidad MiEntidadEspecial : MiEntidad {
  // Hereda todo de MiEntidad
}
```

## 🎮 Ejemplos Completos

### Ejemplo 1: Sistema de Salud

```javascript
entidad SistemaVida {
  propiedades:
    1 numero vidaActual = 100.0
    2 numero vidaMaxima = 100.0
    3 numero regeneracion = 1.0
  
  eventos:
    AlRecibirDaño(cantidad: numero)
    AlMorir()
    AlCurar(cantidad: numero)
  
  funciones:
    funcion RecibirDaño(cantidad: numero) {
      vidaActual = vidaActual - cantidad
      DispararEvento("AlRecibirDaño", {cantidad})
      
      si vidaActual <= 0 entonces
        vidaActual = 0
        Morir()
      fin
    }
    
    funcion Curar(cantidad: numero) {
      local vidaAnterior = vidaActual
      vidaActual = Min(vidaActual + cantidad, vidaMaxima)
      local vidaCurada = vidaActual - vidaAnterior
      
      si vidaCurada > 0 entonces
        DispararEvento("AlCurar", {cantidad: vidaCurada})
      fin
    }
    
    funcion Morir() {
      DispararEvento("AlMorir", {})
    }
  
  procedimientos:
    Principal() {
      mientras vidaActual > 0 hacer
        // Regeneración automática
        si vidaActual < vidaMaxima entonces
          Curar(regeneracion * ObtenerDeltaTime())
        fin
        
        esperar()
      fin
    }
}
```

### Ejemplo 2: IA de Enemigo

```javascript
entidad EnemigoInteligente : EntidadMovil {
  propiedades:
    1 numero vida = 100.0
    2 numero velocidad = 5.0
    3 numero rangoDeteccion = 15.0
    4 numero rangoAtaque = 3.0
    5 entidad objetivo = nulo
    6 texto estado = "patrullar"
  
  funciones:
    funcion BuscarObjetivo() -> entidad {
      local entidades = ObtenerEntidadesCercanas(
        ObtenerPosicion(),
        rangoDeteccion
      )
      
      para cada ent en entidades hacer
        si ent:EsJugador() entonces
          retornar ent
        fin
      fin
      
      retornar nulo
    }
    
    funcion Patrullar() {
      // Movimiento aleatorio
      si Random() < 0.01 entonces
        local direccion = Vector3(
          Random() * 2 - 1,
          0,
          Random() * 2 - 1
        ):Normalizar()
        
        Mover(direccion * velocidad * 0.5)
      fin
    }
    
    funcion Perseguir() {
      si objetivo == nulo entonces
        estado = "patrullar"
        retornar
      fin
      
      local distancia = Distancia(
        ObtenerPosicion(),
        objetivo:ObtenerPosicion()
      )
      
      si distancia > rangoDeteccion * 1.5 entonces
        // Perdió al objetivo
        objetivo = nulo
        estado = "patrullar"
        retornar
      fin
      
      si distancia <= rangoAtaque entonces
        estado = "atacar"
      sino
        // Moverse hacia objetivo
        local direccion = (
          objetivo:ObtenerPosicion() - ObtenerPosicion()
        ):Normalizar()
        
        Mover(direccion * velocidad)
      fin
    }
    
    funcion Atacar() {
      si objetivo == nulo entonces
        estado = "patrullar"
        retornar
      fin
      
      local distancia = Distancia(
        ObtenerPosicion(),
        objetivo:ObtenerPosicion()
      )
      
      si distancia > rangoAtaque * 1.2 entonces
        estado = "perseguir"
        retornar
      fin
      
      // Realizar ataque
      objetivo:RecibirDaño(10)
      ReproducirSonido(SONIDO_ATAQUE, 1.0)
    }
  
  procedimientos:
    Principal() {
      InicializarComoModelo()
      
      mientras vida > 0 hacer
        // Máquina de estados
        si estado == "patrullar" entonces
          objetivo = BuscarObjetivo()
          si objetivo entonces
            estado = "perseguir"
          sino
            Patrullar()
          fin
          
        sino si estado == "perseguir" entonces
          Perseguir()
          
        sino si estado == "atacar" entonces
          Atacar()
        fin
        
        esperar()
      fin
    }
}
```

## 🚀 Compilación y Ejecución

### Compilar SeriousScript

```bash
# Compilar archivo
npm run compile MiJuego.ss

# Ver código generado
npm run compile MiJuego.ss --show-output

# Compilar con optimizaciones
npm run compile MiJuego.ss --optimize
```

### Ejecutar Juegos

```bash
# Ejecutar directamente
npm run game MiJuego.ss

# Con debugger
npm run debug MiJuego.ss

# Modo desarrollo (hot reload)
npm run dev MiJuego.ss
```

## 📚 API del Motor

SeriousScript tiene acceso completo a la API del motor:

### Funciones de Entidades
- `CrearEntidad(clase, posicion)`
- `DestruirEntidad(entidad)`
- `ObtenerEntidadesCercanas(posicion, radio)`

### Funciones de Física
- `TrazarRayo(origen, direccion, distancia)`
- `AplicarFuerza(fuerza)`
- `DetectarColision(entidad1, entidad2)`

### Funciones de Renderizado
- `CrearEfecto(nombre, posicion)`
- `MostrarMensaje(texto, duracion)`

### Funciones de Audio
- `ReproducirSonido(sonido, volumen)`
- `DetenerSonido(sonido)`

### Funciones de Input
- `TeclaPresionada(tecla)`
- `TeclaMantenida(tecla)`
- `ObtenerPosicionMouse()`

### Funciones Matemáticas
- `Random()`, `RandomRange(min, max)`
- `Sin()`, `Cos()`, `Tan()`
- `Sqrt()`, `Pow()`, `Abs()`
- `Min()`, `Max()`, `Clamp()`
- `Distancia()`, `Normalizar()`

## 🎓 Recursos de Aprendizaje

- 📖 [Guía de Inicio](GETTING_STARTED.md)
- 🎮 [Ejemplos](examples/)
- 📚 [Referencia Completa](SCRIPTING.md)
- 🎥 [Tutoriales en Video](https://youtube.com/gamestudios)
- 💬 [Comunidad Discord](https://discord.gg/gamestudios)

---

**¡Comienza a programar en SeriousScript hoy mismo!** 🚀

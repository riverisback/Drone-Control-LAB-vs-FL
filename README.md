# Proyecto de control de dron

Este proyecto simula y compara dos estrategias de control para un modelo de dron implementado en Simulink.

## Punto de entrada principal

Ejecuta [run_simulation.m](run_simulation.m) desde la carpeta raíz del proyecto.

El script:

1. Construye la trayectoria de referencia.
2. Configura los controladores LAB y FL.
3. Ejecuta ambos modelos de Simulink.
4. Calcula métricas de error de seguimiento y energía de control.
5. Genera visualizaciones opcionales (comentadas por defecto).

## Estructura del proyecto

| Ruta | Propósito |
| --- | --- |
| [run_simulation.m](run_simulation.m) | Script principal de orquestación. |
| [config/](config/) | Configuración y cálculo de ganancias. |
| [controllers/](controllers/) | Funciones de control llamadas por Simulink. |
| [metrics/](metrics/) | Métricas y preasignación de resultados. |
| [visualization/](visualization/) | Funciones de gráficos y animación. |
| [simulink/](simulink/) | Modelos de Simulink (modelo_dinamico_LAB.slx, modelo_dinamico_FL.slx). |
| [data/](data/) | Datos de entrada (incluye referencia_externa.mat). |

## Requisitos

- MATLAB
- Simulink
- Simscape Electrical: necesario para usar bloques Filter Derivative en los modelos de Simulink
- Symbolic Math Toolbox: usado por config/build_controller_gains.m (syms, equationsToMatrix)
- System Identification Toolbox: usado por bloques de identificación en los modelos de Simulink

## Notas

- Los modelos de Simulink están en [simulink/](simulink/).
- El script principal soporta Ts = 0.02 y Ts = 0.01.
- Con Ts = 0.02 se usa una trayectoria sintética interna.
- Con Ts = 0.01 se carga [data/referencia_externa.mat](data/referencia_externa.mat).

## Guía de uso

### Qué hace este proyecto

El proyecto compara dos controladores para un modelo de dron:

- Controlador LAB
- Controlador FL

En cada ejecución se simulan los modelos de Simulink, se recogen las salidas y se imprimen métricas de error y energía.

### Cómo ejecutarlo

1. Abre MATLAB en la carpeta del proyecto.
2. Verifica que Simulink pueda acceder a los modelos en [simulink/](simulink/).
3. Ejecuta [run_simulation.m](run_simulation.m).

### Selección de trayectoria

El tiempo de muestreo Ts define qué referencia se utiliza:

- Ts = 0.02 construye una trayectoria interna.
- Ts = 0.01 carga [data/referencia_externa.mat](data/referencia_externa.mat).

Si cambias Ts, mantenlo consistente con los datos de referencia y con el modelo de Simulink.

### Salidas principales

Al finalizar la simulación, el script imprime:

- Error cuadrático medio de x, y, z y psi
- Energía de control de u, tau_phi, tau_theta y tau_psi

También puede generar:

- Gráficas temporales 2D
- Trayectorias 3D
- Animación simple de trayectoria y orientación

### Solución de problemas

- Si Simulink no encuentra un controlador, confirma que estás ejecutando desde la raíz del proyecto.
- Si falla Ts = 0.01, confirma que existe [data/referencia_externa.mat](data/referencia_externa.mat).
- Si aparecen errores en el cálculo de polos, confirma que Symbolic Math Toolbox está instalado.

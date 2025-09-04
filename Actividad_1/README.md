### Actividad 1: introducción devops, devsecops 

Nombre: Luis Alberto Calapuja Apaza
Fecha: 01/09/2025

Parrafo con contexto del entorno usado (sin datos sensibles)

### Parte 1
#### 4.1 DevOps vs. cascada tradicional (investigación + comparación)

* Agrega una **imagen comparativa** en `imagenes/devops-vs-cascada.png`. Puede ser un diagrama propio sencillo.
* Explica por qué DevOps acelera y reduce riesgo en software para la nube frente a cascada (feedback continuo, pequeños lotes, automatización).
* Waterfall o Cascada divide los proyectos en fases, y estos se desarrollan secuencialmente. En DevOps desarrolladores y operaciones comparten flujos de trabajo, y
a traves de la integracion continua van armando y mejorando el software por "pequeños bloques" cada uno de estos sometidos a pruebas automatizadas, estas garantizan
la calidad y confiabilidad del software en un menor tiempo, ya que con cascada se trabajan "grandes bloques" de codigo, que una vez terminada su fase recien pasa 
a ser sometido a pruebas, lo cual lleva a perdidas de tiempo en el caso de haber errores, se volveria a la fase incial.

* **Pregunta retadora:** señala un **contexto real** donde un enfoque cercano a cascada sigue siendo razonable (por ejemplo, sistemas con certificaciones 
regulatorias estrictas o fuerte acoplamiento hardware). Expón **dos criterios verificables** y **los trade-offs** (velocidad vs. conformidad/seguridad).
* Proyectos de construccion de infraestructura donde se necesita cumplir requisitos tecnicos, realizar expedientes amplios y detallados, con ejecucion secuencial. Trade-offs:
 La velocidad con la que se desarrolla esa clase de proyectos es lenta, pero confiable en cuanto se cumplan los requisitos tecnicos.
* En caso de software, podemos notar el de los cajeros automaticos, estos requieren certificados de seguridad en cuanto a sus funciones de encriptacion y autenticacion, adicional
a ello las pruebas correspondientes para su buen funcionamiento. Trade-offs: al igual que en el ejemplo anterior, se sacrifica velocidad de entrega por seguridad y fiabilidad en 
el producto.  

#### 4.2 Ciclo tradicional de dos pasos y silos (limitaciones y anti-patrones)

* Inserta una imagen de **silos organizacionales** en `imagenes/silos-equipos.png` (o un dibujo propio).
* Identifica **dos limitaciones** del ciclo "construcción -> operación" sin integración continua (por ejemplo, grandes lotes, colas de defectos).
* Al querer integrar un gran lote de codigo de golpe, esto puede producir un error, el problema en esta situacion radica en que al ser un gran lote de codigo se tendria que revisar linea por linea para encontrar el error. Lo cual no
 sucede usando la metodologia de DevOps, ya que trabaja en pequeños bloques con pruebas automatizadas, hallando facilmente los errores y corrigiendolos casi al instante. En el caso anterior tambien podria darse el caso de que no sea 
solo un unico error, sino varios (cola de defectos) lo cual tomaria mas tiempo al desarrollador para resolver.

* **Pregunta retadora:** define **dos anti-patrones** ("throw over the wall", seguridad como auditoría tardía) y explica **cómo** agravan incidentes (mayor MTTR, retrabajos, degradaciones repetitivas).
* Antipatrones en codificacion
* "Throw over the wall" o tirar por la pared, consiste en pasar un proyecto a otra persona sin la documentacion correspondiente que explique de que trata el proyecto. Incidentes: mayor MTTR, al trabajar sin orientacion alguna 
se emplea mayor tiempo en entender y ordenar el codigo para su correcta ejecucion. Retrabajos, de haber errores se tiene que corregir y sin documentacion previa esto requiere mayor trabajo. Sin metricas presentes en el codigo no
 podemos asegurar su correcto funcionamiento, esto hace que los errores sean recurrentes, degradacion repetitiva.
* Seguridad como auditoria tardia: en este no se ejecutan pruebas al proyecto antes de entregarlo al usuario final, sino que a medida que se presentan los fallos se implementan las mejoras. Incidentes: mayor MTTR, se al estar en 
constante actualizacion para reparar fallos, el proyecto queda suspendido. Retrabajos, realizar parches sobre el codigo no probado. Los parches no aseguran que los errores no se vuelvan a presentar, se cae en degradacion repetitiva.

#### 4.3 Principios y beneficios de DevOps (CI/CD, automatización, colaboración; Agile como precursor)

* Describe CI y CD destacando **tamaño de cambios**, **pruebas automatizadas cercanas al código** y **colaboración**.
* CI (integracion continua) se trabajan pequeños bloques de codigo, estos sometidos a pruebas automatizadas cercanas al codigo. Esto se desarrolla en un sistema de control de 
versiones como GitHub donde varios desarrolladores pueden modificar el codigo mediante ramas sin alterar la rama principal. 
* CD (entrega continua) implementa el codigo compartido por CI, libera cambios en el codigo al usuario final. 
* La colaboracion en constante entre ambos y se complementan, esto genera entregas de software mas eficientes.

* Explica cómo **una práctica Agile** (reuniones diarias, retrospectivas) alimenta decisiones del pipeline (qué se promueve, qué se bloquea).
* Las reuniones diarias mejoran las comunicacion entre los colaboradores del proyecto, esto permite una mejor coordinacion en el avance del proyecto. Se bloquea el trabajo por
 secciones, es decir las diferentes areas se involucran en el proyecto (evitan la metologia cascada).

* Propón **un indicador observable** (no financiero) para medir mejora de colaboración Dev-Ops (por ejemplo, tiempo desde PR listo hasta despliegue en entorno de pruebas; proporción de rollbacks sin downtime).


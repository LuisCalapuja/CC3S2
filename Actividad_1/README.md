### Actividad 1: introducción devops, devsecops 

Nombre: Luis Alberto Calapuja Apaza
Fecha: 01/09/2025

Parrafo con contexto del entorno usado (sin datos sensibles)

### Parte 1
#### 4.1 DevOps vs. cascada tradicional (investigación + comparación)

* Agrega una **imagen comparativa** en `imagenes/devops-vs-cascada.png`. Puede ser un diagrama propio sencillo.
* Explica por qué DevOps acelera y reduce riesgo en software para la nube frente a cascada (feedback continuo, pequeños lotes, automatización).
Waterfall o Cascada divide los proyectos en fases, y estos se desarrollan secuencialmente. En DevOps desarrolladores y operaciones comparten flujos de trabajo, y
a traves de la integracion continua van armando y mejorando el software por "pequeños bloques" cada uno de estos sometidos a pruebas automatizadas, estas garantizan
la calidad y confiabilidad del software en un menor tiempo, ya que con cascada se trabajan "grandes bloques" de codigo, que una vez terminada su fase recien pasa 
a ser sometido a pruebas, lo cual lleva a perdidas de tiempo en el caso de haber errores, se volveria a la fase incial.

* **Pregunta retadora:** señala un **contexto real** donde un enfoque cercano a cascada sigue siendo razonable (por ejemplo, sistemas con certificaciones 
regulatorias estrictas o fuerte acoplamiento hardware). Expón **dos criterios verificables** y **los trade-offs** (velocidad vs. conformidad/seguridad).
Proyectos de construccion de infraestructura donde se necesita cumplir requisitos tecnicos, realizar expedientes amplios y detallados, con ejecucion secuencial. Trade-offs:
 La velocidad con la que se desarrolla esa clase de proyectos es lenta, pero confiable en cuanto se cumplan los requisitos tecnicos.
En caso de software, podemos notar el de los cajeros automaticos, estos requieren certificados de seguridad en cuanto a sus funciones de encriptacion y autenticacion, adicional
a ello las pruebas correspondientes para su buen funcionamiento. Trade-offs: al igual que en el ejemplo anterior, se sacrifica velocidad de entrega por seguridad y fiabilidad en 
el producto.  
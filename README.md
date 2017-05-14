# KeepCoding-IVEdicion-KeepcodingMasterBootcamp-ProgramacioniOSAvanzada-Practica-ShopsApp


A continuación se describen las partes que se han desarrollado (con el check marcado). 

## Elementos de la práctica
- [ ] Descargar toda la información la primera vez que hay conexión
- [X] La aplicación pondrá CoreData la información y en caché todo las imágenes, datos, etc. Incluso imágenes de los mapas.
  - [X] Una vez descargada la información (listado-JSON-, imágenes, ...) se almacena en caché y no se vuelve descargar las próximas veces que se acceda a dicha información
- [X] Hasta que finalice el almacenamiento en caché no llegará al menú principal
- [X] La lista de las tiendas tendrá:
  - [X] Mapa con un pin de cada una de las tiendas
  - [X] Lista de tiendas. Cada celda tendrá
  - - [X] Logotipo tomando todo el ancho de la celda. ***Entiendo que será en background***
  - - [X] Nombre de la tienda en la parte delantera.   
- [X] Al tocar en una celda nos llevará al detalle de la tienda
- [ ] Si pulsa en un alfiler en el mapa se abrirá una llamada con el logo + nombre de la tienda  
- [X] El mapa será siempre centrado en madrid, 
  - [ ] Mostrando también el usuario
- [X] Todos los datos son al menos en español e inglés: debe almacenar en caché todo y mostrar en español 
- [X] La pantalla del detalle de la tienda debe mostrar el nombre de la tienda, la descripción, la dirección y un mapa que muestra la ubicación de las tiendas sin ningún tipo de pin

## Enlaces de interes
Solución al problema de los datos duplicados en CoreDara: [Stackoverflow](http://stackoverflow.com/a/43129221/7837133)

-- 1. Crear una base de datos llamada películas.
CREATE DATABASE peliculas;

-- Conectar base de datos creada
\c peliculas;
Ahora está conectado a la base de datos «peliculas» con el usuario «postgres».

-- Crear tabla peliculas y reparto

CREATE TABLE peliculas (
    id SERIAL PRIMARY KEY,
    pelicula VARCHAR(100),
    anio_estreno INT,
    director VARCHAR(50)
);

CREATE TABLE reparto (
    id_pelicula INT REFERENCES peliculas(id),
    actor VARCHAR(50)
);

peliculas=# \dt
         Listado de relaciones
 Esquema |  Nombre   | Tipo  |  Due±o
---------+-----------+-------+----------
 public  | peliculas | tabla | postgres
 public  | reparto   | tabla | postgres
(2 filas)

-- 2. Cargar ambos archivos a su tabla correspondiente.

\COPY peliculas(id, pelicula, anio_estreno, director) FROM 'C:\\Users\\Valer\\Desktop\\Definicion_de_Tablas\\peliculas.csv' DELIMITER ',' CSV HEADER;

COPY 100

peliculas=# SELECT * FROM peliculas LIMIT 10;
 id |                      pelicula                       | anio_estreno |       director
----+-----------------------------------------------------+--------------+----------------------
  1 | Forest Gump                                         |         1994 | Robert Zemeckis
  2 | Titanic                                             |         1997 | James Cameron
  3 | El Padrino                                          |         1972 | Francis Ford Coppola
  4 | Gladiator                                           |         2000 | Ridley Scott
  5 | El Se├▒or de los anillos: El retorno del rey        |         2003 | Peter Jackson
  6 | El caballero oscuro                                 |         2008 | Christopher Nolan
  7 | Cadena perpetua                                     |         1994 | Frank Darabont
  8 | Piratas del Caribe: La maldici├│n de la Perla Negra |         2003 | Gore Verbinski
  9 | Braveheart                                          |         1995 | Mel Gibson
 10 | La lista de Schindler                               |         1993 | Steven Spielberg
(10 filas)

\COPY reparto(id_pelicula, actor) FROM 'C:\\Users\\Valer\\Desktop\\Definicion_de_Tablas\\reparto.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM reparto LIMIT 10;
 id_pelicula |          actor
-------------+--------------------------
           1 | Tom Hanks
           1 | Robin Wright Penn
           1 | Gary Sinise
           1 | Mykelti Williamson
           1 | Sally Field
           1 | Rebecca Williams
           1 | Michael Conner Humphreys
           1 | Harold G. Herthum
           1 | Haley Joel Osment
           1 | George Kelly
(10 filas)

-- 3. Obtener el ID de la película “Titanic”.

SELECT id FROM peliculas WHERE pelicula = 'Titanic';
 id
----
  2
(1 fila)

-- 4. Listar a todos los actores que aparecen en la película "Titanic".

SELECT actor FROM reparto
JOIN peliculas ON peliculas.id = reparto.id_pelicula
WHERE peliculas.pelicula = 'Titanic';

       actor
-------------------
 Leonardo DiCaprio
 Kate Winslet
 Billy Zane
 Kathy Bates
 Frances Fisher
 Bernard Hill
 Jonathan Hyde
 Danny Nucci
 David Warner
 Bill Paxton
 Gloria Stuart
 Victor Garber
 Suzy Amis
(13 filas)

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford.

SELECT COUNT(DISTINCT id_pelicula) 
FROM reparto
WHERE actor = 'Harrison Ford';

 count
-------
     8
(1 fila)

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.

SELECT pelicula, anio_estreno 
FROM peliculas
WHERE anio_estreno BETWEEN 1990 AND 1999
ORDER BY pelicula ASC;

                  pelicula                  | anio_estreno
--------------------------------------------+--------------
 American Beauty                            |         1999
 American History X                         |         1998
 Braveheart                                 |         1995
 Cadena perpetua                            |         1994
 Eduardo Manostijeras                       |         1990
 El club de la pelea                        |         1999
 El Padrino. Parte III                      |         1990
 El profesional                             |         1994
 El sexto sentido                           |         1999
 El show de Truman                          |         1998
 El silencio de los corderos                |         1991
 Entrevista con el vampiro                  |         1994
 Forest Gump                                |         1994
 Hombres de negro                           |         1997
 La lista de Schindler                      |         1993
 La milla verde                             |         1999
 Matrix                                     |         1999
 Mejor... imposible                         |         1997
 Parque Jur├ísico                           |         1993
 Pesadilla antes de navidad                 |         1993
 Pulp Fiction                               |         1994
 Salvar al soldado Ryan                     |         1998
 Seven                                      |         1995
 Star Wars. Episodio I: La amenaza fantasma |         1999
 Terminator 2: el juicio final              |         1991
 Titanic                                    |         1997
 Toy Story                                  |         1995
 Toy Story 2                                |         1999
 Trainspotting                              |         1996
 Uno de los nuestros                        |         1990
(30 filas)

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.

SELECT pelicula, LENGTH(pelicula) AS longitud_pelicula 
FROM peliculas;

                       pelicula                        | longitud_pelicula
-------------------------------------------------------+-------------------
 Forest Gump                                           |                11
 Titanic                                               |                 7
 El Padrino                                            |                10
 Gladiator                                             |                 9
 El Se├▒or de los anillos: El retorno del rey          |                44
 El caballero oscuro                                   |                19
 Cadena perpetua                                       |                15
 Piratas del Caribe: La maldici├│n de la Perla Negra   |                51
 Braveheart                                            |                10
 La lista de Schindler                                 |                21
 Toy Story                                             |                 9
 Eduardo Manostijeras                                  |                20
 El Se├▒or de los anillos: La comunidad del anillo     |                49
 Salvar al soldado Ryan                                |                22
 Regreso al futuro                                     |                17
 Monstruos S.A.                                        |                14
 Buscando a Nemo                                       |                15
 El Se├▒or de los anillos: Las dos torres              |                40
 Harry Potter y el Prisionero de Azkaban               |                39
 American History X                                    |                18
 300                                                   |                 3
 El sexto sentido                                      |                16
 Pulp Fiction                                          |                12
 V de Vendetta                                         |                13
 El silencio de los corderos                           |                27
 Rocky                                                 |                 5
 El club de la pelea                                   |                19
 E.T                                                   |                 3
 Parque Jur├ísico                                      |                16
 Matrix                                                |                 6
 La milla verde                                        |                14
 Ratatouille                                           |                11
 Grease                                                |                 6
 El Padrino. Parte II                                  |                20
 Wall-E                                                |                 6
 Iron Man                                              |                 8
 El exorcista                                          |                12
 Piratas del Caribe: El cofre del hombre muerto        |                46
 Seven                                                 |                 5
 Terminator 2: el juicio final                         |                29
 El resplandor                                         |                13
 Hombres de negro                                      |                16
 Spider-Man                                            |                10
 Regreso al futuro II                                  |                20
 El show de Truman                                     |                17
 Toy Story 2                                           |                11
 Pesadilla antes de navidad                            |                26
 Star Wars. Episodio IV: Una nueva esperanza           |                43
 Saw                                                   |                 3
 Terminator                                            |                10
 Kill Bill Vol. 1                                      |                16
 Lo que el viento se llev├│                            |                26
 El Laberinto del Fauno                                |                22
 Los incre├¡bles                                       |                15
 El viaje de Chihiro                                   |                19
 El precio del poder                                   |                19
 King Kong                                             |                 9
 Ben-Hur                                               |                 7
 Indiana Jones y la ├║ltima cruzada                    |                34
 Infiltrados                                           |                11
 Entrevista con el vampiro                             |                25
 Batman Begins                                         |                13
 En busca del arca perdida                             |                25
 Star Wars. Episodio III: La venganza de los Sith      |                48
 Alien                                                 |                 5
 El bueno el feo y el malo                             |                25
 Star Wars. Episodio V: El imperio contraataca         |                45
 El Padrino. Parte III                                 |                21
 Star Wars. Episodio VI: El retorno del Jedi           |                43
 Escuela de Rock                                       |                15
 El planeta de los simios                              |                24
 Rambo                                                 |                 5
 Full Metal Jacket                                     |                17
 Tibur├│n                                              |                 8
 El profesional                                        |                14
 American Beauty                                       |                15
 Casablanca                                            |                10
 Am├®lie                                               |                 7
 Trainspotting                                         |                13
 axi driver                                            |                10
 Alguien vol├│ sobre el nido del cuco                  |                36
 Kill Bill Vol. 2                                      |                16
 Spider-Man 2                                          |                12
 X-Men 2                                               |                 7
 Transformers                                          |                12
 Star Wars. Episodio I: La amenaza fantasma            |                42
 Blade Runner                                          |                12
 Apocalypse Now                                        |                14
 Mejor... imposible                                    |                18
 La vida de Brian                                      |                16
 El libro de la selva                                  |                20
 Los cazafantasmas                                     |                17
 Sweeney Todd: El barbero diab├│lico de la calle Fleet |                53
 Oceans Eleven                                        |                14
 Blancanieves y los siete enanitos                     |                33
 Predator                                              |                 8
 Indiana Jones y el templo maldito                     |                33
 Uno de los nuestros                                   |                19
 Mouling Rouge                                         |                13
 Psicosis                                              |                 8
(100 filas)

--  8. Consultar cual es la longitud más grande entre todos los títulos de las películas.

SELECT MAX(LENGTH(pelicula)) AS longitud_maxima 
FROM peliculas;

 longitud_maxima
-----------------
              53
(1 fila)




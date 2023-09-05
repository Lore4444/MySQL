-- INTEGRADOR

-- Llegó el momento de poner a prueba nuestros conocimientos de bases de datos, para ello nos han propuesto el siguiente desafío:
-- Tenemos que adivinar la clave y posición de una caja fuerte. El cerrojo consta de 4 candados, cada candado tiene de clave, un 
-- número que puede ser de más de 1 cifra y una posición que puede ir desde 1 a 4.
-- Nosotros tenemos los 4 candados en la mano (Candado A, Candado B, Candado C y Candado D) debemos averiguar la posición de cada 
-- candado y la clave del mismo.

-- 1- Abrir el script de la base de datos llamada “nba.sql”, que se encuentra en el drive y ejecutarlo para crear todas las tablas 
-- e insertar datos en las mismas. Deberá obtener el siguiente diagrama de relación:

-- CANDADO A
-- Posición: El candado A está ubicado en la posición calculada a partir del número obtenido en la/s siguiente/s consulta/s:
-- Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
-- Este resultado nos dará la posición del candado (1, 2, 3 o 4)
-- Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea centro o esté comprendida en 
-- otras posiciones.

use nba;
select count(*)
from estadisticas e
group by e.Asistencias_por_partido
order by e.Asistencias_por_partido desc
limit 1;

SELECT SUM(j.Peso) FROM jugadores j JOIN equipos e ON e.Nombre=j.Nombre_equipo
WHERE e.Conferencia="East" AND j.Posicion LIKE "%C%";

-- CANDADO A
-- La posicion es 2
-- La clave es 14043
-- ------------------------------------------------------------------------------
-- CANDADO B
-- Posición: El candado B está ubicado en la posición calculada a partir del número obtenido en la/s siguiente/s consulta/s:
-- Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de jugadores que tiene el equipo Heat.
-- Este resultado nos dará la posición del candado (1, 2, 3 o 4)
-- Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de datos:
-- La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.

SELECT count(Nombre) FROM jugadores j JOIN estadisticas e ON e.jugador = j.codigo
WHERE e.Asistencias_por_partido >= all (SELECT count(*) FROM jugadores j WHERE j.Nombre_equipo = 'Heat'
GROUP BY j.Nombre_equipo);

SELECT count(temporada) FROM partidos
WHERE temporada LIKE '%99%';

-- CANDADO B
-- La posiciom es 3
-- La clave es 3480
-- ------------------------------------------------------------------------------
-- CANDADO C
-- Posición: El candado C está ubicado en la posición calculada a partir del número obtenido en la/s siguiente/s consulta/s:
-- La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman parte de equipos de la conferencia oeste.
-- Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a 195, y a eso le vamos a sumar 0.9945.
-- Este resultado nos dará la posición del candado (1, 2, 3 o 4)
-- Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de datos:
-- Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de sumar: el promedio de puntos por 
-- partido, el conteo de asistencias por partido, y la suma de tapones por partido. Además, este resultado debe ser, donde la división 
-- sea central.

SELECT count(*)/
(select count(*) from jugadores ju where ju.Peso >= 195) + 0.9945 
FROM jugadores j
JOIN equipos e ON e.Nombre = j.Nombre_equipo
WHERE j.Procedencia = 'Michigan' AND e.Conferencia = 'west';

SELECT floor(avg(est.Puntos_por_partido)+count(est.asistencias_por_partido)+sum(est.tapones_por_partido)) 
FROM estadisticas est JOIN jugadores j ON est.jugador=j.codigo
JOIN equipos eq ON j.Nombre_equipo=eq.Nombre
WHERE eq.Division='Central';

-- CANDADO C
-- La posicion es 1
-- La clave es 631
-- ------------------------------------------------------------------------------
-- CANDADO D
-- Posición: El candado D está ubicado en la posición calculada a partir del número obtenido en la/s siguiente/s consulta/s:
-- Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este resultado debe ser redondeado. 
-- Nota: el resultado debe estar redondeado
-- Este resultado nos dará la posición del candado (1, 2, 3 o 4)
-- Clave: La clave del candado D estará con formada por la/s siguientes consulta/s a la base de datos:
-- Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido de todos los jugadores de 
-- procedencia argentina.

SELECT round(e.tapones_por_partido)
FROM estadisticas e JOIN jugadores j ON j.codigo = e.jugador
WHERE e.temporada = '00/01' AND j.Nombre = 'Corey Maggette';

SELECT floor(Sum(e.puntos_por_partido))
FROM estadisticas e JOIN jugadores j ON e.jugador=j.codigo
WHERE Procedencia="Argentina";

-- CANDADO D
-- La posicion es 4
-- La clave es 191


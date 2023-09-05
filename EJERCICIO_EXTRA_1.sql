-- EJERCICIO EXTRA N° 2 - NBA

-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
select nombre from `jugadores` order by nombre asc;
-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
select nombre from jugadores where posicion like 'C%' and peso > 200 order by Nombre asc;
-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
select nombre from equipos order by nombre asc;
-- 4. Mostrar el nombre de los equipos del este (East).
select nombre, Ciudad from equipos where Conferencia like 'East' ;
-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
select nombre, ciudad from equipos where ciudad like 'c%' order by nombre asc;
-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
select nombre, nombre_equipo from jugadores order by Nombre_equipo asc;
-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
select nombre from jugadores where Nombre_equipo like 'Raptors' order by nombre asc;
-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT SUM(E.Puntos_por_partido) 'Puntos totales', J.Nombre
FROM estadisticas E
JOIN jugadores J ON E.jugador = J.codigo
WHERE J.Nombre = 'Pau Gasol'
GROUP BY J.Nombre;
-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT Es.Puntos_por_partido, J.Nombre, Es.temporada
FROM estadisticas Es
JOIN jugadores J ON Es.jugador = J.codigo
WHERE Es.temporada = '04/05' AND J.Nombre = 'Pau Gasol';
-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
select  J.Nombre, round(SUM(Es.Puntos_por_partido),2) 'Puntos totales'
from estadisticas Es, jugadores J
where Es.jugador = J.codigo
GROUP BY J.Nombre
order by J.Nombre asc ;
-- 11. Mostrar el número de jugadores de cada equipo.
select count(J.Nombre) 'Cantidad Jugadores', Eq.Nombre 'Equipo'
from jugadores J 
join equipos Eq on J.Nombre_equipo = Eq.Nombre
group by J.Nombre_equipo;
-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
select J.Nombre 'Jugador' , round(SUM(Es.Puntos_por_partido),2) 'Puntos totales'
from estadisticas Es
join jugadores J on Es.jugador = J.codigo
group by J.Nombre
order by SUM(Es.Puntos_por_partido) desc
limit 1;
-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
select max(J.Altura) 'ALTURA' , J.Nombre 'JUGADOR', Eqs.Nombre 'EQUIPO', Eqs.Conferencia, Eqs.Division
from equipos Eqs
join jugadores J on Eqs.Nombre = J.Nombre_equipo
WHERE J.Altura = (SELECT MAX(Altura) FROM jugadores)
GROUP BY J.Nombre, Eqs.Nombre, Eqs.Conferencia, Eqs.Division;
-- 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
select avg(par.puntos_local+par.puntos_visitante) 'PROMEDIO DE PUNTOS EN PARTIDOS', eq.Nombre
from Partidos par, equipos eq
where (eq.Nombre = par.equipo_local or eq.Nombre = par.equipo_visitante) and eq.Division like 'Pacific'
group by eq.Division, eq.Nombre;
-- 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
select equipo_local 'EQUIPO LOCAL', equipo_visitante 'EQUIPO VISITANTE', abs( puntos_local - puntos_visitante) 'DIFERENCIA'
from partidos;
-- 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.== PUNTO 14
-- 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
select E.Nombre 'NOMBRE DE EQUIPO', sum(P.puntos_local) 'TOTAL DE PUNTOS LOCALES', sum(P.puntos_visitante) 'TOTAL PUNTOS VISITANTE' 
from partidos P, equipos E
where P.equipo_local = E.Nombre or P.equipo_visitante = E.Nombre
group by E.Nombre;
-- 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
-- equipo_ganador), en caso de empate sera null.
SELECT codigo, equipo_local, puntos_local, equipo_visitante, puntos_visitante,
    CASE
        WHEN puntos_local > puntos_visitante THEN equipo_local
        WHEN puntos_local < puntos_visitante THEN equipo_visitante
        ELSE NULL
    END AS equipo_ganador
FROM partidos;

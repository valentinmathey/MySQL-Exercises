#EJERCICIO 1 EXTRAS
USE nba;
# 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT nombre 
FROM jugador
ORDER BY nombre ASC;

# 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
SELECT nombre, posicion, peso 
FROM jugador
WHERE posicion = 'C' AND peso > 200;

# 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT nombre 
FROM equipo
ORDER BY nombre ASC;

# 4. Mostrar el nombre de los equipos del este (East).
SELECT nombre, conferencia, division
FROM equipo
WHERE conferencia ='East';

# 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT nombre, ciudad
FROM equipo
WHERE ciudad LIKE 'C%';

# 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT nombre, nombre_equipo
FROM jugador
ORDER BY nombre_equipo ASC;

# 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT nombre, nombre_equipo
FROM jugador
WHERE nombre_equipo = 'Raptors';

# 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT e.temporada, e.Puntos_por_partido
FROM estadistica e, jugador j
WHERE j.nombre = 'Pau Gasol' AND j.codigo = e.jugador;

# 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT e.temporada, e.Puntos_por_partido
FROM estadistica e, jugador j
WHERE j.nombre = 'Pau Gasol' AND j.codigo = e.jugador AND e.temporada = '04/05';

# 10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT j.nombre, round(sum(e.Puntos_por_partido)) AS 'Puntaje total'
FROM estadistica e INNER JOIN jugador j
ON j.codigo = e.jugador
GROUP BY j.codigo;

SELECT j.nombre, e.Puntos_por_partido
FROM estadistica e INNER JOIN jugador j
ON j.codigo = e.jugador;

# 11. Mostrar el número de jugadores de cada equipo.
SELECT e.nombre, COUNT(j.nombre) AS 'Cant jugadores'
FROM jugador j, equipo e
WHERE j.nombre_equipo = e.nombre
GROUP BY e.nombre;

# 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT j.nombre, SUM(e.Puntos_por_partido) 
FROM estadistica e, jugador j 
WHERE j.codigo = e.jugador and ma
GROUP BY j.nombre 
ORDER BY j.nombre ;
#ARREGLAR
select t.nombre
from ( select j.nombre, sum(e.puntos_por_partido) as puntos 
        from jugador j, estadistica e  
        where j.codigo = e.jugador 
		group by j.nombre
        order by j.nombre) t
where t.puntos = (select max(t2.puntos) from (select j.nombre, sum(e.puntos_por_partido) as puntos 
        from jugador j, estadistica e  
        where j.codigo = e.jugador 
        group by j.nombre 
        order by j.nombre) t2);

# 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT e.nombre, e.conferencia, e.division, j.nombre
FROM equipo e, jugador j
WHERE j.nombre_equipo = e.nombre AND altura = (SELECT MAX(j.altura) FROM jugador j);

# 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT e.nombre, e.division, AVG(p.puntos_local + puntos_visitante) AS 'Promedio puntos partidos'
FROM equipo e, partido p
WHERE (e.nombre = p.equipo_local OR e.nombre = p.equipo_visitante) AND e.division = 'Pacific'
GROUP BY e.nombre;

# 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT p1.codigo, p1.equipo_local, p1.equipo_visitante, MAX((p1.puntos_local - p1.puntos_visitante)) AS 'Diferencia local', MAX((p1.puntos_visitante - p1.puntos_local)) AS 'Diferencia visitante'
FROM partido p1
WHERE (p1.puntos_local - p1.puntos_visitante) = (SELECT MAX((p2.puntos_local - p2.puntos_visitante)) FROM partido p2);

SELECT MAX(puntos_local), MAX(puntos_visitante), MIN(puntos_local), MIN(puntos_visitante)
FROM partido;
#VERIFICAR
# 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT e.nombre, e.division, AVG(p.puntos_local + puntos_visitante) AS 'Promedio puntos partidos'
FROM equipo e, partido p
WHERE (e.nombre = p.equipo_local OR e.nombre = p.equipo_visitante) AND e.division = 'Pacific'
GROUP BY e.nombre;

# 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
SELECT e.nombre, SUM(p.puntos_local) + SUM(p.puntos_visitante)
FROM partido p, equipo e
WHERE e.nombre = p.equipo_local OR e.nombre = p.equipo_visitante
group by e.nombre;
#VERIFICAR
# 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
SELECT codigo, equipo_local, equipo_visitante, equipo_ganador
FROM partido
#ARREGLAR
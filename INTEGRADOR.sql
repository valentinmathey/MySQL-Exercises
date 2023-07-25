#INTEGRADOR
use nba;

#CANDADO A
#POSICION
SELECT COUNT(e1.Asistencias_por_partido)
FROM estadistica e1
WHERE e1.Asistencias_por_partido = (SELECT MAX(e2.Asistencias_por_partido) FROM estadistica e2);

#LLAVE
SELECT SUM(j.peso)
FROM jugador j, equipo e
WHERE j.nombre_equipo = e.nombre AND e.conferencia = 'East' AND j.posicion LIKE '%C%';

#CANDADO B
#POSICION
SELECT COUNT(j.nombre)
FROM jugador j, estadistica es
WHERE j.codigo = es.jugador AND es.Asistencias_por_partido > (SELECT COUNT(j.nombre) FROM jugador j WHERE j.nombre_equipo = 'Heat');

#LLAVE
SELECT COUNT(p.temporada)
FROM partido p
WHERE p.temporada LIKE '%99%';

#CANDADO C
#POSICION
SELECT DISTINCT COUNT(x1.nombre) / COUNT(x2.nombre)
FROM (SELECT j1.nombre FROM jugador j1, equipo e1 WHERE j1.nombre_equipo = e1.nombre AND j1.procedencia = 'Michigan' AND e1.conferencia = 'West') x1,
	 (SELECT j2.nombre FROM jugador j2 WHERE j2.peso >= 195) x2;
     
SELECT j1.*, e1.conferencia FROM jugador j1, equipo e1 WHERE j1.nombre_equipo = e1.nombre AND j1.procedencia = 'Michigan' AND e1.conferencia = 'West';
SELECT COUNT(j2.nombre) FROM jugador j2 WHERE j2.peso >= 195;
#LLAVE
SELECT FLOOR(AVG(e1.Puntos_por_partido) + COUNT(e1.Asistencias_por_partido) + SUM(e1.Tapones_por_partido))
FROM estadistica e1, equipo e2, jugador j1
WHERE e1.jugador = j1.codigo AND j1.nombre_equipo = e2.nombre AND e2.division = 'central';
#CANDADO D
#POSICION
SELECT FLOOR(e1.Tapones_por_partido)
FROM jugador j1, estadistica e1
WHERE e1.jugador = j1.codigo AND j1.nombre = 'Corey Maggette' AND e1.temporada = '00/01';

#LLAVE
SELECT FLOOR(SUM(e1.Puntos_por_partido))
FROM jugador j1, estadistica e1
WHERE e1.jugador = j1.codigo AND j1.procedencia = 'Argentina';

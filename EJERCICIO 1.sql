
# EJERCICIO 1
USE personal;
# 1. Obtener los datos completos de los empleados.
SELECT * FROM empleado;

# 2. Obtener los datos completos de los departamentos.
SELECT * 
FROM departamento;

# 3. Listar el nombre de los departamentos.
SELECT nombre_depto 
FROM departamento;

# 4. Obtener el nombre y salario de todos los empleados.
SELECT nombre, salario 
FROM empleado;

# 5. Listar todas las comisiones.
SELECT DISTINCT comision 
FROM empleado;

# 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * 
FROM empleado 
WHERE cargo = 'Secretaria';

# 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT * 
FROM empleado 
WHERE cargo = 'Vendedor' 
ORDER BY nombre ASC;

# 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre, cargo
FROM empleado
ORDER BY salario ASC;

# 9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT nombre AS 'NOMBRE', cargo AS 'CARGO'
FROM empleado;

# 10. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT salario, comision
FROM empleado
WHERE id_depto = 2000
ORDER BY comision ASC;

# 11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los empleados del departamento 3000 una bonificación de 500, en orden alfabético del empleado.
# PARA LA SUMA TOTAL
SELECT (SUM(salario) + SUM(comision) + 500) AS 'suma total'
FROM empleado
WHERE id_depto = 3000
ORDER BY nombre ASC;
#PARA CADA EMPLEADO
SELECT nombre, salario, comision, (salario + comision +  500) AS 'suma total'
FROM empleado
WHERE id_depto = 3000
ORDER BY nombre ASC;

# 12. Muestra los empleados cuyo nombre empiece con la letra J.
SELECT *
FROM empleado
WHERE nombre LIKE 'J%';

# 13. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
SELECT nombre, salario, comision, (salario + comision) AS 'Salario total'
FROM empleado
WHERE comision > 1000;

# 14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT nombre, salario, comision, (salario + comision) AS 'Salario total'
FROM empleado
WHERE comision = 0;

# 15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT * 
FROM empleado
WHERE comision > salario;

# 16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT * 
FROM empleado 
WHERE comision <= (salario * 0.3);

# 17. Hallar los empleados cuyo nombre no contiene la cadena “MA”.
SELECT *
FROM empleado
WHERE NOT nombre LIKE '%MA%';

# 18. Obtener los nombres de los departamentos que sean “Ventas” o “Investigación” o ‘Mantenimiento'.
#FORMA COMPLETA
SELECT *
FROM departamento
WHERE nombre_depto = 'VENTAS' OR nombre_depto = 'INVESTIGACION' OR nombre_depto = 'MANTENIMIENTO';
#FORMA SIMPLE
SELECT *
FROM departamento
WHERE nombre_depto IN('VENTAS', 'INVESTIGACION', 'MANTENIMIENTO');

# 19. Ahora obtener los nombres de los departamentos que no sean “Ventas” ni“Investigación” ni ‘Mantenimiento.
SELECT *
FROM departamento
WHERE NOT nombre_depto IN('VENTAS', 'INVESTIGACION', 'MANTENIMIENTO');

# 20. Mostrar el salario más alto de la empresa.
SELECT e1.nombre,  MAX(salario) AS 'Mejor sueldo'
FROM empleado e1
WHERE e1.salario = (SELECT MAX(e2.salario) FROM empleado e2);

# 21. Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT *
FROM empleado
ORDER BY nombre DESC 
LIMIT 1;

# 22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT MAX(salario) AS 'Mejor sueldo', MIN(salario) AS 'Peor sueldo', (MAX(salario) - MIN(salario)) AS 'Diferencia'
FROM empleado;

# 23. Hallar el salario promedio por departamento.
SELECT id_depto, ROUND(AVG(salario)) AS 'Salario promedio'
FROM empleado
GROUP BY id_depto;

#Consultas con Having
#24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
SELECT d.id_depto, d.nombre_depto, COUNT(e.id_empleado) AS 'Num empleados'
FROM empleado e, departamento d
WHERE e.id_depto = d.id_depto
GROUP BY e.id_depto
HAVING COUNT(e.id_depto) >= 3;

#25. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige. Solo los que tengan más de dos empleados (2 incluido).
SELECT cod_jefe, nombre, cargo, COUNT(cod_jefe ) AS 'Num empleados'
FROM empleado
#WHERE cargo LIKE '%Jefe%'
GROUP BY cod_jefe
HAVING COUNT(cod_jefe) >= 2;
#(ejercicio mal planteado)

#26. Hallar los departamentos que no tienen empleados 
SELECT d.id_depto, d.nombre_depto, COUNT(e.id_empleado) AS 'Num empleados'
FROM empleado e, departamento d
WHERE e.id_depto = d.id_depto
GROUP BY e.id_depto
HAVING COUNT(e.id_depto) = 0;

#Consulta con Subconsulta
#27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
SELECT *
FROM empleado e
WHERE e.salario >= (SELECT AVG(e2.salario) FROM empleado e2)
ORDER BY e.id_depto ASC;

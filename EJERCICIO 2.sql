#EJERCICIO 2
USE tienda;
# 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre 
FROM producto;

# 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio
FROM producto;

# 3. Lista todas las columnas de la tabla producto.
SELECT *
FROM producto;

# 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, ROUND(precio)
FROM producto;

# 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT f.nombre, f.codigo
FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante;

# 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT DISTINCT f.nombre, f.codigo
FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante;

# 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

# 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT *
FROM producto
ORDER BY nombre ASC, precio DESC;

# 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT *
FROM fabricante
LIMIT 5;

# 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT *
FROM producto
ORDER BY precio ASC
LIMIT 1;

# 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT *
FROM producto
ORDER BY precio DESC
LIMIT 1;

# 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT *
FROM producto
WHERE precio <= 120;

# 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT *
FROM producto
WHERE precio
BETWEEN 60 AND 200;

# 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT *
FROM producto
WHERE codigo_fabricante
IN (1, 3, 5);

# 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT *
FROM producto
WHERE nombre 
LIKE '%Portátil%';

# Consultas Multitabla
# 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT  p.codigo, p.nombre, f.codigo, f.nombre
FROM producto p, fabricante f
WHERE f.codigo = p.codigo_fabricante
ORDER BY p.codigo;
#ARREGLAR
# 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, 
# por orden alfabético.
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
WHERE f.codigo = p.codigo_fabricante
ORDER BY f.nombre ASC;
#ARREGLAR
# 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
ORDER BY p.precio ASC
LIMIT 1;

# 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.*, f.nombre
FROM producto p, fabricante f
WHERE f.nombre 
LIKE '%Lenovo%';

# 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT p.*, f.nombre
FROM producto p, fabricante f
WHERE f.nombre 
LIKE '%Crucial%' AND p.precio > 200;

# 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT p.*, f.nombre
FROM producto p, fabricante f
WHERE f.codigo = p.codigo_fabricante AND f.nombre
IN ('Asus', 'Hewlett-Packard');

# 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. 
# Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
WHERE p.precio >= 180 AND f.codigo = p.codigo_fabricante
ORDER BY p.precio DESC, p.nombre ASC;

#Consultas Multitabla
#Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
#1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
# El listado deberá mostrar también aquellosfabricantes que no tienen productos asociados.
SELECT f.*, p.*
FROM fabricante f LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante
ORDER BY f.codigo ASC;


#2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT *
FROM fabricante f
WHERE NOT EXISTS (SELECT * FROM producto p WHERE f.codigo = p.codigo_fabricante)
ORDER BY f.codigo;

SELECT f.*
FROM fabricante f LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante 
WHERE p.codigo_fabricante is null
ORDER BY f.codigo;

#Subconsultas (En la cláusula WHERE)
#Con operadores básicos de comparación
#1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT f.nombre, p.*
FROM fabricante f, producto p
WHERE f.nombre LIKE '%Lenovo%' AND f.codigo = p.codigo_fabricante;

#2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT f.nombre, p.*
FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante AND p.precio > (SELECT MAX(p.precio) FROM producto p, fabricante f WHERE f.codigo = p.codigo_fabricante AND f.nombre LIKE '%Lenovo%');

#3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT f.nombre, p.*, MAX(p.precio) AS 'Mejor sueldo'
FROM producto p, fabricante f 
WHERE f.codigo = p.codigo_fabricante AND f.nombre LIKE '%Lenovo%';

#4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT f.nombre, p.*
FROM fabricante f, producto p
WHERE p.codigo_fabricante = f.codigo AND f.nombre LIKE '%Asus%' AND p.precio > (SELECT AVG(p.precio) FROM producto p);

#Subconsultas con IN y NOT IN
#1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT DISTINCT f.*
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo AND p.codigo_fabricante BETWEEN 1 AND 9;

# 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT DISTINCT f.*
FROM producto p, fabricante f
WHERE NOT EXISTS (SELECT * FROM producto p WHERE f.codigo = p.codigo_fabricante);

# Subconsultas (En la cláusula HAVING)
#1. Devuelve un listado con todos los nombres de los productos que tienen el mismo número de productos que el fabricante Lenovo.
SELECT f.*
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
GROUP BY f.nombre
HAVING COUNT(f.nombre) = (SELECT COUNT(f2.nombre) FROM fabricante f2, producto p2 WHERE p2.codigo_fabricante = f2.codigo AND f2.nombre LIKE '%Lenovo%');

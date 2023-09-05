-- EJERCICIO N° 2 - TIENDA


use tienda;

-- 1. Lista el nombre de todos los productos que hay en la tabla producto. --
SELECT nombre FROM producto;
-- 2. Lista los nombres y los precios de todos los productos de la tabla producto. --
select nombre, precio from producto;
-- 3. Lista todas las columnas de la tabla producto.
select * from producto;
-- otra forma 
-- SELECT * FROM producto;
-- SHOW COLUMNS FROM producto;
-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre,ROUND(precio) FROM producto;
-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT p.codigo_fabricante, f.nombre FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;
-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT DISTINCT p.codigo_fabricante, f.nombre FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;
-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre from fabricante order by nombre asc;
-- 8. Lista los nombres de los productos ordenados en primer lugar por el 
-- nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio from producto order by nombre asc; 
SELECT nombre, precio from producto order by precio desc; 
-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * from fabricante limit 5;
-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio from producto order by precio asc limit 1;
-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio from producto order by precio desc limit 1;
-- Otra forma 
-- SELECT nombre, precio FROM producto where precio = (select MAX(precio) from producto);
-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre, precio FROM producto WHERE precio  <= 120;
-- Para Ruben SELECT nombre, precio FROM producto WHERE precio  <= 120 order by precio desc;
-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio between 60 and 200;
-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);
-- Otra forma
-- Para Lore SELECT * FROM producto WHERE codigo_fabricante = 1 or codigo_fabricante = 3 or codigo_fabricante = 5;
-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil
-- en el nombre
SELECT  nombre FROM producto WHERE nombre like "%portatil%";

-- Consultas Multitabla

-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante
-- y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.codigo, p.nombre, p.codigo_fabricante, f.nombre FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;
-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
-- los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
-- orden alfabético.
SELECT p.nombre as "Nombre Producto", p.precio, f.nombre as "Nombre Fabricante" FROM fabricante f JOIN producto p 
ON f.codigo = p.codigo_fabricante order by f.nombre asc;
-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto
-- más barato.
SELECT p.nombre as "Nombre Producto", p.precio, f.nombre as "Nombre Fabricante" FROM fabricante f JOIN producto p 
ON f.codigo = p.codigo_fabricante WHERE p.precio = (Select MIN(p.precio)from producto) limit 1;
-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = "Lenovo";
-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio
-- mayor que $200.
SELECT * FROM producto p INNER JOIN fabricante f
ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Crucial" and p.precio >=200;
-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard.
-- Utilizando el operador IN.
SELECT * FROM producto p INNER JOIN fabricante f
ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ("Asus", "Hewlett-Packard");
-- 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
-- los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
-- lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
-- ascendente)
SELECT p.nombre as "Nombre Producto", p.precio, f.nombre as "Nombre Fabricante" 
FROM producto p JOIN fabricante f
ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio desc, p.nombre asc;
SELECT p.nombre as "Nombre Producto", p.precio, f.nombre as "Nombre Fabricante" 
FROM producto p JOIN fabricante f
ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.nombre asc;

-- Consultas Multitabla

-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT f.nombre as "Fabricantes", p.nombre as "Productos"  FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo;
-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT f.nombre as "Fabricantes", p.nombre as "Productos" FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo 
WHERE p.codigo_fabricante is NULL;

-- Subconsultas (En la cláusula WHERE)
-- Con operadores básicos de comparación

-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT nombre FROM producto Where codigo_fabricante=2;
SELECT nombre FROM producto WHERE codigo_fabricante =(SELECT codigo from fabricante WHERE nombre="Lenovo");
-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. 
-- (Sin utilizar INNER JOIN).
SELECT * FROM producto WHERE precio= (SELECT MAX(precio) from producto Where codigo_fabricante=(SELECT codigo from fabricante WHERE nombre="Lenovo"));
-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre FROM producto Where precio= (SELECT MAX(precio) from producto Where codigo_fabricante=2);
SELECT p.nombre, MAX(p.precio) FROM fabricante f JOIN producto p ON p.codigo_fabricante = f.codigo WHERE f.nombre="Lenovo" 
group by p.nombre limit 1; 
-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT nombre, precio, (SELECT AVG(precio)FROM producto WHERE codigo_fabricante=1) as "Promedio" FROM producto 
WHERE codigo_fabricante=1 AND precio > (SELECT AVG(precio)FROM producto WHERE codigo_fabricante=1) ;

-- Subconsultas con IN y NOT IN

-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT DISTINCT f.nombre FROM fabricante f JOIN producto p ON f.codigo=p.codigo_fabricante; 
SELECT DISTINCT fabricante.nombre FROM fabricante, producto WHERE producto.codigo_fabricante IN (fabricante.codigo);
-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE codigo IN (8,9);
SELECT nombre FROM fabricante WHERE codigo IN (SELECT codigo FROM fabricante WHERE nombre IN ("Huawei","Xiaomi"));
SELECT nombre FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);
 
-- Subconsultas (En la cláusula HAVING)

-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT f.nombre "Fabricante" FROM fabricante f JOIN producto p ON f.codigo=p.codigo_fabricante GROUP BY f.nombre 
HAVING COUNT(*)=(SELECT COUNT(*) FROM producto r, fabricante a WHERE r.codigo_fabricante=a.codigo AND 
a.nombre="Lenovo" GROUP BY codigo_fabricante);
 
SELECT fabricante.nombre, COUNT(producto.codigo)
FROM fabricante INNER JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo
HAVING COUNT(producto.codigo) >= (
    SELECT COUNT(producto.codigo)
    FROM fabricante INNER JOIN producto
    ON fabricante.codigo = producto.codigo_fabricante
    WHERE fabricante.nombre = 'Lenovo');







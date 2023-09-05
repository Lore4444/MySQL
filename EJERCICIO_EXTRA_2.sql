-- EJERCICIO EXTRA N° 2 - JARDINERIA


-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina, ciudad from oficina;
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select ciudad, telefono from oficina where pais = 'españa';
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
-- código de jefe igual a 7.
select nombre, concat(apellido1, ' ' ,apellido2) as apellidos, email from empleado where codigo_jefe =7;
-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select nombre, concat(apellido1, ' ' ,apellido2) as apellidos, email from empleado where puesto = 'director general';
-- OTRA FORMA SELECT puesto, nombre, apellido1, apellido2, email FROM empleado LIMIT 1;
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select nombre, concat(apellido1, ' ' ,apellido2) as apellidos, puesto from empleado where puesto != 'representante ventas';
-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_cliente, pais from cliente where pais = 'spain';
-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct estado from pedido;
-- OTRA FORMA SELECT estado FROM pedido GROUP BY estado;
-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
-- en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. 
-- Resuelva la consulta:
-- o Utilizando la función YEAR de MySQL.
select distinct codigo_cliente from pago where year (fecha_pago) = 2008;
-- o Utilizando la función DATE_FORMAT de MySQL.
select distinct codigo_cliente from pago where date_format(fecha_pago, '%Y') = '2008';
-- o Sin utilizar ninguna de las funciones anteriores.
select distinct codigo_cliente from pago  where fecha_pago like '2008%' ;
-- 9.Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
-- entrega de los pedidos que no han sido entregados a tiempo.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido where fecha_esperada< fecha_entrega and estado= 'entregado';
-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos 
-- cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada. 
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE (fecha_esperada-fecha_entrega)>=2;
-- o Utilizando la función ADDDATE de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido where fecha_entrega <= adddate(fecha_esperada, interval -2 day) and estado = 'entregado';
-- OTRA FORMA SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega <= ADDDATE(fecha_esperada, -2);
-- o Utilizando la función DATEDIFF de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido where datediff(fecha_esperada,fecha_entrega) >=2 and estado= 'entregado';
-- OTRA FORMA SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT * FROM pedido WHERE estado='Rechazado' AND YEAR(fecha_pedido)=2009;
-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
select *from pedido where month(fecha_entrega) = 1 and estado = 'entregado';
SELECT * FROM pedido WHERE MONTH(fecha_entrega)=01;
-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select *from pago where year(fecha_pago) = 2008 and forma_pago = 'paypal' order by total desc;
-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer 
-- formas de pago repetidas.
select distinct forma_pago from pago;
-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
-- tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
-- venta, mostrando en primer lugar los de mayor precio.
select gama, precio_venta, cantidad_en_stock from producto where gama= 'Ornamentales' AND cantidad_en_stock>100 order by precio_venta desc;
-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
-- representante de ventas tenga el código de empleado 11 o 30.
select nombre_cliente, ciudad, codigo_empleado_rep_ventas
from cliente where codigo_empleado_rep_ventas IN (11,30) and ciudad = 'madrid';

-- Consultas multitabla (Composición interna)

-- Las consultas se deben resolver con INNER JOIN.

-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select nombre_cliente, nombre, concat(apellido1, ' ', apellido2) 'apellidos' 
from cliente inner join empleado on codigo_empleado_rep_ventas=codigo_empleado; 

SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, e.puesto  FROM cliente c 
INNER JOIN empleado e ON codigo_empleado_rep_ventas=codigo_empleado 
WHERE e.puesto='Representante Ventas';
-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
-- representantes de ventas.
select nombre_cliente, forma_pago, nombre, concat(apellido1, ' ', apellido2) 'apellidos' 
from cliente c inner join pago p on c.codigo_cliente= p.codigo_cliente inner join empleado e 
on  c.codigo_empleado_rep_ventas=e.codigo_empleado;

SELECT c.nombre_cliente,p.codigo_cliente,e.puesto FROM cliente c 
INNER JOIN pago p ON c.codigo_cliente=p.codigo_cliente 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas=e.codigo_empleado
WHERE e.puesto='Representante Ventas';
-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
-- sus representantes de ventas.
select nombre_cliente, forma_pago, nombre, concat(apellido1, ' ', apellido2) 'apellidos' 
from cliente c left join pago p on c.codigo_cliente= p.codigo_cliente inner join empleado e 
on  c.codigo_empleado_rep_ventas=e.codigo_empleado where forma_pago is null;

SELECT c.nombre_cliente, c.codigo_cliente, e.nombre
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL
AND e.puesto = 'Representante Ventas';
-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante.
select nombre_cliente, forma_pago, nombre, concat(apellido1, ' ', apellido2) 'apellidos', o.ciudad 
from cliente c inner join pago p on c.codigo_cliente= p.codigo_cliente inner join empleado e 
on  c.codigo_empleado_rep_ventas=e.codigo_empleado inner join oficina o on o.codigo_oficina = e.codigo_oficina;

SELECT c.nombre_cliente,c.codigo_cliente,e.nombre,e.apellido1,e.apellido2, o.ciudad FROM cliente c 
INNER JOIN pago p ON c.codigo_cliente=p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas=e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina=o.codigo_oficina;
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el representante.
select nombre_cliente, forma_pago, nombre, concat(apellido1, ' ', apellido2) 'apellidos', o.ciudad 
from cliente c left join pago p on c.codigo_cliente= p.codigo_cliente inner join empleado e 
on  c.codigo_empleado_rep_ventas=e.codigo_empleado inner join oficina o on o.codigo_oficina = e.codigo_oficina 
where forma_pago is null;

SELECT c.nombre_cliente,c.codigo_cliente,e.nombre,e.apellido1,e.apellido2, o.ciudad FROM cliente c 
LEFT JOIN pago p ON c.codigo_cliente=p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas=e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina=o.codigo_oficina
WHERE p.codigo_cliente IS NULL;
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select c.ciudad, o.linea_direccion1, o.linea_direccion2, c.nombre_cliente
from cliente c inner join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado
inner join oficina o on e.codigo_oficina=o.codigo_oficina where c.ciudad= 'Fuenlabrada';  
-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
-- de la oficina a la que pertenece el representante.
select c.nombre_cliente, e.nombre, concat(apellido1, ' ' , apellido2) as apellidos, o.ciudad
from cliente c inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on o.codigo_oficina = e.codigo_oficina;
-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select e.nombre'nombre jefe', concat(e.apellido1, ' ' , e.apellido2) 'apellidos jefe', 
j.nombre'nombre empleado', concat(j.apellido1, ' ' , j.apellido2) 'apellidos empleado'
from empleado e inner join empleado j on j.codigo_jefe=e.codigo_empleado;
-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT c.nombre_cliente, p.fecha_entrega, p.fecha_esperada FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente=p.codigo_cliente WHERE p.fecha_entrega>p.fecha_esperada;
-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
select nombre_cliente, p2.gama
from cliente c inner join pedido p on c.codigo_cliente = p.codigo_cliente
inner join detalle_pedido d on d.codigo_pedido = p.codigo_pedido
inner join producto p2 on p2.codigo_producto = d.codigo_producto; 

-- Consultas multitabla (Composición externa)

-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT c.nombre_cliente,c.codigo_cliente, p.forma_pago FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente=p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;
-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
-- pedido.
SELECT c.nombre_cliente,c.codigo_cliente, p.codigo_pedido as pedido FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente=p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;
-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
-- no han realizado ningún pedido.
SELECT c.nombre_cliente,c.codigo_cliente, pd.codigo_pedido as pedido, forma_pago FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente=p.codigo_cliente
LEFT JOIN pedido pd ON c.codigo_cliente=pd.codigo_cliente
WHERE p.codigo_cliente IS NULL AND pd.codigo_cliente IS NULL;
-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina
-- asociada.
select e.nombre, concat(e.apellido1, ' ' , e.apellido2) 'apellidos', o.codigo_oficina 'oficina'
from empleado e left join oficina o on e.codigo_oficina=o.codigo_oficina where e.codigo_oficina is null;

SELECT * FROM empleado WHERE codigo_oficina IS NULL;
-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente
-- asociado.
select  e.nombre, concat(e.apellido1, ' ' , e.apellido2) 'apellidos', codigo_empleado_rep_ventas 'cliente'
from empleado e left join cliente on codigo_empleado_rep_ventas=codigo_empleado where codigo_empleado_rep_ventas is null;

SELECT * FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas=e.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;
-- 6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
-- que no tienen un cliente asociado.
select  e.nombre, concat(e.apellido1, ' ' , e.apellido2) 'apellidos', c.codigo_empleado_rep_ventas 'cliente', o.codigo_oficina 'oficina'
from empleado e 
left join oficina o on e.codigo_oficina=o.codigo_oficina
left join cliente c on c.codigo_empleado_rep_ventas=e.codigo_empleado 
where c.codigo_empleado_rep_ventas is null and e.codigo_oficina is null;

SELECT * FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina=o.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado=c.codigo_empleado_rep_ventas
WHERE e.codigo_oficina IS NULL AND c.codigo_empleado_rep_ventas IS NULL;
-- 7. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT p.codigo_producto, p.nombre, pd.codigo_pedido 'pedido' from producto p
LEFT JOIN detalle_pedido dp ON dp.codigo_producto=p.codigo_producto
LEFT JOIN pedido pd ON dp.codigo_pedido=pd.codigo_pedido
WHERE dp.codigo_producto IS NULL;
-- 8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
-- representantes de ventas de algún cliente que haya realizado la compra de algún producto
-- de la gama Frutales.
SELECT distinct o.codigo_oficina, o.ciudad,o.pais,o.region FROM oficina o 
LEFT JOIN empleado e ON o.codigo_oficina=e.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado=c.codigo_empleado_rep_ventas
LEFT JOIN pedido p ON c.codigo_cliente=p.codigo_cliente
LEFT JOIN detalle_pedido dp ON p.codigo_pedido=dp.codigo_pedido
RIGHT JOIN producto pr ON dp.codigo_producto=pr.codigo_producto
WHERE pr.gama!='Frutales';
-- 9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
-- ningún pago.
SELECT distinct c.codigo_cliente,c.nombre_cliente,c.nombre_contacto,c.apellido_contacto FROM cliente c
RIGHT JOIN pedido p ON c.codigo_cliente=p.codigo_cliente
LEFT JOIN pago pg ON c.codigo_cliente=pg.codigo_cliente
WHERE pg.codigo_cliente IS NULL;
-- 10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
-- nombre de su jefe asociado.
select e.nombre'nombre jefe', concat(e.apellido1, ' ' , e.apellido2) 'apellidos jefe', 
j.nombre'nombre empleado', concat(j.apellido1, ' ' , j.apellido2) 'apellidos empleado'
from empleado e 
left join cliente on e.codigo_empleado=codigo_empleado_rep_ventas
join empleado j on e.codigo_empleado=j.codigo_jefe where codigo_empleado_rep_ventas is null;

-- Consultas resumen

-- 1. ¿Cuántos empleados hay en la compañía?
select count(codigo_empleado) from empleado;
-- 2. ¿Cuántos clientes tiene cada país?
select count(codigo_cliente), pais from cliente group by pais;
-- 3. ¿Cuál fue el pago medio en 2009?
select round(avg(total)) 'promedio 2009'
from pago where year(fecha_pago)=2009;
-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
-- número de pedidos.
select count(estado), estado
from pedido group by estado order by count(estado) desc;

SELECT count(*) AS num_pedido, estado FROM pedido
group by estado ORDER BY count(*) DESC;
-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
select max(precio_venta) 'producto caro',  min(precio_venta) 'producto barato'
from producto ;
-- 6. Calcula el número de clientes que tiene la empresa.
select count(codigo_cliente)
from cliente;
-- 7. ¿Cuántos clientes tiene la ciudad de Madrid?
select count(codigo_cliente), ciudad
from cliente where ciudad= 'madrid' group by ciudad;
-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
select count(codigo_cliente), ciudad
from cliente where ciudad like 'm%' group by ciudad;
-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
-- cada uno.
select nombre, concat(apellido1, ' ', apellido2)  as apellidos , count(codigo_cliente) as cliente
from empleado join cliente on codigo_empleado=codigo_empleado_rep_ventas group by nombre, apellidos;
-- 10. Calcula el número de clientes que no tiene asignado representante de ventas.
select count(codigo_cliente)
from cliente where codigo_empleado_rep_ventas is null;
-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
-- deberá mostrar el nombre y los apellidos de cada cliente.
select nombre_cliente, max(fecha_pago), min(fecha_pago)
from cliente c join pago p on c.codigo_cliente=p.codigo_cliente group by nombre_cliente;
-- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
select count(d.codigo_pedido), p.codigo_pedido
from pedido p join detalle_pedido d on d.codigo_pedido=p.codigo_pedido
 join producto pr on  pr.codigo_producto= d.codigo_producto group by p.codigo_pedido;
-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de
-- los pedidos.
select codigo_pedido, count(codigo_pedido) 'productos', sum(cantidad)
from detalle_pedido group by codigo_pedido;
-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que
-- se han vendido de cada uno. El listado deberá estar ordenado por el número total de
-- unidades vendidas.
select codigo_producto, count(codigo_producto) as solicitados, sum(cantidad) as total
from detalle_pedido group by codigo_producto order by total desc limit 20;
-- 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
-- IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el
-- número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base
-- imponible, y el total la suma de los dos campos anteriores.
select  sum(cantidad* precio_unidad) as base_imponible, sum(cantidad* precio_unidad) *0.21 as iva, 
sum(cantidad* precio_unidad) + sum(cantidad* precio_unidad) *0.21 as precio_final
from detalle_pedido;
-- 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
select  codigo_producto, sum(cantidad* precio_unidad) as base_imponible, sum(cantidad* precio_unidad) *0.21 as iva, 
sum(cantidad* precio_unidad) + sum(cantidad* precio_unidad) *0.21 as precio_final
from detalle_pedido group by codigo_producto;
-- 17. La misma información que en la pregunta anterior, pero agrupada por código de producto
-- filtrada por los códigos que empiecen por OR.
select  codigo_producto, sum(cantidad* precio_unidad) as base_imponible, sum(cantidad* precio_unidad) *0.21 as iva, 
sum(cantidad* precio_unidad) + sum(cantidad* precio_unidad) *0.21 as precio_final
from detalle_pedido where codigo_producto like 'or%' group by codigo_producto;
-- 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se
-- mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21%
-- IVA)
SELECT codigo_producto, SUM(cantidad) AS unidades_vendidas, 
       ROUND(SUM(cantidad * precio_unidad)) AS base_imponible, 
       ROUND(SUM(cantidad * precio_unidad) * 0.21) AS iva, 
       ROUND(SUM(cantidad * precio_unidad) + SUM(cantidad * precio_unidad) * 0.21) AS precio_final
FROM detalle_pedido
GROUP BY codigo_producto
HAVING precio_final > 3000;

-- Subconsultas con operadores básicos de comparación

-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente,limite_credito
FROM cliente ORDER BY limite_credito DESC limit 1;
-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT precio_venta,nombre
FROM producto 
ORDER BY precio_venta desc
LIMIT 1;
-- 3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta
-- que tendrá que calcular cuál es el número total de unidades que se han vendido de cada
-- producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código
-- del producto, puede obtener su nombre fácilmente.)*/
SELECT SUM(cantidad) as total_vendido,p.nombre
FROM detalle_pedido dp 
JOIN producto p on dp.codigo_producto=p.codigo_producto
GROUP BY dp.codigo_producto ORDER BY total_vendido desc ;

SELECT nombre
FROM producto p where 
(SELECT sum(cantidad) as total_vendido FROM detalle_pedido dp where dp.codigo_producto=p.codigo_producto)=
(SELECT sum(cantidad) as total from detalle_pedido  group by codigo_producto order by total desc limit 1);

SELECT
	SUM(cantidad) as cantidad,
    (SELECT nombre FROM producto as P WHERE P.codigo_producto = D.codigo_producto) as nombre_producto
FROM detalle_pedido as D
GROUP BY nombre_producto
ORDER BY cantidad DESC
LIMIT 1;
-- 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar
-- INNER JOIN).
SELECT codigo_cliente,nombre_cliente,limite_credito,
(SELECT SUM(total) as suma FROM pago p where p.codigo_cliente = c.codigo_cliente limit 1) as total
FROM cliente c
WHERE limite_credito > (SELECT SUM(total) as suma FROM pago p where p.codigo_cliente = c.codigo_cliente limit 1);
-- 5. Devuelve el producto que más unidades tiene en stock.
SELECT nombre,cantidad_en_stock,max(cantidad_en_stock)
FROM producto
GROUP BY nombre,cantidad_en_stock
ORDER BY cantidad_en_stock DESC ;

SELECT nombre, cantidad_en_stock 
FROM producto 
WHERE cantidad_en_stock= (SELECT MAX(cantidad_en_stock)FROM producto limit 1);
-- 6. Devuelve el producto que menos unidades tiene en stock.
SELECT nombre, cantidad_en_stock 
FROM producto 
WHERE cantidad_en_stock= (SELECT MIN(cantidad_en_stock)FROM producto limit 1);

SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock= (SELECT MIN(cantidad_en_stock)FROM producto limit 1);
-- 7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto
-- Soria.
SELECT nombre, concat(apellido1, ' ',apellido2) as apellidos,email,codigo_jefe
FROM empleado
WHERE codigo_jefe = (SELECT codigo_empleado FROM empleado WHERE nombre = 'alberto' and apellido1='soria');

-- Subconsultas con ALL y ANY

-- 1. Devuelve el nombre del cliente con mayor límite de crédito
SELECT nombre_cliente, limite_credito
FROM cliente
WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);
-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre, precio_venta
FROM producto
WHERE precio_venta >= ALL (SELECT precio_venta FROM producto);
-- 3. Devuelve el producto que menos unidades tiene en stock.
SELECT nombre,cantidad_en_stock
FROM producto
WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock FROM producto);

-- Subconsultas con IN y NOT IN

-- 1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún
-- cliente.
-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
-- 3. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
-- 4. Devuelve un listado de los productos que nunca han aparecido en un pedido.
-- 5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que
-- no sean representante de ventas de ningún cliente.

-- Subconsultas con EXISTS y NOT EXISTS

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
-- 2. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
-- 3. Devuelve un listado de los productos que nunca han aparecido en un pedido.
-- 4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
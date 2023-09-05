-- EJECICIO EXTRA N° 3 - POKEMONES

-- 1. Mostrar el nombre de todos los pokemon.
select nombre from pokemon;
-- 2. Mostrar los pokemon que pesen menos de 10k.
select nombre,peso from pokemon where peso<10;
-- 3. Mostrar los pokemon de tipo agua.
select * from pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
WHERE pt.id_tipo=1;
-- 4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo.
select * from pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
WHERE pt.id_tipo IN(1,6,13);
-- 5. Mostrar los pokemon que son de tipo fuego y volador.
select distinct p.numero_pokedex,p.nombre from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    where pt.id_tipo in (6,15) group by p.numero_pokedex,p.nombre
    HAVING COUNT(DISTINCT pt.id_tipo) = 2;    
-- 6. Mostrar los pokemon con una estadística base de ps mayor que 200.
select p.numero_pokedex,p.nombre,eb.ps from pokemon p
join estadisticas_base eb ON p.numero_pokedex=eb.numero_pokedex
WHERE eb.ps>200;
-- 7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.
select p.nombre,p.peso,p.altura from pokemon p
join evoluciona_de ev on p.numero_pokedex=ev.pokemon_origen
join pokemon q on ev.pokemon_evolucionado=q.numero_pokedex
where q.nombre='Arbok';
-- 8. Mostrar aquellos pokemon que evolucionan por intercambio.
select p.numero_pokedex, p.nombre, fe.tipo_evolucion from pokemon p
join pokemon_forma_evolucion pfe on p.numero_pokedex=pfe.numero_pokedex
join forma_evolucion fe on pfe.id_forma_evolucion=fe.id_forma_evolucion
where fe.tipo_evolucion=3;
-- 9. Mostrar el nombre del movimiento con más prioridad.
select m.id_movimiento,m.nombre,m.prioridad from movimiento m
order by prioridad desc limit 1;
-- 10. Mostrar el pokemon más pesado.
select * from pokemon order by peso desc limit 1;
-- 11. Mostrar el nombre y tipo del ataque con más potencia.
select ta.tipo,m.nombre,m.potencia from tipo_ataque ta
join tipo t on ta.id_tipo_ataque=t.id_tipo_ataque
join movimiento m on t.id_tipo=m.id_tipo
order by m.potencia desc limit 1;
-- 12. Mostrar el número de movimientos de cada tipo.
select t.id_tipo,t.nombre, count(*) AS cant_movs from movimiento m
join tipo t on t.id_tipo = m.id_tipo
group by t.id_tipo;
-- 13. Mostrar todos los movimientos que puedan envenenar.
select m.id_tipo 'Id Tipo', m.nombre 'Nombre'
    from movimiento m
    join tipo t on t.id_tipo = m.id_tipo
    where t.nombre like 'Ven%'
    group by m.id_tipo, m.nombre;
-- 14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre.
select distinct m.id_tipo, t.nombre, m.descripcion
    from movimiento m
    join tipo t on t.id_tipo = m.id_tipo
    where m.descripcion like '%causa daño%';
-- 15. Mostrar todos los movimientos que aprende pikachu.
select m.id_movimiento,m.nombre from movimiento m
join pokemon_tipo pt on m.id_tipo=pt.id_tipo
join pokemon p on pt.numero_pokedex=p.numero_pokedex
where p.nombre='Pikachu';
-- 16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje).
select m.id_movimiento,m.nombre as movimiento, fa.id_forma_aprendizaje from movimiento m
join pokemon_movimiento_forma pmf on m.id_movimiento=pmf.id_movimiento
join forma_aprendizaje fa on pmf.id_forma_aprendizaje=fa.id_forma_aprendizaje
where numero_pokedex=25 and id_tipo_aprendizaje=1;
-- 17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel.
select m.id_movimiento,m.nombre as movimiento, fa.id_forma_aprendizaje from movimiento m
join pokemon_movimiento_forma pmf on m.id_movimiento=pmf.id_movimiento
join forma_aprendizaje fa on pmf.id_forma_aprendizaje=fa.id_forma_aprendizaje
join tipo t on m.id_tipo=t.id_tipo
where numero_pokedex=25 and id_tipo_aprendizaje=3 and t.nombre='Normal';
-- 18. Mostrar todos los movimientos de efecto secundario cuya probabilidad sea mayor al 30%.
select m.nombre 'Movimiento', es.efecto_secundario 'Efecto secundario', mes.probabilidad 'Probabilidad'
    from movimiento m
    join movimiento_efecto_secundario mes on mes.id_movimiento = m.id_movimiento
    join efecto_secundario es on es.id_efecto_secundario = mes.id_efecto_secundario
    where mes.probabilidad > 30;
-- 19. Mostrar todos los pokemon que evolucionan por piedra.
select distinct p.numero_pokedex,p.nombre from pokemon p
join pokemon_forma_evolucion pfe on p.numero_pokedex=pfe.numero_pokedex
join forma_evolucion fe on pfe.id_forma_evolucion=fe.id_forma_evolucion
join piedra pd on fe.id_forma_evolucion=pd.id_forma_evolucion
join tipo_piedra tp on pd.id_tipo_piedra=tp.id_tipo_piedra;
-- 20. Mostrar todos los pokemon que no pueden evolucionar.
select * from pokemon p
left join evoluciona_de ev on p.numero_pokedex=ev.pokemon_origen
where ev.pokemon_origen is null;
-- 21. Mostrar la cantidad de los pokemon de cada tipo.
select t.nombre,count(*) as cantidad from pokemon p
join pokemon_tipo pt on p.numero_pokedex=pt.numero_pokedex
join tipo t on pt.id_tipo=t.id_tipo
group by t.nombre;
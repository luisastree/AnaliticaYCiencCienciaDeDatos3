/* 

Contexto

El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente acogedor. 
Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando información detallada sobre las transacciones 
de los clientes para identificar áreas de oportunidad y aprovechar al máximo sus datos para optimizar las ventas. 

Objetivo 

Identificar cuáles son los productos del menú que han tenido más éxito y cuales son los que menos han gustado a los clientes. 

Pasos a seguir 
a) Crear la base de datos con el archivo create_restaurant_db.sql 
b) Explorar la tabla “menu_items” para conocer los productos del menú.

 1.- Realizar consultas para contestar las siguientes preguntas: 

 ● Encontrar el número de artículos en el menú. 
 ● ¿Cuál es el artículo menos caro y el más caro en el menú?
 ● ¿Cuántos platos americanos hay en el menú? 
 ● ¿Cuál es el precio promedio de los platos? 
 
 c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 
 
1.- Realizar consultas para contestar las siguientes preguntas:

● ¿Cuántos pedidos únicos se realizaron en total?
● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos? 
● ¿Cuándo se realizó el primer pedido y el último pedido?
● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items). 

e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas.

El objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del 
restaurante en el lanzamiento de su nuevo menú. 
Para ello, crea tus propias consultas y utiliza los resultados obtenidos para llegar a 
estas conclusiones.*/

--b) Explorar la tabla “menu_items” para conocer los productos del menú.
select * 
from menu_items;

-- ● Encontrar el número de artículos en el menú. 
--32 Articulos

select count (menu_item_id) 
from menu_items;

--  ● ¿Cuál es el artículo menos caro y el más caro en el menú?


-- Mas economico item_name: Edamame, price:5

select item_name, price 
from menu_items
order by 2 asc
limit 1;

-- Mas costoso item_name: Shrimp Scampi, price: 19.95

select item_name, price
from menu_items
order by 2 desc
limit 1;



-- ● ¿Cuántos platos americanos hay en el menú? 

-- 6 platillos americanos

select count(menu_item_id)
from menu_items
where category = 'American';

-- ● ¿Cuál es el precio promedio de los platos? 

--Precio promedio: 13.29

select round(avg(price),2)
from menu_items;



 --c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 

select * 
from order_details;

-- ● ¿Cuántos pedidos únicos se realizaron en total?

-- Pedidos unicos 5,370

select count(distinct(order_id))
from order_details;

--  ● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos? 



select order_details_id, order_id, item_id
from order_details
where item_id is not null
order by 3 desc
limit 5;


-- ● ¿Cuándo se realizó el primer pedido y el último pedido?

--Primer pedido: 2023-01-01

select order_date
from order_details
order by order_date
limit 1;

-- Ultimo pedido: 2023-03-01

select order_date
from order_details
order by order_date desc
limit 1;

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

--Pedidos durante el periodo: 702

select count(order_details_id)
from order_details	
where order_date between '2023-01-01' and '2023-01-05';

/* 1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items). */

select * from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id;


/*...Para ello, crea tus propias consultas y utiliza los resultados obtenidos para llegar a 
estas conclusiones.*/

--Conteo de productos vendidos
select b.item_name, 
	   count(b.item_name)
from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id	
group by item_name
order by 2 desc;


--Top 3 de productos mas vendidos
select b.item_name, 
	   count(b.item_name)
from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id	
group by item_name
order by 2 desc
limit 3;

--Top 3 de productos menos vendidos
select b.item_name, 
count(b.item_name)
from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id	
where item_name is not null
group by item_name
order by 2 asc
limit 3;

-- Top 3 productos mas economicos

select item_name, price 
from menu_items
order by 2 asc
limit 3;

-- Top 3 productos mas costosos

select item_name, price
from menu_items
order by 2 desc
limit 3;

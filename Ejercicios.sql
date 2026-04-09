--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select title as Película , f.rating as Clasficacion
from film f 
where f.rating = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select a.first_name as Nombre , a.last_name as Apellido , a.actor_id 
from actor a 
where a.actor_id between 30 and 40 ;

--4. Obtén las películas cuyo idioma coincide con el idioma original.
select f.title as pelicula , f.language_id as id_idioma , f.original_language_id as id_idioma_original
from film f 
where f.language_id = f.original_language_id;

--5. Ordena las películas por duración de forma ascendente.
select f.title as película , f.length as duración
from film f 
order by duración asc ;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select a.first_name as Nombre , a.last_name as Apellido
from actor a 
where a.last_name like '%ALLEN%' ;

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select f.rating  as clasificacion, count(*) as total_peliculas
from film f 
group by f.rating ;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select f.title as pelicula , f.rating as clasifiacion , f.length as duracion
from film f 
where f.rating = 'PG-13' or f.length >180 ;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance(f.replacement_cost), 2) as variabilidad_reemplazo
from film f ;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max(f.length) as mayor_duracion , min(f.length) as menor_duracion
from film f ;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount as precio
from payment p 
order by p.payment_date desc
limit 1 offset 2;

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select f.title as pelicula , f.rating as clasificacion
from film f 
where f.rating not in ('NC-17', 'G') ;

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select round(avg(f.length), 2) as promedio_duracion , f.rating as clasificacion
from film f 
group by f.rating ;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select f.title as pelicula , f.length as duracion  
from film f 
where f.length >180 ;

--15. ¿Cuánto dinero ha generado en total la empresa?
select sum(p.amount) as total_ingresos
from payment p ;

--16. Muestra los 10 clientes con mayor valor de id.
select c.first_name as nombre , c.last_name as apellido , c.customer_id id_cliente
from customer c 
order by c.customer_id desc 
limit 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select a.first_name as nombre , a.last_name as apellido
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film f
on fa.film_id = f.film_id
where f.title = 'EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.
select distinct f.title as pelicula 
from film f ;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f.title as pelicula , c."name" as categoria , f.length as duracion
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c."name" = 'Comedy' and f.length >180 ;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c.name as categoria,
       round(avg(f.length), 2) as promedio_duracion
from category c
inner join film_category fc
on c.category_id = fc.category_id
inner join film f
on fc.film_id = f.film_id
group by c.name
having avg(f.length) > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?
select round(extract(day from avg(return_date - rental_date))) as duracion_media_alquiler 
from rental r ;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(a.first_name, ' ' , a.last_name) as nombre_completo
from actor a ;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select r.rental_date as fecha_alquiler , count(*) as total_alquileres
from rental r 
group by r.rental_date 
order by total_alquileres desc;

--24. Encuentra las películas con una duración superior al promedio.
select f.title as pelicula , f.length as duracion
from film f 
where f.length > (
    select avg(f.length)
    from film f
);

--25. Averigua el número de alquileres registrados por mes.
select extract(month from rental_date) as mes,
       count(*) as numero_alquileres
from rental
group by mes
order by mes;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select round(avg(p.amount), 2) as promedio , round(stddev(p.amount), 2) as desviacion_estandar , round(variance(p.amount), 2) as varianza
from payment p ;

--27. ¿Qué películas se alquilan por encima del precio medio?
select f.title as pelicula , f.rental_rate as precio
from film f 
where f.rental_rate > (
    select avg(f.rental_rate)
    from film f
);

--28. Muestra el id de los actores que hayan participado en más de 40 películas.
select fa.actor_id , count(fa.film_id) as peliculas_totales
from film_actor fa 
group by fa.actor_id 
having count(fa.film_id) > 40 ;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select f.film_id as id_pelicula, f.title as titulo, count(i.inventory_id) as cantidad_disponible
from film f 
left join inventory i on f.film_id = i.film_id
group by f.film_id, f.title;


--30. Obtener los actores y el número de películas en las que ha actuado.
select a.actor_id, a.first_name as nombre , a.last_name as apellido , count(fa.film_id) as peliculas_participadas
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name , a.last_name;


--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.title as pelicula , a.first_name as nombre , a.last_name as apellido 
from film f 
left join film_actor fa 
on f.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id ;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select a.first_name as Nombre , a.last_name as Apellido , f.title as pelicula
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
left join film f 
on fa.film_id = f.film_id ;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title as Pelicula , i.inventory_id as registro_alquiler
from film f 
left join inventory i 
on f.film_id = i.film_id
left join rental r 
on i.inventory_id = r.inventory_id ;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c.first_name as Nombre , c.last_name as Apellido , sum(p.amount) as total_gastado
from customer c 
inner join payment p 
on c.customer_id = p.customer_id
group by c.first_name , c.last_name 
order by total_gastado desc
limit 5 ;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select a.first_name as Nombre , a.last_name as Apellido
from actor a 
where a.first_name = 'JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select a.first_name as Nombre , a.last_name as Apellido
from actor a ;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min(a.actor_id) as id_menor , max(a.actor_id) as id_mayor
from actor a ;

--38. Cuenta cuántos actores hay en la tabla “actor”.
select count(a.actor_id) as actores_totales
from actor a ;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select a.last_name as apellido , a.first_name as nombre
from actor a 
order by a.last_name asc ;

--40. Selecciona las primeras 5 películas de la tabla “film”.
select f.title as pelicula
from film f 
limit 5 ;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select a.first_name as nombre , count(*) as cantidad
from actor a 
group by a.first_name 
order by cantidad desc ;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id as alquiler , c.first_name as nombre , c.last_name as apellido
from rental r 
inner join customer c 
on r.customer_id = c.customer_id ;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select c.customer_id as id_cliente , c.first_name as nombre , c.last_name as apellido , (r.rental_id) as alquiler 
from customer c 
left join rental r 
on c.customer_id = r.customer_id
order by c.customer_id ;


--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f 
cross join category c ;
--No aporta mucho valor en este caso porque arroja todas las combinaciones de datos posibles, lo que genera una lista demasiado numerosa de datos 
--y no refleja la relación real entre películas y categorías.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select distinct a.first_name as nombre , a.last_name as apellido , c."name" as categoria 
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film_category fc 
on fa.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Action' ;

--46. Encuentra todos los actores que no han participado en películas.
select a.first_name as nombre , a.last_name as apellido
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
where fa.actor_id is null ;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select a.first_name as nombre , a.last_name as apellido , count(fa.film_id) as peliculas_participadas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
group by a.first_name , a.last_name 
order by peliculas_participadas desc ;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select a.first_name as nombre , a.last_name as apellido , count(fa.film_id) as peliculas_participadas
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
group by a.first_name , a.last_name 
order by peliculas_participadas desc ;

select *
from actor_num_peliculas ;

--49. Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id as id_cliente , c.first_name as nombre , c.last_name as apellido , count(r.rental_id) as total_alquileres 
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
group by nombre, apellido, id_cliente ;

--50. Calcula la duración total de las películas en la categoría 'Action'.
select sum(f.length) as duracion_total
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c."name" = 'Action' ;

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
select c.customer_id as id_cliente , c.first_name as nombre , c.last_name as apellido , count(r.rental_id) as total_alquileres 
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
group by nombre, apellido, id_cliente ;

select count(id_cliente)
from cliente_rentas_temporal ;

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select f.film_id as id_pelicula , f.title as pelicula , count(r.rental_id) as total_alquileres
from film f
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
group by f.film_id, f.title
having count(r.rental_id) >= 10
order by total_alquileres desc ;

select pelicula , total_alquileres
from peliculas_alquiladas
where total_alquileres >20 ;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select c.first_name as nombre , c.last_name as apellido , f.title as pelicula , r.rental_date as fecha_alquiler , r.return_date as fecha_devolucion
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
where c.first_name = 'TAMMY' and c.last_name  = 'SANDERS' and r.return_date is null 
order by pelicula asc;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select distinct a.last_name as apellido , a.first_name as nombre 
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film_category fc 
on fa.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Sci-Fi' 
order by a.last_name asc;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
select distinct a.last_name as apellido , a.first_name as nombre 
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join inventory i on fa.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
where r.rental_date > (
    select min(r2.rental_date)
    from rental r2 
    inner join inventory i2 on r2.inventory_id = i2.inventory_id
    inner join film f2 on i2.film_id = f2.film_id
    where f2.title = 'SPARTACUS CHEAPER'
)
order by a.last_name, a.first_name;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select a.first_name as nombre , a.last_name as apellido
from actor a 
where not exists (
      select 1
      from film_actor fa
      inner join film_category fc on fa.film_id = fc.film_id
      inner join category c on fc.category_id = c.category_id
      where fa.actor_id = a.actor_id
      and c.name = 'Music'
)
order by a.last_name, a.first_name;

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select f.title as pelicula , r.rental_date as fecaha_alquiler , r.return_date as fecha_devolucion
from film f 
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
where r.return_date is not null
  and (r.return_date - r.rental_date) > interval '8 days';

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select f.title as pelicula , c."name" as categoria 
from film f 
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where c."name" = 'Animation' ;

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select f.title as pelicula , f.length as duracion
from film f 
where f.length = (
    select f2.length 
    from film f2 
    where f2.title  = 'DANCING FEVER'
) 
order by f.title ;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select c.first_name as nombre , c.last_name as apellido , count(distinct i.film_id) as peliculas_alquiladas
from customer c 
inner join rental r on c.customer_id = r.customer_id
inner join inventory i on r.inventory_id = i.inventory_id
group by c.customer_id , c.first_name , c.last_name 
having count(distinct i.film_id) >= 7
order by c.last_name, c.first_name;

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c.name as categoria,
       count(r.rental_id) as total_alquileres
from category c
inner join film_category fc on c.category_id = fc.category_id
inner join film f on fc.film_id = f.film_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
group by c.name
order by total_alquileres desc;

--62. Encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as categoria, count(f.film_id) as total_peliculas 
from category c 
join film_category fc on c.category_id = fc.category_id 
join film f on fc.film_id = f.film_id 
where f.release_year = 2006 
group by c."name"  
order by total_peliculas desc;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select *
from staff s2  
cross join store s ;

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c.customer_id as id_cliente , c.first_name as nombre , c.last_name as apellido , count(r.rental_id) as total_alquileres
from customer c
inner join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc;




 
     




















     





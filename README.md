📊 Proyecto SQL – Análisis de Base de Datos Sakila
🧾 Descripción
Este proyecto consiste en el análisis de la base de datos Sakila mediante consultas SQL. El objetivo es practicar operaciones como JOIN, GROUP BY, funciones agregadas, subconsultas y filtrado de datos para extraer información relevante sobre películas, clientes, alquileres y categorías.

⚙️ Herramientas utilizadas
DBeaver como cliente SQL
Base de datos: Sakila (PostgreSQL)
Lenguaje: SQL

📌 Objetivos del proyecto
Consultar información de múltiples tablas relacionadas
Aplicar JOINs (INNER, LEFT, CROSS)
Utilizar funciones agregadas (COUNT, AVG, MAX, MIN, VARIANCE)
Trabajar con subconsultas
Filtrar datos con WHERE y HAVING
Ordenar resultados
Manejar fechas y diferencias temporales

🧠 Conceptos trabajados
🔗 JOINs
INNER JOIN
LEFT JOIN
CROSS JOIN
📊 Agregaciones
COUNT()
AVG()
MAX()
MIN()
VARIANCE()
🧾 Agrupaciones
GROUP BY 
HAVING 
🔍 Subconsultas
📅 Fechas
Cálculo de diferencias entre fechas (rental_date y return_date)
Extracción de partes de fechas (mes, día)

🗂️ Estructura de la base de datos (tablas principales)
film
actor
customer
rental
inventory
category
film_category
film_actor
language

📋 Ejemplos de análisis realizados
1. Películas por clasificación
Conteo total de películas agrupadas por rating
2. Películas por categoría
Número de películas y duración media por categoría
3. Alquileres
Total de alquileres por cliente
Alquileres por mes
Duración de los alquileres
4. Actores
Número de películas por actor
Actores que no han participado en películas
5. Clientes
Clientes con mayor número de alquileres
Clientes que han alquilado más de N películas distintas
6. Análisis de películas
Películas con duración superior al promedio
Películas alquiladas por encima de cierto tiempo
Películas por idioma

📈 Conclusiones
Durante el desarrollo del proyecto se ha podido entender mejor cómo está estructurada la base de datos Sakila y cómo se relacionan sus tablas entre sí. A medida que se fueron realizando las consultas, se aprecia que muchas de las preguntas no se pueden responder desde una sola tabla, sino que requieren recorrer varias relaciones.
Uno de los puntos clave del análisis ha sido identificar correctamente esas relaciones. Por ejemplo, para obtener información sobre actores y películas, es necesario pasar por la tabla intermedia correspondiente, ya que no existe una relación directa. 
También se ha visto la importancia de distinguir entre los distintos tipos de datos que almacena la base. Algunas tablas contienen información descriptiva, mientras que otras registran acciones o eventos, como los alquileres.
En general, el proyecto ha servido para familiarizarse con la estructura del modelo de datos y para aprender a moverse dentro de él, identificando qué tablas utilizar en cada caso y cómo combinarlas para responder a distintas preguntas.

📌 Autor
Proyecto realizado por Vanesa Cores como práctica de SQL sobre la base de datos Sakila 



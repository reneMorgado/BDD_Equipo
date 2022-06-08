/*Práctica de optimización de consultas
Listado de consultas a programar para analizar planes de ejecucion
1. Listar los casos positivos por entidad de residencia 
2.-Listar los casos sospechosos por entidad
3.- Listar el Top 5 de municipios por entidad con el mayor numero 
de casos reportados, indicando casos sospechosos y casos confirmados
4.- Determinar el municipio con el mayor número de defunciones en casos confirmados.
5. Determinar por entidad, si de casos sospechosos hay defunciones reportadas asociadas a neumonia.
6. Listar por entidad el total de casos sospechosos, casos confirmados, total de defunciones en los meses de marzo a agosto 2020 y de diciembre 2020 a mayo 2021.
7. Listar los 5 municipios con el mayor número de casos confirmados en niños menos de 13 años con alguna comorbilidad reportada y cuantos de esos casos fallecieron.
8. Determinar si en el año 2020 hay una mayor cantidad de defunciones menores de edad que en el año 2021 y 2022.
9. Determinar si en el año 2021 hay un pocentaje mayor al 60 de casos reportados que son confirmados por estudios de laboratorio en comparación al año 2020.
10. Determinar en que rango de edad: menor de edad, 19 a 40, 40 a 60 o mayor de 60 hay mas casos reportados que se hayan recuperado.
*/

use covidHistorico;

-- 1 Listar los casos potivos por entidad de residencia

--OPCION 1
select *
from dbo.datoscovid
where CLASIFICACION_FINAL between 1 and 3
order by ENTIDAD_RES

--OPCION 2
select ENTIDAD_RES, count(*) total_Confirmado
from dbo.datoscovid where 
CLASIFICACION_FINAL between 1 and 3
group by ENTIDAD_RES
order by ENTIDAD_RES;

-- 2 Listar los casos sospechosos por entidad

--OPCION 1
select ENTIDAD_UM, ENTIDAD_RES, count(*) total_sospechosos
from dbo.datoscovid
where CLASIFICACION_FINAL = 6
group by ENTIDAD_UM, ENTIDAD_RES
order by ENTIDAD_UM 

--OPCION 2


-- 3 Listar el top 5 de municipios por entidad con el mayor número de casos reportados, 
   --indicando casos sospechosos y casos confirmados.

--OPCION 1
select cc.ENTIDAD_RES, cc.MUNICIPIO_RES, cc.confirmado, cs.sospechoso
from (select ENTIDAD_RES, MUNICIPIO_RES, count(*) as sospechoso 
      from dbo.datoscovid where CLASIFICACION_FINAL = 6
	  group by ENTIDAD_RES, MUNICIPIO_RES
      ) cs
inner join
(select ENTIDAD_RES, MUNICIPIO_RES, count (*) as confirmado 
 from dbo.datoscovid where CLASIFICACION_FINAL between 1 and 3
 group by ENTIDAD_RES, MUNICIPIO_RES) cc 
on cc.ENTIDAD_RES =  cs.ENTIDAD_RES and cs.MUNICIPIO_RES = cc.MUNICIPIO_RES
order by cc.ENTIDAD_RES, cc.MUNICIPIO_RES

--OPCION 2


-- 4 Determinar el municipio con el mayor número de defunciones en casos confirmados.

--OPCION 1
select MUNICIPIO_RES, COUNT(*) as numero_Defunciones
from dbo.datoscovid
where CLASIFICACION_FINAL between 1 and 3 and FECHA_DEF != '9999-99-99'
group by MUNICIPIO_RES 
having COUNT(*) = ( select max(numero_Defunciones)
					from (
						select MUNICIPIO_RES, COUNT(*) as numero_Defunciones
						from dbo.datoscovid
						where CLASIFICACION_FINAL between 1 and 3 and FECHA_DEF != '9999-99-99'
						group by MUNICIPIO_RES ) as aux )

--OPCION 2



-- 5  Determinar por entidad, si de casos sospechosos hay defunciones reportadas asociadas a neumonia.

--OPCION 1
select ENTIDAD_RES, count(*)
from dbo.datoscovid
where CLASIFICACION_FINAL = 6 and FECHA_DEF != '9999-99-99' and NEUMONIA = 1
group by ENTIDAD_RES

--OPCION 2


-- 6. Listar por entidad el total de casos sospechosos, casos confirmados, total de defunciones en los meses de marzo a agosto 2020 y de 
	--diciembre 2020 a mayo 2021.


--OPCION 1
Select ENTIDAD_RES, count(case CLASIFICACION_FINAL when 6 then CLASIFICACION_FINAL end) as sospechoso, 
	count(*) as reportados, count(case CLASIFICACION_FINAL when 1 then CLASIFICACION_FINAL 
                                                           when 2 then CLASIFICACION_FINAL
		               									   when 3 then CLASIFICACION_FINAL
    end) as confirmado, COUNT( case when  FECHA_DEF != '9999-99-99' then FECHA_DEF end ) as total_Defunciones      
from dbo.datoscovid
where FECHA_INGRESO between '2020-03-01' and '2020-08-31' or FECHA_INGRESO between '2021-05-01' and '2021-12-31' 
group by ENTIDAD_RES
order by ENTIDAD_RES

--OPCION 2


-- 7. Listar los 5 municipios con el mayor número de casos confirmados en niños menos de 13 años con alguna comorbilidad reportada y 
	--cuantos de esos casos fallecieron.

--OPCION 1
Select top 5 MUNICIPIO_RES, count(case CLASIFICACION_FINAL when 1 then CLASIFICACION_FINAL 
                                                     when 2 then CLASIFICACION_FINAL
						      						 when 3 then CLASIFICACION_FINAL
                                          end) as confirmado, 
					  COUNT( case when  FECHA_DEF != '9999-99-99' then FECHA_DEF end ) as total_Defunciones  
from dbo.datoscovid
where EDAD < 13  and ID_REGISTRO in ( select ID_REGISTRO
									  from dbo.datoscovid
									  where EDAD < 13 and ( (NEUMONIA = 1 and DIABETES = 1) or (NEUMONIA = 1 and ASMA = 1) 
														or (NEUMONIA = 1 and HIPERTENSION = 1) or (DIABETES = 1 and ASMA = 1) 
														or (DIABETES = 1 and HIPERTENSION = 1) or (ASMA = 1 and HIPERTENSION = 1)) )
group by MUNICIPIO_RES
order by confirmado desc

--OPCION 2


-- 8. Determinar si en el año 2020 hay una mayor cantidad de defunciones menores de edad que en el año 2021 y 2022.

--OPCION 1
Declare @cant2020 int, @cant2021 int, @cant2022 int
set @cant2020 = ( Select COUNT( case when  FECHA_DEF like '2020-%' then FECHA_DEF end ) as total_Defunciones  
				  from dbo.datoscovid
				  where EDAD < 18 ) -- 1776
set @cant2021 = ( Select COUNT( case when  FECHA_DEF like '2021-%' then FECHA_DEF end ) as total_Defunciones  
				  from dbo.datoscovid
				  where EDAD < 18 ) -- 1636
set @cant2022 = ( Select COUNT( case when  FECHA_DEF like '2022-%' then FECHA_DEF end ) as total_Defunciones  
				  from dbo.datoscovid
				  where EDAD < 18 ) -- 314

IF @cant2020 > @cant2021 and @cant2020 > @cant2022
	print 'En el año 2020 hubo una mayor cantidad de defunciones en personas menores de edad que en el año 2021 y 2022'
ELSE
	print 'En el año 2020 NO hubo una mayor cantidad de defunciones en personas menores de edad que en el año 2021 y 2022'

--OPCION 2


-- 9. Determinar si en el año 2021 hay un pocentaje mayor al 60 de casos reportados que son confirmados por estudios de laboratorio 
	--en comparación al año 2020.

--OPCION 1
Declare @porcentaje2021 int, @porcentaje2020 int

set @porcentaje2021 = ( Select ( Select count(*)
								from dbo.datoscovid
								where FECHA_INGRESO like '2021-%' and CLASIFICACION_FINAL = 3 ) *100/ COUNT(*) as Confirmados_Laboratorio
						from dbo.datoscovid
						where FECHA_INGRESO like '2021-%' )

set @porcentaje2020 = ( Select ( Select count(*)
								from dbo.datoscovid
								where FECHA_INGRESO like '2020-%' and CLASIFICACION_FINAL = 3 ) *100/ COUNT(*) as Confirmados_Laboratorio
						from dbo.datoscovid
						where FECHA_INGRESO like '2020-%' )

if @porcentaje2021 > @porcentaje2020
	print 'En el año 2021 hay un pocentaje mayor de casos reportados que son confirmados por estudios de laboratorio en comparación al año 2020.'
else
	print 'En el año 2020 hay un pocentaje mayor de casos reportados que son confirmados por estudios de laboratorio en comparación al año 2021.'

--OPCION 2


-- 10. Determinar en que rango de edad: menor de edad, 19 a 40, 40 a 60 o mayor de 60 hay mas casos reportados que se hayan recuperado. 

--OPCION 1
SELECT *from
	( select 'menor de edad' as Rango_Edad, COUNT(*) as Recuperados
	from dbo.datoscovid
	where EDAD < 18 and FECHA_DEF = '9999-99-99'
	UNION ALL
	select '19 a 40' as Rango_Edad, COUNT(*) as Recuperados
	from dbo.datoscovid
	where EDAD between 19 and 40 and FECHA_DEF = '9999-99-99'
	UNION ALL
	select '40 a 60' as Rango_Edad, COUNT(*) as Recuperados
	from dbo.datoscovid
	where EDAD between 40 and 60 and FECHA_DEF = '9999-99-99'
	UNION ALL
	select 'mayor a 60' as Rango_Edad, COUNT(*) as Recuperados
	from dbo.datoscovid
	where EDAD > 60 and FECHA_DEF = '9999-99-99' ) as aux
where aux.Recuperados = (  SELECT MAX(aux2.Recuperados)
						from
							( select 'menor de edad' as Rango_Edad, COUNT(*) as Recuperados
							from dbo.datoscovid
							where EDAD < 18 and FECHA_DEF = '9999-99-99'
							UNION ALL
							select '19 a 40' as Rango_Edad, COUNT(*) as Recuperados
							from dbo.datoscovid
							where EDAD between 19 and 40 and FECHA_DEF = '9999-99-99'
							UNION ALL
							select '40 a 60' as Rango_Edad, COUNT(*) as Recuperados
							from dbo.datoscovid
							where EDAD between 40 and 60 and FECHA_DEF = '9999-99-99'
							UNION ALL
							select 'mayor a 60' as Rango_Edad, COUNT(*) as Recuperados
							from dbo.datoscovid
							where EDAD > 60 and FECHA_DEF = '9999-99-99' ) as aux2 )
--OPCION 2




/*
1)
Crear una base de datos en Mysql en la maquina local que se llame 
“miPrimerNombre” + “yyyyMMdd”, guardar los scripts usados para crear las tablas.
*/
CREATE DATABASE IF NOT EXISTS hugo20220211


/*
2)
Debe tener las siguientes tablas:

o tresource_type:
	- idResourceType int autoincrement PK
	- created datetime
	- descrip varchar(200)

o tresource:
	- idResource int autoincrement PK
	- created datetime
	- descrip varchar(200)
	- idResourceType int FK

*/
CREATE TABLE IF NOT EXISTS tresource_type (
	idResourceType INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria',
	created DATETIME COMMENT 'Fecha de creacion del tipo de recurso',
	descript VARCHAR(200) COMMENT 'Descripcion del tipo de recurso',	
	PRIMARY KEY (idResourceType)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de tipos de recursos';

CREATE TABLE IF NOT EXISTS tresource (
	idResource INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria',
	created DATETIME COMMENT 'Fecha de creacion del recurso',
	descript VARCHAR(200) COMMENT 'Descripcion del recurso',
	idResourceType INT UNSIGNED COMMENT 'Llave foranea',
	
	PRIMARY KEY (idResource),
	FOREIGN KEY (idResourceType) REFERENCES tresource_type(idResourceType)
	ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de recursos';


/*
3)
Las tabla de tipos de recursos debe tener los siguientes valores: 
(guardar los inserts utilizados para poblar la tabla)

o Vídeo
o PDF Documentación
o PDF Enunciado
o PDF Solución
*/
INSERT INTO tresource_type (created, descript) VALUES (NOW(), 'Vídeo');
INSERT INTO tresource_type (created, descript) VALUES (NOW(), 'PDF Documentación');
INSERT INTO tresource_type (created, descript) VALUES (NOW(), 'PDF Enunciado');
INSERT INTO tresource_type (created, descript) VALUES (NOW(), 'PDF Solución'); 


/*
4)
Se deben crear al menos 6 registros en la tabla tresource y que estén clasificados 
según los datos de tresource_type. (guardar los inserts utilizados para poblar la tabla)
*/
INSERT INTO tresource (created, descript, idResourceType) VALUES (NOW(), 'Recurso de Vídeo', 1);
INSERT INTO tresource (created, descript, idResourceType) VALUES (NOW(), 'Recurso de PDF Documentación', 2);
INSERT INTO tresource (created, descript, idResourceType) VALUES (NOW(), 'Recurso de PDF Enunciado', 3);
INSERT INTO tresource (created, descript, idResourceType) VALUES (NOW(), 'Recurso de PDF Solución', 4);
INSERT INTO tresource (created, descript, idResourceType) VALUES (NOW(), 'Recurso de Vídeo 2', 1);
INSERT INTO tresource (created, descript, idResourceType) VALUES (NOW(), 'Recurso de PDF Documentación 2', 2);

/*
5)
Se debe hacer una query que cuente cuantos registros hay por tipo de recurso. (guardar la query)
*/
SELECT 
	tt.descript AS 'Tipo de recurso', 
	COUNT(*) AS Cantidad 
FROM 
	tresource 
INNER JOIN 
	tresource_type AS tt
	USING 
		(idResourceType)
GROUP BY 
	idResourceType;
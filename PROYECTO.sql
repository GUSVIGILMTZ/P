bd_bibliotecaCREATE DATABASE BD_BIBLIOTECA
USE BD_BIBLIOTECA
DROP DATABASE BD_BIBLIOTECA
bd_bibliotecaCREATE TABLE CATEGORIA
(
	Cve_Categoria VARCHAR(4),
	Nombre_C VARCHAR(50),
	Cantidad_C VARCHAR(3),
	CONSTRAINT pk_1 PRIMARY KEY (Cve_Categoria)
)
CREATE TABLE AUTOR
(
	Cve_Autor VARCHAR(4),
	Nombre_A VARCHAR(50),
	Apellido_A VARCHAR(50),
	Pais VARCHAR(20),
	CONSTRAINT pk_2 PRIMARY KEY (Cve_Autor)
)
CREATE TABLE EDITORIAL
(
	Cve_Editorial VARCHAR(4),
	Nombre_E VARCHAR(50),
	CONSTRAINT pk_3 PRIMARY KEY (Cve_Editorial)
)
CREATE TABLE LECTOR
(
	Cve_Lector VARCHAR(4),
	Nombre_LE VARCHAR(20),
	Edad_L VARCHAR(3),
	CONSTRAINT pk_4 PRIMARY KEY (Cve_Lector)
)
CREATE TABLE LIBRO
(
	Cve_Libro VARCHAR(4),
	Nombre_LI VARCHAR(50),
	Estado_L VARCHAR(50),
	Cve_Categoria1 VARCHAR(4),
	Cve_Editorial2 VARCHAR(4),
	Cve_Autor3 VARCHAR(4),
	CONSTRAINT pk_5 PRIMARY KEY (Cve_Libro),
	CONSTRAINT fk_cat1 FOREIGN KEY (Cve_Categoria1) REFERENCES categoria (Cve_Categoria),
	CONSTRAINT fk_edi2 FOREIGN KEY (Cve_Editorial2) REFERENCES EDITORIAL (Cve_Editorial),
	CONSTRAINT fk_aut3 FOREIGN KEY (Cve_Autor3) REFERENCES AUTOR (Cve_Autor)
)
CREATE TABLE PRESTAMO 
(
	Cve_Prestamo VARCHAR(4),
	Fecha_SalP VARCHAR(20),
	Fecha_EntradaP VARCHAR(20),
	Cve_Libro1 VARCHAR(4),
	Cve_Lector2 VARCHAR(4),
	CONSTRAINT pk_6 PRIMARY KEY (Cve_Prestamo),
	CONSTRAINT fk_lib1 FOREIGN KEY (Cve_Libro1) REFERENCES LIBRO (Cve_Libro),
	CONSTRAINT fk_lec2 FOREIGN KEY (Cve_Lector2) REFERENCES LECTOR (Cve_Lector)
)
INSERT INTO Categoria VALUES 
('CA01','Drama','100'),
('CA02','Terror','60'),
('CA03','fixion','104'),
('CA04','Literatura','107'),
('CA05','Historia','196'),
('CA06','Matematicas','108'),
('CA07','Cuentos','271'),
('CA08','Contaduria','118'),
('CA09','Cultura','161'),
('CA10','Ciencia','103')

INSERT INTO AUTOR VALUES 
('AU01','Edgar','Allan','USA'),
('AU02','Jane','Austen','Guatemala'),
('AU03','Miguel','de cervantes','El salvador'),
('AU04','Agatha','Chistie','Brasil'),
('AU05','Paulo','Coelho','Mexico'),
('AU06','Charles','Dickens','Italia'),
('AU07','Ken','Folled','Francia'),
('AU08','Federico','Garcia','Canada'),
('AU09','Pablo','Neruda','Chile'),
('AU10','Julio','Verne','Peru')

INSERT INTO Editorial VALUES 
('ED01','Elpan'),
('ED02','Eina'),
('ED03','Cuadriculado'),
('ED04','Hoja en blanco'),
('ED05','Hoja de papel'),
('ED06','Rayado'),
('ED07','La luna'),
('ED08','Triangulo'),
('ED09','Garcia'),
('ED10','Libros BIG')

INSERT INTO lector VALUES 
('LE01','Diego','21'),
('LE02','Carlos','17'),
('LE03','Manuel','18'),
('LE04','Josue','14'),
('LE05','jaime','15'),
('LE06','Victor','17'),
('LE07','Angel','21'),
('LE08','Diego','22'),
('LE09','Citlali','18'),
('LE10','Ana','19')

INSERT INTO Libro VALUES 
('LI01','Caperusita','Prestado','CA07','ED04','AU03'),
('LI02','Los tres cerditos','Perdido','CA08','ED10','AU08'),
('LI03','Atlas','Entregado','CA10','ED03','AU02'),
('LI04','Mexico','Pagado','CA05','ED06','AU07'),
('LI05','Romeo y Julieta','Prestado','CA01','ED05','AU10'),
('LI06','Dralectorcula','Entregado','CA02','ED01','AU01'),
('LI07','El Cuervo','Perdido','CA06','ED09','AU05'),
('LI08','El señor de los anillos','Entregado','CA03','ED07','AU09'),
('LI09','Los juegos de labre','Prestado','CA09','ED02','AU04'),
('LI10','Cartas a los muertos','Perdido','CA04','ED08','AU06')

INSERT INTO PRESTAMO VALUES 
('PR01','18/01/2023','24/01/2023','LI04','LE08'),
('PR02','14/06/2023','20/06/2023','LI08','LE02'),
('PR03','25/08/2023','30/08/2023','LI05','LE09'),
('PR04','17/03/2023','19/03/2023','LI07','LE05'),
('PR05','24/06/2023','01/07/2023','LI10','LE10'),
('PR06','03/07/2023','05/07/2023','LI01','LE01'),
('PR07','06/05/2023','11/05/2023','LI03','LE06'),
('PR08','23/03/2023','27/03/2023','LI09','LE03'),
('PR09','27/04/2023','01/05/2023','LI02','LE07'),
('PR10','19/05/2023','20/05/2023','LI06','LE04')

SELECT * FROM categoria
SELECT * FROM AUTOR
SELECT * FROM Editorial
SELECT * FROM lector
SELECT * FROM Libro
SELECT * FROM prestamo

/*Nombre, Categoria, Estado de los libros prestados*/

SELECT Nombre_LI, Nombre_C, Estado_L
FROM categoria INNER JOIN libro
ON libro.Cve_Categoria1 = categoria.Cve_Categoria
WHERE libro.Estado_L = 'Prestado'

/*Editoriales de los libros entregados*/

SELECT Nombre_E, Nombre_LI, Estado_L
FROM editorial INNER JOIN libro 
ON libro.Cve_Editorial2 = editorial.Cve_Editorial
WHERE libro.Estado_L = 'Entregado'

/*Qué lectores tienen prestados los libros*/

SELECT Nombre_LE, Estado_L
FROM libro INNER JOIN prestamo
ON prestamo.Cve_Libro1 = libro.Cve_Libro
INNER JOIN lector
ON prestamo.Cve_Lector2 = lector.Cve_Lector
WHERE libro.Estado_L = 'Prestado'

/*Libro, Lector, Categoria que tienen prestados los libros*/

SELECT Nombre_LI, Nombre_LE, Nombre_C, Estado_L
FROM lector INNER JOIN prestamo 
ON lector.Cve_Lector = prestamo.Cve_Lector2
INNER JOIN libro
ON prestamo.Cve_Libro1 = libro.Cve_Libro
INNER JOIN categoria 
ON libro.Cve_Categoria1 = categoria.Cve_Categoria
WHERE libro.Estado_L = 'Prestado'

/*Libro, Lector, Categoria que tienen perdidos los libros*/

SELECT Nombre_LI, Nombre_LE, Nombre_C, Estado_L
FROM lector INNER JOIN prestamo 
ON lector.Cve_Lector = prestamo.Cve_Lector2
INNER JOIN libro
ON prestamo.Cve_Libro1 = libro.Cve_Libro
INNER JOIN categoria 
ON libro.Cve_Categoria1 = categoria.Cve_Categoria
WHERE libro.Estado_L = 'Perdido'

/*Libros, Autores, editoriales, categorias y lectores que tienen libros prestados*/

SELECT Nombre_LI, Nombre_A, Nombre_E, Nombre_C, Nombre_LE, Estado_L
FROM libro INNER JOIN categoria
ON libro.Cve_Categoria1 = categoria.Cve_Categoria
INNER JOIN editorial
ON libro.Cve_Editorial2 = editorial.Cve_Editorial
INNER JOIN autor
ON libro.Cve_Autor3 = autor.Cve_Autor
INNER JOIN prestamo
ON libro.Cve_Libro = prestamo.Cve_Libro1
INNER JOIN lector 
ON prestamo.Cve_Lector2 = lector.Cve_Lector 
WHERE libro.Estado_L = 'Prestado'





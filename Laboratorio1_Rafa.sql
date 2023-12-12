
	/*CREDO POR: Rafael González Méndez*/
		
	CREATE DATABASE Laboratorio1_RAFA
	GO

	USE Laboratorio1_RAFA
	GO

	Alter authorization on database::Laboratorio1_RAFA to sa
	GO

	SET DATEFORMAT dmy
	SET LANGUAGE spanish
	GO

	/*Creación de las tablas*/
	CREATE TABLE [dbo].[CLIENTES](
		[CODIGO_CLIENTE] [numeric](5, 0)	NOT NULL,
		[NOMBRE] [varchar](25)				NULL,
		[DIRECCION] [varchar](50)			NULL,
		[PROVINCIA] [varchar](20)			NULL,
		[TELEFONO] [varchar](11)			NULL,
		[FAX] [varchar](11)					NULL,
	 CONSTRAINT [PK_CLIENTES] PRIMARY KEY ([CODIGO_CLIENTE]),

	) 
	GO

	CREATE TABLE PROYECTOS (
		COD_PROYECTO VARCHAR(5) NOT NULL,
		DESCRIPCION VARCHAR(60) NULL,
		COSTO_TOTAL NUMERIC(10,2) NULL,
		FEC_INICIO DATE NULL,
		FEC_FIN DATE NULL,
		[CODIGO_CLIENTE] [numeric](5, 0)	NOT NULL,
		CONSTRAINT PK_PROYECTOS PRIMARY KEY(COD_PROYECTO), 
		CONSTRAINT [FK_CLIENTES_PROYECTOS] FOREIGN KEY ([CODIGO_CLIENTE]) 
		REFERENCES [CLIENTES]([CODIGO_CLIENTE])
	)
	GO

	INSERT INTO [dbo].[CLIENTES]([CODIGO_CLIENTE],[NOMBRE],[DIRECCION]
           ,[PROVINCIA],[TELEFONO],[FAX])
     VALUES(1,'Pedro','San Pablo', 'Heredia','8825-6467','2211-5858')
GO


	INSERT INTO PROYECTOS (COD_PROYECTO,DESCRIPCION,
		COSTO_TOTAL,FEC_INICIO,FEC_FIN,[CODIGO_CLIENTE]) VALUES
		(1,'Construccion Cochera',5000,'01/05/2019','30/03/2020',1)

	INSERT INTO PROYECTOS (COD_PROYECTO,DESCRIPCION,
		COSTO_TOTAL,FEC_INICIO,FEC_FIN,[CODIGO_CLIENTE]) VALUES
		(2,'Construccion CASA',8000,'01/05/2019','20/08/2021',1)
	GO

	/*Desarrolle el Script de la tabla PAGOS de la base de datos, 
	con su respectiva llave primaria y su llave foránea. (2 pts)*/

	CREATE TABLE PAGOS (
		NUM_PAGO VARCHAR (5) NOT NULL,
		DETALLE VARCHAR(60) NULL,
		MONTO NUMERIC(10,2) NULL,
		FEC_PAGO DATE NULL,
		COD_PROYECTO VARCHAR(5) NULL,
		CONSTRAINT PK_PAGOS PRIMARY KEY(NUM_PAGO), 
		CONSTRAINT [FK_PAGOS_PROYECTOS] FOREIGN KEY (COD_PROYECTO) REFERENCES [PROYECTOS](COD_PROYECTO)
	)
	GO

	/*Desarrolle el Script para la inserción de PAGOS en la base de datos. (1 pts)*/

	INSERT INTO PAGOS (NUM_PAGO,DETALLE,MONTO,FEC_PAGO,COD_PROYECTO) VALUES
		(1,'Construccion Cochera',4000,'01/05/2019',1)

	INSERT INTO PAGOS (NUM_PAGO,DETALLE,MONTO,FEC_PAGO,COD_PROYECTO) VALUES
		(2,'Construccion CASA',5000,'01/05/2021',1)

	GO

		/*Realizar una vista que retorne el código del proyecto, el monto pagado,
	la cantidad de pagos, y el monto pendiente de pagar. 3 pts.8*/

	create view PAGOS2 with encryption
	as
	SELECT PO.COD_PROYECTO,SUM(MONTO) AS'MONTO_PAGADO', COUNT(NUM_PAGO) AS 'CANIDAD_PAGOS',
		   SUM(MONTO) - PO.COSTO_TOTAL AS 'MONTO_PENDIENTE'
	  FROM [dbo].[PAGOS] P
	  INNER JOIN [PROYECTOS] PO ON PO.COD_PROYECTO = P.COD_PROYECTO
	  where PO.COD_PROYECTO = 1
	  GROUP BY PO.COD_PROYECTO,PO.COSTO_TOTAL
	  with check option 

	GO

	SELECT * FROM [dbo].[PAGOS2]
	GO

	/*Cree una vista que muestre el nombre del proyecto, Cantidad de letras del Nombre
	del proyecto, el mes de creación del proyecto, el año de creación. 2 pts.*/

	CREATE VIEW LETRAS WITH ENCRYPTION
	AS
	SELECT P.DESCRIPCION, LEN(P.DESCRIPCION) AS 'CANTIDAD_LETRAS',
		 DateName(mm,P.FEC_INICIO) AS 'MES_CREACION',DateName(yy,P.FEC_INICIO) AS 'AÑO_CREACION'
	  FROM [dbo].[PROYECTOS] P
	  with check option 

	GO

	SELECT * FROM [dbo].[LETRAS]
	GO

	/*Cree una función que reciba el código del proyecto y retorne el monto pendiente de pagar. 
	2 pts.*/

	CREATE FUNCTION fn_Monto (@Cod_Proyecto INT) 
	RETURNS numeric (10,2) 

	AS BEGIN 
		DECLARE @MONTO_PENDIENTE numeric (6,2)  
		SELECT @MONTO_PENDIENTE = SUM(P.MONTO) - [COSTO_TOTAL] 
		FROM [dbo].[PROYECTOS] PO
		INNER JOIN [PAGOS] P ON P.COD_PROYECTO = PO.COD_PROYECTO
			WHERE PO.[COD_PROYECTO] = @Cod_Proyecto
			GROUP BY [COSTO_TOTAL]
		RETURN @MONTO_PENDIENTE
	END 
	GO
	PRINT[dbo].[fn_Monto](1)
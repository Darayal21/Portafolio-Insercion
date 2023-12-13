
CREATE DATABASE DB_PROYECT_FINAL
GO

USE DB_PROYECT_FINAL
GO

Alter authorization on database::DB_PROYECT_FINAL to sa 
GO

SET DATEFORMAT dmy
SET LANGUAGE spanish
GO

-- 1

CREATE TABLE USUARIO(
    ID_USUARIO NUMERIC(5, 0) NOT NULL,
    NOMBRE_USUARIO VARCHAR(100) NOT NULL,
	PIN_USUARIO VARCHAR(100) NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO),
)	
GO

CREATE TABLE CATEGORIA(
    ID_CATEGORIA NUMERIC(5, 0) NOT NULL,
    NOMBRE_CATEGORIA VARCHAR(100) NOT NULL,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (ID_CATEGORIA),
)	
GO

CREATE TABLE ROL(
    ID_ROL INT NOT NULL,
    NOMBRE_ROL VARCHAR(100) NOT NULL,
    CONSTRAINT PK_ROL PRIMARY KEY (ID_ROL),
)	
GO

CREATE TABLE AGENTE(
    ID_AGENTE NUMERIC(5, 0)	NOT NULL,
    NOMBRE_AGENTE VARCHAR(100) NOT NULL,
	ID_ROL INT NOT NULL,
    CONSTRAINT PK_AGENTE PRIMARY KEY (ID_AGENTE),
	CONSTRAINT FK_ROL_AGENTE FOREIGN KEY (ID_ROL) REFERENCES ROL(ID_ROL)
)	
GO

CREATE TABLE ESTADO(
    ID_ESTADO INT NOT NULL,
    NOMBRE_ESTADO VARCHAR(100)	NOT NULL,
    CONSTRAINT PK_ESTADO PRIMARY KEY (ID_ESTADO),
)	
GO

CREATE TABLE INCIDENTE (
    CODIGO_INCIDENTE NUMERIC(5, 0)	NOT NULL,
    DETALLE VARCHAR(100) NOT NULL,
	FEC_INGRESO DATE NOT NULL,
	ESPECIALISTA VARCHAR(100) NOT NULL,
    ID_USUARIO NUMERIC(5, 0) NOT NULL,
	ID_AGENTE NUMERIC(5, 0)	NOT NULL,
	ID_ESTADO INT	NOT NULL,
	ID_CATEGORIA NUMERIC(5, 0)	NOT NULL,
    CONSTRAINT PK_INCIDENTE PRIMARY KEY(CODIGO_INCIDENTE),
	CONSTRAINT FK_AGENTE_INCIDENTE FOREIGN KEY (ID_AGENTE) REFERENCES AGENTE (ID_AGENTE),
	CONSTRAINT FK_USUARIO_INCIDENTE FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
	CONSTRAINT FK_ESTADO_INCIDENTE FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO (ID_ESTADO),
	CONSTRAINT FK_CATEGORIA_INCIDENTE FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA)
)	
GO

CREATE TABLE BITACORA (
    COD_BITACORA int IDENTITY(1,1),
    CODIGO_INCIDENTE NUMERIC(5, 0) NOT NULL,
	FEC_INGRESO DATE NOT NULL,
	ESTADO_ANTERIOR VARCHAR(100)	NOT NULL,
	ESTADO_ACTUAL VARCHAR(100)	NOT NULL,
    CONSTRAINT PK_BITACORA PRIMARY KEY(COD_BITACORA), 
    CONSTRAINT FK_BITACORA_INCIDENTE FOREIGN KEY (CODIGO_INCIDENTE) REFERENCES INCIDENTE(CODIGO_INCIDENTE)
)	
GO

/*2.Script que agregue datos a las Tablas creadas anteriormente. (10 pts)*/

INSERT INTO USUARIO (ID_USUARIO, NOMBRE_USUARIO, PIN_USUARIO) VALUES (1, 'DYLAN',1234)
INSERT INTO USUARIO (ID_USUARIO, NOMBRE_USUARIO, PIN_USUARIO) VALUES (2, 'RAFAEL',5678)
INSERT INTO USUARIO (ID_USUARIO, NOMBRE_USUARIO, PIN_USUARIO) VALUES (3, 'MONDONGO',9101)
INSERT INTO USUARIO (ID_USUARIO, NOMBRE_USUARIO, PIN_USUARIO) VALUES (4, 'Rodrigo',7483)
GO

INSERT INTO CATEGORIA (ID_CATEGORIA, NOMBRE_CATEGORIA) VALUES (1, 'Telefon�a tradicional')
INSERT INTO CATEGORIA (ID_CATEGORIA, NOMBRE_CATEGORIA) VALUES (2, 'Telefon�a VOZ IP')
INSERT INTO CATEGORIA (ID_CATEGORIA, NOMBRE_CATEGORIA) VALUES (3, 'Errores en sistemas de informaci�n')
INSERT INTO CATEGORIA (ID_CATEGORIA, NOMBRE_CATEGORIA) VALUES (4, 'Errores de red')
INSERT INTO CATEGORIA (ID_CATEGORIA, NOMBRE_CATEGORIA) VALUES (5, 'Errores en las computadoras')
INSERT INTO CATEGORIA (ID_CATEGORIA, NOMBRE_CATEGORIA) VALUES (6, 'Impresoras')
GO

INSERT INTO ROL (ID_ROL, NOMBRE_ROL) VALUES (1, 'Coordinador')
INSERT INTO ROL (ID_ROL, NOMBRE_ROL) VALUES (2, 'Especialista')
GO

INSERT INTO AGENTE (ID_AGENTE, NOMBRE_AGENTE, ID_ROL) VALUES (1, 'DYLANF', 1)
INSERT INTO AGENTE (ID_AGENTE, NOMBRE_AGENTE, ID_ROL) VALUES (2, 'RAFA', 1)
INSERT INTO AGENTE (ID_AGENTE, NOMBRE_AGENTE, ID_ROL) VALUES (3, 'JAVIER', 2)
INSERT INTO AGENTE (ID_AGENTE, NOMBRE_AGENTE, ID_ROL) VALUES (4, 'DANIEL', 2)
GO

INSERT INTO ESTADO (ID_ESTADO, NOMBRE_ESTADO) VALUES (1, 'Incidente Asignado-IA')
INSERT INTO ESTADO (ID_ESTADO, NOMBRE_ESTADO) VALUES (2, 'En Desarrollo (ID)')
INSERT INTO ESTADO (ID_ESTADO, NOMBRE_ESTADO) VALUES (3, 'En Pruebas (IP)')
INSERT INTO ESTADO (ID_ESTADO, NOMBRE_ESTADO) VALUES (4, 'No Asignado-NA')
GO

INSERT INTO INCIDENTE(CODIGO_INCIDENTE, DETALLE, FEC_INGRESO, ESPECIALISTA, ID_USUARIO, ID_AGENTE, ID_ESTADO, ID_CATEGORIA) VALUES (1, '1', '01/05/2022', '1', 2, 1, 1, 1)
INSERT INTO INCIDENTE(CODIGO_INCIDENTE, DETALLE, FEC_INGRESO, ESPECIALISTA, ID_USUARIO, ID_AGENTE, ID_ESTADO, ID_CATEGORIA) VALUES (2, '1', '24/06/2022', 'd', 2, 3, 2, 2)
INSERT INTO INCIDENTE(CODIGO_INCIDENTE, DETALLE, FEC_INGRESO, ESPECIALISTA, ID_USUARIO, ID_AGENTE, ID_ESTADO, ID_CATEGORIA) VALUES (3, '1', '07/06/2022', 'd', 2, 4, 3, 3)
INSERT INTO INCIDENTE(CODIGO_INCIDENTE, DETALLE, FEC_INGRESO, ESPECIALISTA, ID_USUARIO, ID_AGENTE, ID_ESTADO, ID_CATEGORIA) VALUES (4, '1', '15/08/2022', 'd', 2, 2, 4, 4)
INSERT INTO INCIDENTE(CODIGO_INCIDENTE, DETALLE, FEC_INGRESO, ESPECIALISTA, ID_USUARIO, ID_AGENTE, ID_ESTADO, ID_CATEGORIA) VALUES (5, '1', '10/05/2022', 'd', 2, 2, 4, 4)
GO

INSERT INTO BITACORA (CODIGO_INCIDENTE, FEC_INGRESO, ESTADO_ANTERIOR, ESTADO_ACTUAL, ID_CATEGORIA, ID_ESTADO) VALUES (1, '01/05/2022', '','' ,1, 1)
INSERT INTO BITACORA (CODIGO_INCIDENTE, FEC_INGRESO, ESTADO_ANTERIOR, ESTADO_ACTUAL, ID_CATEGORIA, ID_ESTADO) VALUES (2, '24/06/2022', '','' ,2, 2)
INSERT INTO BITACORA (CODIGO_INCIDENTE, FEC_INGRESO, ESTADO_ANTERIOR, ESTADO_ACTUAL, ID_CATEGORIA, ID_ESTADO) VALUES (3, '07/06/2022', '','', 3, 3)
GO

/*3.Funci�n que liste la cantidad de casos ingresados por un usuario en particular,
en un rango de fechas en particular. Recibiendo por par�metros el usuario y las fechas de la consulta. (10 pts)*/

CREATE FUNCTION Casos_Ingresados (@USUARIO VARCHAR(50), @FECHA1 DATE, @FECHA2 DATE)
    RETURNS INT 

   AS BEGIN

        DECLARE @Casos_Ingresados INT  
        SELECT @Casos_Ingresados = COUNT(CODIGO_INCIDENTE)
        FROM [dbo].[INCIDENTE] I
        INNER JOIN [USUARIO] U ON U.ID_USUARIO = I.ID_USUARIO
            WHERE U.NOMBRE_USUARIO = @USUARIO AND FEC_INGRESO BETWEEN @FECHA1 AND @FECHA2 
        RETURN @Casos_Ingresados
    
	END
    GO
    PRINT[dbo].[Casos_Ingresados]('RAFAEL','23/06/2002','16/08/2032')
	GO

	/*4.Funci�n que liste la cantidad de casos atendidos por un especialista en particular, 
	en un rango de fechas en particular. Recibiendo por par�metros el especialista y las fechas de la consulta. (10 pts)*/

	CREATE FUNCTION Casos_Atendidos (@Agente VARCHAR(50), @FECHA1 DATE, @FECHA2 DATE)
    RETURNS INT 

   AS BEGIN

        DECLARE @Casos_Ingresados INT  
        SELECT @Casos_Ingresados = COUNT(CODIGO_INCIDENTE)
        FROM [dbo].[INCIDENTE] I
        INNER JOIN [AGENTE] A ON A.ID_AGENTE = I.ID_AGENTE
            WHERE A.NOMBRE_AGENTE = @Agente AND FEC_INGRESO BETWEEN @FECHA1 AND @FECHA2 
        RETURN @Casos_Ingresados
    
	END
    GO
    PRINT[dbo].[Casos_Atendidos]('RAFA','23/06/2002','16/08/2032')
	GO


	/*5.Desarrolle una Vista que liste todos los Incidentes Pendientes de Asignar. (5 pts)*/

	CREATE VIEW	INCIDENTES_P
	AS
	SELECT PO.ID_ESTADO, CODIGO_INCIDENTE, DETALLE, FEC_INGRESO, ESPECIALISTA, ID_USUARIO, ID_AGENTE, ID_CATEGORIA
	  FROM [dbo].[INCIDENTE] P
	  INNER JOIN ESTADO PO ON PO.ID_ESTADO = P.ID_ESTADO
	  WHERE PO.ID_ESTADO = 4
	  WITH CHECK OPTION 

	GO

	SELECT * FROM [dbo].[INCIDENTES_P]
	GO


	/*6.	Procedimiento almacenado que permita cambiar el Estado de un 
	Incidente. Recibiendo el n�mero de incidente y el nuevo estado. (15 pts)

	a.	Validar que el incidente exista, el nuevo estado sea v�lido (5 pts).
	b.	Uso de Try Catch y Transacciones. (5 pts)
	c.	Cambio del Estado del Incidente. (5 pts)
	*/

	CREATE PROCEDURE pa_CAMBIO_ESTADO
	
		@ESTADO INT, @COD_INCIDENTE INT 
	
	AS BEGIN 
		IF EXISTS(SELECT * FROM INCIDENTE  
		WHERE CODIGO_INCIDENTE = @COD_INCIDENTE) BEGIN 

			BEGIN TRY
				UPDATE [dbo].[INCIDENTE]
				SET [ID_ESTADO] = @ESTADO
				FROM[dbo].[INCIDENTE]
				WHERE CODIGO_INCIDENTE = @COD_INCIDENTE
			END TRY

			BEGIN CATCH
				DECLARE @msg_Error VARCHAR(100)
				SET @msg_Error = 'NO SE PUDO ACTUALIZAR EL ESTADO';
				THROW 56000, @msg_ERROR, 10
			END CATCH

		END 

		ELSE BEGIN 
			PRINT 'El INCIDENTE NO EXISTE ' 
		END 

	END 
	GO 

	EXEC pa_CAMBIO_ESTADO 1,1
	GO 

	/*7.Trigger asociado a la tabla de Incidentes que responda a los UPDATE de Estados, y que debe crear el registro en 
	el Hist�rico de  incidentes, registrando: el c�digo del Incidente y la fecha de modificaci�n, el estado anterior y el estado 
	actual. (10 pts).
	a.	Uso de Try Catch. (5 pts)
	b.	Registro del Hist�rico. (5 pts) 
	*/

	CREATE TRIGGER TR_BITACORA_INSERT ON INCIDENTE AFTER UPDATE
	AS BEGIN

		SET NOCOUNT ON;

		DECLARE @ESTADO INT 
		DECLARE @ESTADO1 INT 
		DECLARE @COD_INCIDENTE INT
		DECLARE @CATEGORIA INT
		DECLARE @ID_ESTADO INT

		SELECT @COD_INCIDENTE = [CODIGO_INCIDENTE]
			FROM inserted

		SELECT @ESTADO = [ID_ESTADO]
			FROM deleted

		SELECT @ESTADO1 = [ID_ESTADO]
			FROM inserted 

		SELECT @ID_ESTADO = [ID_ESTADO]
			FROM INCIDENTE 
			WHERE [CODIGO_INCIDENTE] = @COD_INCIDENTE

		SELECT @CATEGORIA = [ID_CATEGORIA]
			FROM INCIDENTE 
			WHERE [CODIGO_INCIDENTE] = @COD_INCIDENTE

		INSERT INTO BITACORA (CODIGO_INCIDENTE, FEC_INGRESO, [ESTADO_ANTERIOR],[ESTADO_ACTUAL]) 
		VALUES (@COD_INCIDENTE, GETDATE(), @ESTADO, @ESTADO1)

	END
	GO
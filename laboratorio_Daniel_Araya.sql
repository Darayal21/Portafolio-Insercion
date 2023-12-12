/** SE CREA LA BASE DE DATOS**/
CREATE DATABASE BD_FACT_RAFAEL
GO



/** SE SELECCIONA LA BASE DE DATOS CREADA**/
USE BD_FACT_RAFAEL
GO




/** INSTRUCCION QUE PERMITE CREAR LOS DIAGRAMAS**/
Alter authorization on database::BD_FACT_RAFAEL to sa
GO



/*Establece el formato de la fecha en dia/mes/año,
cualquiera de las dos*/
SET DATEFORMAT dmy
SET LANGUAGE spanish
GO




/* Crear la tabla de Productos*/
CREATE TABLE  Productos (
    Cod_Producto int NOT NULL,
    Nom_Producto varchar(50) NULL,
    Precio Numeric(10,2) NOT NULL,
    Existencias int NOT NULL,
    CONSTRAINT [PK_Productos] PRIMARY KEY (Cod_Producto ASC)
)
GO



INSERT INTO Productos([Cod_Producto],[Nom_Producto],[Precio],[Existencias])
     VALUES(1,'Carros',100000,7)
GO



INSERT INTO Productos([Cod_Producto],[Nom_Producto],[Precio],[Existencias])
     VALUES(2,'Motos',167877,10)
GO



INSERT INTO Productos([Cod_Producto],[Nom_Producto],[Precio],[Existencias])
     VALUES(3,'Cuadras',120300,12)
GO



/* Crear la tabla de Ordenes*/
CREATE TABLE  Pedidos (
    Cod_Pedido     int NOT NULL,
    Fec_Pedido    datetime NOT NULL,
    Cod_Producto  int NOT NULL,
    Cantidad int NOT NULL,
    CONSTRAINT [PK_Ordenes] PRIMARY KEY (Cod_Pedido ASC),
    CONSTRAINT FK_Productos_Pedidos FOREIGN KEY (Cod_Producto) REFERENCES Productos(Cod_Producto)
)
GO



INSERT INTO Pedidos([Cod_Pedido],[Fec_Pedido],[Cod_Producto],[Cantidad])
     VALUES(1,GETDATE(),1,3)
GO



INSERT INTO Pedidos([Cod_Pedido],[Fec_Pedido],[Cod_Producto],[Cantidad])
     VALUES(2,GETDATE(),2,2)
GO



INSERT INTO Pedidos([Cod_Pedido],[Fec_Pedido],[Cod_Producto],[Cantidad])
     VALUES(3,GETDATE(),3,1)
GO



/*
1.    Realizar un procedimiento almacenado para insertar Pedidos.
o    Debe recibir por parámetros todos los valores del Pedido, excepto la fecha. 2 pts
o    Debe validar que Cod:Producto, exista en la tabla de Productos. 2 pts
o    Debe validar que la cantidad sea mayor a cero y que exista en la tabla de productos esa cantidad. 2 pts
o    En caso de cumplir las reglas anteriores, crear la sentencia de Insert con los parámetros recibidos, en la tabla de Pedidos. 2 pts
o    Crear la sentencia Update que rebaje las existencias de productos de acuerdo con la Cantidad de productos del pedido.
*/



/*1.Realizar un procedimiento almacenado para insertar Pedidos.*/
CREATE PROCEDURE pa_INSERTAR_PEDIDOS



   /*Debe recibir por parámetros todos los valores del Pedido, excepto la fecha. 2 pts*/
    @Cod_Pedido VARCHAR(5), @Cantidad INT,
    @Cod_Producto numeric(10,2)



AS BEGIN



   /*Debe validar que Cod:Producto, exista en la tabla de Productos. 2 pts*/
    IF EXISTS(SELECT * FROM Productos
    WHERE Cod_Producto = @Cod_Producto) BEGIN



       /*Debe validar que la cantidad sea mayor a cero y que exista en la tabla de productos esa cantidad. 2 pts*/
        IF (@Cantidad >= 0) AND EXISTS(SELECT * FROM Productos
        WHERE Existencias >= @Cantidad) BEGIN




            /*Crear la sentencia de Insert con los parámetros recibidos, en la tabla de Pedidos. 2 pts*/
            INSERT INTO Pedidos (Cod_Pedido,Fec_Pedido,Cod_Producto,Cantidad)
            VALUES (@Cod_Pedido,GETDATE(),@Cod_Producto,@Cantidad)
            
            DECLARE @ExistenciasActualizadas INT
            SET @ExistenciasActualizadas = (SELECT Existencias - @Cantidad FROM Productos
            WHERE @Cod_Producto = Cod_Producto)



           /*Crear la sentencia Update que rebaje las existencias de productos de acuerdo
            con la Cantidad de productos del pedido.*/



           UPDATE [dbo].[Productos]
            SET Existencias = @ExistenciasActualizadas
            WHERE Cod_Producto = @Cod_Producto
            
        END
        ELSE BEGIN
            PRINT 'NO SE INSERTO NI SE ACTUALIZO'
        END
    END
    ELSE BEGIN
        PRINT 'El PRODUCTO NO EXISTE '
    END
END
GO



EXEC pa_INSERTAR_PEDIDOS 10,3,2
GO
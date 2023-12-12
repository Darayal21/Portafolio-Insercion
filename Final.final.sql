create database pedidoSistem
go

USE pedidoSistem
GO

SET ANSI_NULLS ON   /*no tiene  funciones utiles pero*/
GO                 /*es mejor dejarlo por el store procedures*/
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[USUARIO](
	[ID_USUARIO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [nvarchar](100) NULL,
	[APELLIDO] [nvarchar](100) NULL,
	[PASSWORD] [nvarchar](100) NULL,
	[DIRECCION][nvarchar](100) NULL,
	[CORREO][nvarchar](100) NULL,
 CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED ([ID_USUARIO] ASC)	
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS](
    [ID_USUARIO] [int] NOT NULL,
	[ID_PRODUCTOS] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [nvarchar](100) NULL,
	[PRECIO] [int] NOT NULL,
	[ESTADO][nvarchar](100) NULL,
	[DESCRIPCION][nvarchar](100) NULL,
	[CANTIDAD] [int] NOT NULL,
	[DIRECCION] [int]  NOT NULL,
 CONSTRAINT [PK_PRODUCTOS] PRIMARY KEY CLUSTERED ([ID_PRODUCTOS] ASC)
 WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 

	GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMPRAS_DETALLE](
	[ID_COMPRAS] [int] IDENTITY(1,1) NOT NULL,
	[ID_USUARIO] [int] Not NULL,
	[ID_PRODUCTO] [int]  NOT NULL,
	[FECHA_COMPRA] [datetime] NULL,
	[DETALLE] [int]  NOT NULL,
	[PRECIO] [int] NOT NULL,
	[CANTIDAD] [int] NOT NULL,
 CONSTRAINT [PK_COMPRAS] PRIMARY KEY CLUSTERED ([ID_COMPRAS] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERROR_PEDIDOS_SISTEM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SEVERIDAD] [int] NULL,
	[STORE_PROCEDURE] [nvarchar](50) NULL,
	[NUMERO] [int] NULL,
	[DESCRIPCION] [nvarchar](max) NULL,
	[LINEA] [int] NULL,
	[FECHA_HORA] [datetime] NULL,
 CONSTRAINT [PK_ERROR_PEDIDOS_SISTEM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PUBLICAR_PRODUCTOS](
	[ID_PUBLICACION_PRODUCTOS] [int] IDENTITY(1,1) NOT NULL,
	[ID_PRODUCTOS] [int] NOT NULL,
	[FECHA_REGISTRO] [datetime] NOT NULL,
 CONSTRAINT [PK_PUBLICAR_PRODUCTOS] PRIMARY KEY CLUSTERED 
(
	[ID_PUBLICACION_PRODUCTOS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INSERTAR_USUARIO]
(
    @Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
	@Password NVARCHAR(100),
    @Direccion NVARCHAR(100),
    @Correo NVARCHAR(100),
    @ID_RETURN INT OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO [dbo].[Usuario]
        (
            [NOMBRE],
			[APELLIDO],
			[PASSWORD],
            [DIRECCION],
            [CORREO]
        )
        VALUES
        (
            @Nombre,
			@Apellido,
			@Password,
            @Direccion,
            @Correo
        );

        SET @ID_RETURN = SCOPE_IDENTITY();
        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ID_RETURN = 0;
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_INSERTAR_PRODUCTOS]
(
    @idUsuario INT,
    @idProductos INT,
    @Nombre NVARCHAR(100),
    @Precio DECIMAL(10, 2),
    @Estado NVARCHAR(100),
    @Descripcion NVARCHAR(MAX),
    @Cantidad INT,
    @Direccion DECIMAL(5, 2),
    @ID_RETURN INT OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO [dbo].[PRODUCTOS]
        (
            [ID_USUARIO],
            [ID_PRODUCTOS],
            [Nombre],
            [Precio],
            [Estado],
            [Descripcion],
			[CANTIDAD],
			[DIRECCION]

        )
        VALUES
        (
            @idUsuario,
            @idProductos,
            @Nombre,
            @Precio,
            @Estado,
            @Descripcion,
            @Cantidad,
            @Direccion
        );

        SET @ID_RETURN = SCOPE_IDENTITY();
        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ID_RETURN = 0;
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_INSERTAR_COMPRA]
(
    @ID_COMPRAS INT,
    @ID_CLIENTE INT,
    @ID_PRODUCTO INT,
    @FECHA DATETIME,
	@DETALLE NVARCHAR(100),
    @PRECIO DECIMAL(10, 2),
    @CANTIDAD INT,
    @ID_RETURN INT OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO [dbo].[COMPRAS_DETALLE]
        (
           [ID_COMPRAS],
           [ID_USUARIO],
		   [ID_PRODUCTO],
		   [FECHA_COMPRA],
           [DETALLE],
           [PRECIO],
           [CANTIDAD]
        )
        VALUES
        (
            @ID_COMPRAS,
            @ID_CLIENTE,
            @ID_PRODUCTO,
            @FECHA,
			@DETALLE,
            @PRECIO,
            @CANTIDAD
        );

        SET @ID_RETURN = SCOPE_IDENTITY();
        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ID_RETURN = 0;
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
go -->ARREGLAR
CREATE PROCEDURE [dbo].[SP_INSERTAR_ERROR_PEDIDOS]
(
    @ID INT,
    @SEVERIDAD INT,
    @STORED_PROCEDURE NVARCHAR(100),
    @NUMERO INT,
    @DESCRIPCION NVARCHAR(MAX),
    @LINEA INT,
    @FECHA DATETIME,
    @ID_RETURN INT OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO [dbo].[error_pedidos_sistem]
        (
            [ID],
			[SEVERIDAD],
			[STORE_PROCEDURE],
			[NUMERO],
			[DESCRIPCION],
			[LINEA],
			[FECHA_HORA]
           
        )
        VALUES
        (
            @ID,
            @SEVERIDAD,
            @STORED_PROCEDURE,
            @NUMERO,
            @DESCRIPCION,
            @LINEA,
            @FECHA
        );

        SET @ID_RETURN = SCOPE_IDENTITY();
        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ID_RETURN = 0;
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
go--> insert para tabla errorPedidos  
CREATE PROCEDURE [dbo].[SP_INSERTAR_PUBLICAR_PRODUCTOS]
(
    @ID_PUBLICACION_PRODUCTOS INT,
    @ID_PRODUCTOS INT,
    @ID_RESPUESTA INT,
	@FECHA_REGISTRO DATETIME,
    @ID_RETURN INT OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO [dbo].[PUBLICAR_PRODUCTOS]
        (
            [ID_PUBLICACION_PRODUCTOS],
			[ID_PRODUCTOS],
			[FECHA_REGISTRO]

        )
        VALUES
        (
		    @ID_PUBLICACION_PRODUCTOS,
            @ID_PRODUCTOS,
            @FECHA_REGISTRO
        );

        SET @ID_RETURN = SCOPE_IDENTITY();
        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ID_RETURN = 0;
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
go--> insert para tabla publicar respuesta 

CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_USUARIO]
(
    @idUsuario INT,
    @Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
	@Password NVARCHAR(100),
    @Direccion NVARCHAR(100),
    @Correo NVARCHAR(100),
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        UPDATE [dbo].[Usuario]
        SET
             [NOMBRE]= @Nombre,
			 [APELLIDO] = @Apellido,
			 [PASSWORD]= @Password,
             [DIRECCION]= @Direccion,
             [CORREO]= @Correo
        WHERE
            [ID_USUARIO] = @idUsuario;

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_PRODUCTOS]
(
    @idUsuario INT,
    @idProductos INT,
    @Nombre NVARCHAR(100),
    @Precio DECIMAL(10, 2),
    @Estado NVARCHAR(100),
    @Descripcion NVARCHAR(MAX),
    @Cantidad INT,
    @Direccion DECIMAL(5, 2),
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        UPDATE [dbo].[Productos]
        SET
             [NOMBRE]= @Nombre,
             [PRECIO]= @Precio,
             [ESTADO]= @Estado,
             [DESCRIPCION]= @Descripcion,
             [CANTIDAD]= @Cantidad,
             [DIRECCION]= @Direccion
        WHERE
            [ID_USUARIO] = @idUsuario
            AND [ID_PRODUCTOS] = @idProductos;

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_ERROR_PEDIDOS]
(
    @ID_ERROR INT,
    @SEVERIDAD INT,
    @STORED_PROCEDURE NVARCHAR(100),
    @NUMERO INT,
    @DESCRIPCION NVARCHAR(MAX),
    @LINEA INT,
    @FECHA DATETIME,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        UPDATE [dbo].[error_pedidos_sistem]
        SET
            [SEVERIDAD] = @SEVERIDAD,
            [STORE_PROCEDURE] = @STORED_PROCEDURE,
            [NUMERO] = @NUMERO,
            [DESCRIPCION] = @DESCRIPCION,
            [LINEA] = @LINEA,
            [FECHA_HORA] = @FECHA
        WHERE
            [id] = @ID_ERROR;

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
go--> update para tabla  errorPedidos 
CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_PUBLICAR_PRODUCTOS]
(
    @ID_PUBLICACION_PRODUCTOS INT,
    @ID_PRODUCTOS INT,
    @ID_RESPUESTA INT,
    @FECHA_REGISTRO DATETIME,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        UPDATE [dbo].[PUBLICAR_PRODUCTOS]
        SET
            [ID_PRODUCTOS] = @ID_PRODUCTOS,
            [FECHA_REGISTRO] = @FECHA_REGISTRO
        WHERE
            [ID_PUBLICACION_PRODUCTOS] = @ID_PUBLICACION_PRODUCTOS;

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO--> update para tabla publicar respuesta 

CREATE PROCEDURE [dbo].[SP_OBTENER_USUARIO]
(
    @idUsuario INT,
    @Nombre NVARCHAR(100) OUTPUT,
	@Apellido NVARCHAR(100) OUTPUT,
	@Password NVARCHAR(100) OUTPUT,
    @Direccion NVARCHAR(100) OUTPUT,
    @Correo NVARCHAR(100) OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT
            @Nombre = [NOMBRE],
            @Direccion =[DIRECCION] ,
            @Correo = [CORREO]
        FROM
            [dbo].[Usuario]
        WHERE
            [ID_USUARIO] = @idUsuario;

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_OBTENER_PRODUCTO]
(
    @idUsuario INT,
    @idProductos INT,
    @Nombre NVARCHAR(100) OUTPUT,
    @Precio DECIMAL(10, 2) OUTPUT,
    @Estado NVARCHAR(100) OUTPUT,
    @Descripcion NVARCHAR(MAX) OUTPUT,
    @Cantidad INT OUTPUT,
    @Direccion NVARCHAR(100) OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT
            @Nombre = [NOMBRE],
            @Precio = [PRECIO],
            @Estado = [ESTADO],
            @Descripcion = [DESCRIPCION],
            @Cantidad = [CANTIDAD],
            @Direccion = [DIRECCION]
        FROM
            [dbo].[Productos]
        WHERE
            [ID_USUARIO] = @idUsuario
            AND [ID_PRODUCTOS] = @idProductos;

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_OBTENER_COMPRAS_DETALLE]
(
    @idCompras INT OUTPUT,
    @idUsuario INT OUTPUT,
    @idProducto INT OUTPUT,
    @fecha_compra DATETIME OUTPUT,
    @detalle NVARCHAR(MAX) OUTPUT,
    @precio DECIMAL(10, 2) OUTPUT,
    @cantidad INT OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT
            @idCompras = [ID_COMPRAS],
            @idUsuario = [ID_USUARIO],
            @idProducto = [ID_PRODUCTO],
            @fecha_compra = [FECHA_COMPRA],
            @detalle = [DETALLE],
            @precio = [PRECIO],
            @cantidad = [CANTIDAD]
        FROM
            [dbo].[COMPRAS_DETALLE];

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @idCompras = NULL;
        SET @idUsuario = NULL;
        SET @idProducto = NULL;
        SET @fecha_compra = NULL;
        SET @detalle = NULL;
        SET @precio = NULL;
        SET @cantidad = NULL;

        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_OBTENER_ERROR_PEDIDOS]
(
    @id INT OUTPUT,
    @severidad INT OUTPUT,
    @stored_procedure NVARCHAR(100) OUTPUT,
    @numero INT OUTPUT,
    @descripcion NVARCHAR(MAX) OUTPUT,
    @linea INT OUTPUT,
    @fecha DATETIME OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT
            @id = [ID],
            @severidad = [SEVERIDAD],
            @stored_procedure = [STORE_PROCEDURE],
            @numero =[NUMERO] ,
            @descripcion =[DESCRIPCION] ,
            @linea = [LINEA],
            @fecha = [FECHA_HORA]
        FROM
            [dbo].[error_pedidos_sistem];

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO
CREATE PROCEDURE [dbo].[SP_OBTENER_PUBLICAR_PRODUCTOS]
(
    @idPublicacion INT OUTPUT,
    @idProductos INT OUTPUT,
    @fecha DATETIME OUTPUT,
    @ERROR_ID INT OUTPUT,
    @ERROR_DESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT
            @idPublicacion = [ID_PUBLICACION_PRODUCTOS],
            @idProductos = [ID_PRODUCTOS],
            @fecha = [FECHA_REGISTRO]
        FROM
            [dbo].[publicar_Productos];

        SET @ERROR_ID = 0;
        SET @ERROR_DESCRIPCION = '';
    END TRY
    BEGIN CATCH
        SET @ERROR_ID = ERROR_NUMBER();
        SET @ERROR_DESCRIPCION = ERROR_MESSAGE();
    END CATCH;
END
GO




ALTER TABLE [dbo].[PRODUCTOS]
ADD CONSTRAINT FK_USUARIO_PRODUCTOS
FOREIGN KEY ([ID_PRODUCTOS]) REFERENCES [dbo].[USUARIO]([ID_USUARIO]);
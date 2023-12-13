USE [master]
GO
/****Creamos la base de datos***/
CREATE DATABASE [Veterinaria]
 GO

/*Usamos la base de datos creada*/
USE [Veterinaria]
GO

/*Creacion de Tablas*/

CREATE TABLE [dbo].[Propietarios](
	[IDPropietario] int NOT NULL,
	[Nombre] varchar (80) NULL,
	[Apellido1] varchar (80) NULL,
	[Apellido2] varchar (80) NULL,
	[Fecha_Nacimiento] date NULL,
	[Direccion] varchar(80) NULL,
	[Usuario] varchar(80) NULL,
	[Password] varchar(80) NULL,
 CONSTRAINT [PK_Propietarios] PRIMARY KEY ( [IDPropietario] ASC)
 )
 GO

 CREATE TABLE [dbo].[Tipo_Empleado](
	[IDTipo_Empleado] int NOT NULL,
	[Puesto] varchar(80) NULL,
 CONSTRAINT [PK_Tipo_Empleado] PRIMARY KEY ( [IDTipo_Empleado] asc)
 )
 GO

 CREATE TABLE [dbo].[Tipo_Animal](
	[IDTipo_Animal] int NOT NULL,
	[Animal] varchar(80) NULL,
 CONSTRAINT [PK_Tipo_Animal] PRIMARY KEY ([IDTipo_Animal]asc) 
 )
 GO

 CREATE TABLE [dbo].[Tipo_Raza](
	[IDTipo_Raza] int NOT NULL,
	[Raza] varchar(80) NULL,
	[IDTipo_Animal] int NOT NULL,
 CONSTRAINT [PK_Tipo_Raza] PRIMARY KEY ([IDTipo_Raza] ASC),
 CONSTRAINT FK_Tipo_Raza_Tipo_Animal Foreign Key (IDTipo_Animal) REFERENCES Tipo_Animal(IDTipo_Animal)
)
GO

CREATE TABLE [dbo].[Mascotas](
	[IDMascota] [int] NOT NULL,
	[Nombre] [varchar](80) NULL,
	[Fecha_Nacimiento] [date] NULL,
	[Peso] [int] NULL,
	[IDTipo_Raza] [int] NOT NULL,
 CONSTRAINT [PK_Mascotas] PRIMARY KEY ([IDMascota] ASC),
 CONSTRAINT FK_Mascotas_Tipo_Raza Foreign Key (IDTipo_Raza) REFERENCES Tipo_Raza(IDTipo_Raza)
 )
 GO

 CREATE TABLE [dbo].[Empleados](
	[IDEmpleado] int NOT NULL,
	[Nombre] varchar(80) NULL,
	[Apellido1] varchar(80) NULL,
	[IDTipo_Empleado] int not null,
 CONSTRAINT [PK_Empleados] PRIMARY KEY (IDEmpleado asc),
 CONSTRAINT FK_Empleados_Tipo_Empleado Foreign Key ([IDTipo_Empleado]) REFERENCES [Tipo_Empleado]([IDTipo_Empleado])
)
GO

CREATE TABLE [dbo].[Emails](
	[IDEmail] int NOT NULL,
	[Email] varchar(80) NULL,
	[IDPropietario] int NULL,
 CONSTRAINT PK_Emails PRIMARY KEY (IDEmail asc),
  CONSTRAINT FK_Emails_Propietarios Foreign Key ([IDPropietario]) REFERENCES Propietarios([IDPropietario])

)
go

CREATE TABLE [dbo].[Telefonos](
	[IDTelefono] int NOT NULL,
	[Telefono] int NULL,
	[IDpropietario] int NULL, 
 CONSTRAINT [PK_Telefonos] PRIMARY KEY([IDTelefono] asc),
 CONSTRAINT FK_Telefonos_Propietarios Foreign Key ([IDPropietario]) REFERENCES Propietarios([IDPropietario])
 )
 GO

CREATE TABLE [dbo].[Mascota_Propietario](
	[IDMasc_Propietario] int NOT NULL,
	[IDMascota] int NULL,
	[IDPropietario] int NULL,
 CONSTRAINT [PK_Mascota_Propietario] PRIMARY KEY ( IDMasc_Propietario ASC),
 CONSTRAINT FK_Mascotas_Propietarios_Mascota Foreign Key ([IDMascota]) REFERENCES Mascotas([IDMascota]),
 CONSTRAINT FK_Mascotas_Propietarios_Propietarios Foreign Key ([IDPropietario]) REFERENCES Propietarios([IDPropietario])

 ) 
 GO

 CREATE TABLE [dbo].[Citas](
	[IDCita] int NOT NULL,
	[Fecha] date NULL,
	[Motivo] varchar(80) NULL,
	[Tratamiento] varchar(80) NULL,
	[IDEmpleado] int NULL,
	[IDMascota] int NULL,

 CONSTRAINT [PK_IDCita] PRIMARY KEY (IDCita ASC),
 CONSTRAINT FK_Citas_Empleados Foreign Key ([IDEmpleado]) REFERENCES Empleados([IDEmpleado]),
 CONSTRAINT FK_Citas_Mascotas Foreign Key ([IDMascota]) REFERENCES Mascotas([IDMascota])
 )

GO

CREATE TABLE [dbo].[Diagnosticos](
	[IDDiagnostico] int NOT NULL,
	[Enfremedad] varchar(80) NULL,
	[Cronica] varchar(80) NULL,
	[Fecha_diagnostico] [date] NULL,
	[IDEmpleado] int NULL,
	[IDMascota] int NULL,
	[IDCita] int NULL,
 CONSTRAINT [PK_Diacnosticos] PRIMARY KEY (IDDiagnostico ASC),
 CONSTRAINT FK_Diacnosticos_Empleados Foreign Key ([IDEmpleado]) REFERENCES Empleados([IDEmpleado]),
 CONSTRAINT FK__Mascotas_Empleados Foreign Key ([IDMascota]) REFERENCES Mascotas([IDMascota]),
 CONSTRAINT FK__Mascotas_Citas Foreign Key ([IDCita]) REFERENCES Citas([IDCita])
 )
GO














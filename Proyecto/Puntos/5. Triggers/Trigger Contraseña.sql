USE [ProyectoProgra4]
GO

SELECT * FROM [dbo].[Contraseņas]
SELECT * FROM Auditoria_Contraseņa
TRUNCATE TABLE Auditoria_Contraseņa

CREATE TABLE Auditoria_Contraseņa (
	Usuario varchar (30),
	Fecha date,
	Descripcion varchar(50),
	Id_Contraseņa INT NOT NULL,
	Contra VARCHAR (20),
	Id_Usuario INT NOT NULL
	)
GO



CREATE TRIGGER TR_AUDITORIA_CONTRASAEŅA
ON [dbo].[Contraseņas] FOR INSERT,UPDATE,DELETE
AS
SET NOCOUNT ON
DECLARE @Id_Contraseņa INT,@Contra VARCHAR (20), @Id_Usuario VARCHAR (20)
IF EXISTS(SELECT 0 FROM inserted)
BEGIN
	IF EXISTS(SELECT 0 FROM deleted)
	BEGIN
		SELECT  @Id_Contraseņa =[Id_Contraseņa] ,@Contra=[Contra] , @Id_Usuario=[Id_Usuario] FROM deleted
		INSERT INTO Auditoria_Contraseņa values(SYSTEM_USER,GETDATE(),'Registro Actualizado Eliminado',@Id_Contraseņa,@Contra, @Id_Usuario)
		SELECT  @Id_Contraseņa =[Id_Contraseņa] ,@Contra=[Contra] , @Id_Usuario=[Id_Usuario] FROM inserted
		INSERT INTO Auditoria_Contraseņa values(SYSTEM_USER,GETDATE(),'Registro Actualizado Eliminado',@Id_Contraseņa,@Contra, @Id_Usuario)
		END ELSE
	BEGIN		
		SELECT  @Id_Contraseņa =[Id_Contraseņa] ,@Contra=[Contra] , @Id_Usuario=[Id_Usuario] FROM inserted
		INSERT INTO Auditoria_Contraseņa values(SYSTEM_USER,GETDATE(),'Registro Actualizado Eliminado',@Id_Contraseņa,@Contra, @Id_Usuario)
	END
END ELSE
BEGIN
		SELECT  @Id_Contraseņa =[Id_Contraseņa] ,@Contra=[Contra] , @Id_Usuario=[Id_Usuario] FROM deleted
		INSERT INTO Auditoria_Contraseņa values(SYSTEM_USER,GETDATE(),'Registro Actualizado Eliminado',@Id_Contraseņa,@Contra, @Id_Usuario)
END
GO
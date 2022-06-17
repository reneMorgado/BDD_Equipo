--Creación de SP para la DAO


--SP para actualizar correo 
CREATE PROCEDURE sp_ActualizaCorreo
@Correo varchar(30)
AS
BEGIN
	UPDATE OPENQUERY(MYSQL,'SELECT  EmailAddress FROM production.productreview where ProductReviewID = 2')
	SET EmailAddress = @Correo
END

EXECUTE sp_ActualizaCorreo 'linkinpark@gmail.com'

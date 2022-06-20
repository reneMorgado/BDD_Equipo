--Creamos el shema Copia, que vamos a utilizar para migrar a MySQL

--CREATE SCHEMA NorteAmerica;

--Creamos las copias de las tablas de NorthAmerica
--SELECT * INTO NorteAmerica.Territory from dbo.NorthAmerica;

SELECT *FROM NorteAmerica.Territory

--2. Listar datos del empleado que atendio mas ordenes por territorio.
SELECT SalesPersonID, COUNT(Sales.SalesOrderHeader.TerritoryID)
FROM Sales.SalesOrderHeader INNER JOIN Sales.SalesPerson
ON Sales.SalesOrderHeader.SalesPersonID = Sales.SalesPerson.BusinessEntityID
GROUP BY SalesPersonID ORDER BY COUNT(*) DESC

--3. Listar los datos del cliente con mas ordenes solicitadas en la region North America.
SELECT *FROM OPENQUERY(MYSQL, 'SELECT  adventureworks2019.customer.CustomerID, count(adventureworks2019.sles.SalesOrderID) AS NumberOfOrders
FROM adventureworks2019.sles 
INNER JOIN adventureworks2019.customer ON adventureworks2019.sles.CustomerID = adventureworks2019.customer.CustomerID
GROUP BY adventureworks2019.customer.CustomerID ORDER BY NumberOfOrders DESC LIMIT 1 ');


--4. Listar el producto mas solicitado en la region Europe.
SELECT TOP 1 ProductID, COUNT(ProductID) AS TOTAL FROM Sales.SalesOrderDetail SSA
INNER JOIN Sales.SalesOrderHeader SSO ON SSA.SalesOrderID = SSO.SalesOrderID WHERE TerritoryID IN(7,8,10)  GROUP BY ProductID


--5. Listar las ofertas que tienen los productos de la categora Bikes
SELECT * FROM Sales.SpecialOffer WHERE SpecialOfferID IN (
SELECT SpecialOfferID FROM Sales.SpecialOfferProduct SOP
INNER JOIN Production.Product P ON SOP.ProductID = P.ProductID
INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID =
PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PS.ProductCategoryID =
PC.ProductCategoryID WHERE
[PC].[Name] = 'Bikes');


--6. Listar los 3 productos menos solicitados en la region Pacific
SELECT TOP 3 ProductID, COUNT(ProductID) AS TOTAL FROM Sales.SalesOrderDetail SSA
INNER JOIN Sales.SalesOrderHeader SSO ON SSA.SalesOrderID = SSO.SalesOrderID WHERE TerritoryID IN(9)  GROUP BY ProductID


--7. Actualizar la subcategoria de los productos con productId del 1 al 4 a la subcategoria valida para el tipo de producto.
CREATE PROCEDURE sp_ActualizarSubcatego
@productId int,
@subcategoriaID int

AS
	IF exists( select * from AdventureWorks2019.Production.Product where
	ProductID = @productId )
BEGIN
	IF exists( select * from AdventureWorks2019.Production.ProductSubcategory where ProductSubcategoryID =@subcategoriaID )
	update AdventureWorks2019.Production.Product set [ProductSubcategoryID] = @subcategoriaID, ModifiedDate = GETDATE()
	where ProductID = @productId
ELSE
	SELECT -1 as resultado
END
ELSE
SELECT 0 as resultado

EXEC sp_ActualizarSubcatego 1,2


SELECT *FROM AdventureWorks2019.Production.Product
SELECT *FROM Production.ProductSubcategory


--8. Listar los productos que no estan disponibles a la venta.
SELECT *FROM OPENQUERY(MYSQL, 'SELECT *FROM Production.Product WHERE SellEndDate is not null;');

--9. Listar los clientes del territorio 1 y 4 que no tengan asociado un valor en personId
SELECT CustomerID FROM Sales.Customer WHERE (TerritoryID = 1 or TerritoryID = 4) AND PersonID IS NULL


--10. Listar los clientes del territorio 1 que tengan ordenes en otro territorio
--select * from NorthAmerica.sales.SalesOrderHeader
--where TerritoryID = 1 and CustomerID in ( select CustomerID from
--NorthAmerica.sales.SalesOrderHeader
--where TerritoryID between 2 and 6 )
--union all
--select * from NorthAmerica.sales.SalesOrderHeader
--where TerritoryID = 1 and CustomerID in ( select CustomerID from
--EuropePacific.sales.SalesOrderHeader
--where TerritoryID between 7 and 10 )


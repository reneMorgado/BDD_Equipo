
// Guarda las consultas a ocupar en la aplicación
export const querys = {
  getOrderForTerritory: "SELECT SalesPersonID, COUNT(Sales.SalesOrderHeader.TerritoryID) FROM Sales.SalesOrderHeader INNER JOIN Sales.SalesPerson ON Sales.SalesOrderHeader.SalesPersonID = Sales.SalesPerson.BusinessEntityID GROUP BY SalesPersonID ORDER BY COUNT(*) DESC",
  getClienteNorteAmerica: "SELECT *FROM OPENQUERY(MYSQL, 'SELECT  adventureworks2019.customer.CustomerID, count(adventureworks2019.sles.SalesOrderID) AS NumberOfOrders FROM adventureworks2019.sles INNER JOIN adventureworks2019.customer ON adventureworks2019.sles.CustomerID = adventureworks2019.customer.CustomerID GROUP BY adventureworks2019.customer.CustomerID ORDER BY NumberOfOrders DESC LIMIT 1 ');",
  getBikes: "SELECT * FROM Sales.SpecialOffer WHERE SpecialOfferID IN (SELECT SpecialOfferID FROM Sales.SpecialOfferProduct SOP INNER JOIN Production.Product P ON SOP.ProductID = P.ProductID INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID INNER JOIN Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID WHERE [PC].[Name] = 'Bikes');",
  getProduct: "SELECT *FROM OPENQUERY(MYSQL, 'SELECT *FROM Production.Product WHERE SellEndDate is not null;');",
  getClientes:"SELECT CustomerID FROM Sales.Customer WHERE (TerritoryID = 1 or TerritoryID = 4) AND PersonID IS NULL",
  updateProductById:
    "UPDATE [webstore].[dbo].[Products] SET Name = @name, Description = @description, Quantity = @quantity WHERE Id = @id",
};

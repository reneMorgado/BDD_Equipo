--CONSULTA DISTRIBUIDA

--Consulta 1: 
SELECT *
FROM OPENQUERY(MYSQL, 'SELECT *FROM Production.Product;') as A,
	 OPENQUERY(MYSQL, 'SELECT *FROM adventureworks2019.customer') as B,
	 AdventureWorks2019.NorteAmerica.Customer NC
WHERE NC.TerritoryID IN(1,2,3,4

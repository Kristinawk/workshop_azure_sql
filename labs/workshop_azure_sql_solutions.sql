/**************************************************************************

	Lab01.sql

	CREACIÓN DE OBJETOS (https://dbfiddle.uk/)
		- Probado en SQL Server
		- Probado en Postgre		

**************************************************************************/

CREATE TABLE Cars
(
	ID INT NOT NULL
	, VIN VARCHAR(50) NOT NULL
	, Manufacturer VARCHAR(50) NOT NULL
	, Model VARCHAR(50) NOT NULL
	, "Year" INT NOT NULL
	, Color VARCHAR(50) NOT NULL
);

CREATE TABLE Customers
(
	ID INT NOT NULL
	, "Customer ID" INT NOT NULL
	, Name VARCHAR(50) NOT NULL
	, Phone VARCHAR(50) NOT NULL
	, Email VARCHAR(50) NOT NULL
	, Address VARCHAR(50) NOT NULL
	, City VARCHAR(50) NOT NULL
	, "State/Province" VARCHAR(50) NOT NULL
	, Country VARCHAR(50) NOT NULL
	, Postal INT NOT NULL
);

CREATE TABLE SalesPersons
(
	ID INT NOT NULL
	, "Staff ID" INT NOT NULL
	, Name VARCHAR(50) NOT NULL
	, Store VARCHAR(50) NOT NULL
);

CREATE TABLE Invoices
(
	ID INT NOT NULL
	, "Invoice Number" VARCHAR(50) NOT NULL
	, "Date" DATE NOT NULL
	, Car INT NOT NULL
	, Customer INT NOT NULL
	, "Sales Person" INT NOT NULL
);


/**************************************************************************

	ACTUALIZACIÓN DE REGISTROS
		- Probado en SQL Server
		- Probado en Postgre

**************************************************************************/
INSERT INTO Cars (ID, VIN, Manufacturer, Model, "Year", Color)
VALUES (0, '3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue')
, (1, 'ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Red')
, (2, 'RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion',	2018, 'White')
, (3, 'HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4',	2018, 'Silver')
, (4, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60',	2019, 'Gray')
, (5, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60 Cross Country', 2019, 'Gray');

INSERT INTO Customers (ID, "Customer ID", Name, Phone, Email, Address, City, "State/Province", Country, Postal)
VALUES (0, 10001, 'Pablo Picasso', '+34 636 17 63 82', '-', 'Paseo de la Chopera, 14', 'Madrid', 'Madrid', 'Spain', '28045')
,(1, 20001, 'Abraham Lincoln', '+1 305 907 7086', '-', '120 SW 8th St', 'Miami', 'Florida', 'United States', '33130')
,(2, 30001, 'Napoléon Bonaparte', '+33 1 79 75 40 00', '-', '40 Rue du Colisée', 'Paris', 'Île-de-France', 'France', '75008');


INSERT INTO SalesPersons (ID, "Staff ID", Name, Store)
VALUES (0, '00001', 'Petey Cruiser', 'Madrid')
,(1, '00002', 'Anna Sthesia', 'Barcelona')
,(2, '00003', 'Paul Molive','Berlin')
,(3, '00004', 'Gail Forcewind', 'Paris')
,(4, '00005', 'Paige Turner', 'Mimia')
,(5, '00006', 'Bob Frapples','Mexico City')
,(6, '00007', 'Walter Melon', 'Amsterdam')
,(7, '00008', 'Shonda Leer', 'São Paulo');

INSERT INTO Invoices (ID, "Invoice Number", "Date", Car, Customer, "Sales Person")
VALUES (0, '852399038', '20180822', 0, 1, 3)
,(1, '731166526', '20181231', 3, 0, 5)
,(2, '271135104', '20190122', 2, 2, 7);


/**************************************************************************

	ACTUALIZACIÓN DE CONTENIDO
		- Probado en SQL Server
		- Probado en Postgre

**************************************************************************/
UPDATE SalesPersons SET Store = 'Miami' WHERE ID = 4;

UPDATE Customers SET Email = 'ppicaso@gmail.com' WHERE Name = 'Pablo Picasso';
UPDATE Customers SET Email = 'lincoln@us.gob' WHERE Name = 'Abraham Lincoln';
UPDATE Customers SET Email = 'hello@napoleon.me' WHERE Name = 'Napoléon Bonaparte';

DELETE FROM Cars WHERE ID = 4;



/**************************************************************************

	PREGUNTAS
		- ¿Podríamos haber evitado el error del código VIN para no tener que eliminar el registro posteriormente? -> UNIQUE
		- ¿Qué pasa si eliminamos un coche sobre el que se tiene factura? -> FK

**************************************************************************/


/**************************************************************************

	Lab02.sql
	
	BD del Lab01 (https://dbfiddle.uk/)
		- Probado en SQL Server
		- Probado en Postgre		

**************************************************************************/

-- Inner Join
SELECT *
FROM Customers INNER JOIN Invoices ON Customers.ID = Invoices.Customer

-- Full join
SELECT *
FROM Customers FULL JOIN Invoices ON Customers.ID = Invoices.Customer

-- Left join
SELECT *
FROM Customers LEFT JOIN Invoices ON Customers.ID = Invoices.Customer
	
-- Right join
SELECT *
FROM Customers RIGHT JOIN Invoices ON Customers.ID = Invoices.Customer

-- Exclusive left join
SELECT *
FROM Customers LEFT JOIN Invoices ON Customers.ID = Invoices.Customer
WHERE Invoices.Customer IS NULL

-- Exclusive right join
SELECT *
FROM Customers RIGHT JOIN Invoices ON Customers.ID = Invoices.Customer
WHERE Customers.ID IS NULL

-- Exclusive full join
SELECT *
FROM Customers FULL JOIN Invoices ON Customers.ID = Invoices.Customer
WHERE Customers.ID IS NULL OR Invoices.Customer IS NULL

-- Cross join
SELECT *
FROM Customers CROSS JOIN Invoices


-- Lab 03 - Challenge 1

SELECT c.FirstName + ' ' + c.LastName AS [Customer Fullname], p.Name AS [Product Name]
FROM SalesLT.Customer AS c
    INNER JOIN SalesLT.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
    INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
    INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
ORDER BY [Customer Fullname], [Product Name]


-- Lab 03 - Challenge 2

SELECT  pm.Name AS 'Product Model', pd.[Description]
FROM SalesLT.ProductModel AS pm    
    INNER JOIN SalesLT.ProductModelProductDescription AS pmpd ON pm.ProductModelID = pmpd.ProductModelID
    INNER JOIN SalesLT.ProductDescription AS pd on PD.ProductDescriptionID = pmpd.ProductDescriptionID
    INNER JOIN SalesLT.Product AS p ON p.ProductModelID = pm.ProductModelID
WHERE pmpd.Culture = 'ar' AND p.ProductID = 710;


-- Lab 4 - Challenge 1: Qué producto ha sido el más vendido?

SELECT p.Name As [Product], COUNT(*) AS [Total] – aunque más correcto sería hacer COUNT(DISTINCT soh.SalesOrderID)
FROM SalesLT.SalesOrderHeader AS soh 
    INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
    INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY 2 DESC


-- Lab 4 - Challenge 2: Cuántas unidades han sido vendidas por categoría y producto?

SELECT  pc.Name AS [Category], p.name AS Product, SUM(sod.OrderQty) AS [Total Qty]
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
    INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY  pc.Name, p.Name
ORDER BY 1, 2 


-- Lab 4 - Challenge 3: Cuántas unidades han sido vendidas por categoría, y por categoría producto?

SELECT pc.Name AS [Category],  p.Name As [Product], SUM(shd.OrderQty) AS [Total Qty]
FROM SalesLT.SalesOrderHeader AS soh 
    INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
    INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
    INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY GROUPING SETS ((pc.Name), (pc.Name, p.Name))
ORDER BY 1, 2 


-- Lab 4 - Challenge 4 (BONUS): De la consulta anterior, descarta los grupos que tengan menos de 8 tickets de venta

SELECT pc.Name AS [Category],  p.Name As [Product], SUM(shd.OrderQty) AS [Total Qty]
FROM SalesLT.SalesOrderHeader AS soh 
    INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
    INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
    INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY GROUPING SETS ((pc.Name), (pc.Name, p.Name))
HAVING COUNT(DISTINCT soh.SalesOrderID) >= 8


-- Lab 5 - Challenge 1: Revisa la salida de la siguiente instrucción

SELECT p.ProductID, pc.Name AS 'Category', p.Name AS 'Product', p.[Size]

	-- ranking
    , ROW_NUMBER() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Row Number Per Category & Size'
    , RANK() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Rank Per Category & Size'
    , DENSE_RANK() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Dense Rank Per Category & Size'
    , NTILE(2) OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'NTile Per Category & Name'

	-- aggregate
    , SUM(p.StandardCost) OVER() AS 'Standard Cost Grand Total'
    , SUM(p.StandardCost) OVER(PARTITION BY p.ProductCategoryID) AS 'Standard Cost Per Category'
    
	-- analytical
    , LAG(p.Name, 1, '-- NOT FOUND --') OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Previous Product Per Category'
    , LEAD(p.Name, 1, '-- NOT FOUND --') OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Next Product Per Category'
    , FIRST_VALUE(p.Name) OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'First Product Per Category'
    , LAST_VALUE(p.Name) OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Last Product Per Category'
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
ORDER BY pc.Name, p.Name 


-- Lab06 - sproc call.sql

--	Mostramos la dirección de un cliente aleatorio
SELECT TOP 1 c.CustomerID, c.FirstName, c.LastName, a.AddressID, ca.AddressType, a.AddressLine1, a.City, a.StateProvince, a.CountryRegion, a.PostalCode
FROM SalesLT.Customer AS c
    INNER JOIN SalesLT.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID
    INNER JOIN SalesLT.Address AS a ON ca.AddressID = a.AddressID
WHERE c.CustomerID = 29485
ORDER BY a.ModifiedDate DESC;


--	La modificamos
EXEC [SalesLT].[uspUpdateCustomerAddress]
    @CustomerID = 29485, 
	@AddressType = 'HOME', 
    @AddressLine = 'Nueva dirección', 
    @City ='Nueva ciudad', 
    @StateProvince = ' Nuevo Estado', 
    @CountryRegion = 'Nueva Región',  
    @PostalCode = '00000';


--	Mostramos la última dirección asignada del mismo cliente
SELECT TOP 1 c.CustomerID, c.FirstName, c.LastName, a.AddressID, ca.AddressType, a.AddressLine1, a.City, a.StateProvince, a.CountryRegion, a.PostalCode
FROM SalesLT.Customer AS c
    INNER JOIN SalesLT.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID
    INNER JOIN SalesLT.Address AS a ON ca.AddressID = a.AddressID
WHERE c.CustomerID = 29485
ORDER BY a.ModifiedDate DESC;


-- Lab06 - sproc create.sql

CREATE OR ALTER PROCEDURE [SalesLT].[uspUpdateCustomerAddress]
    @CustomerID INT, 
    @AddressType NVARCHAR(50), 
    @AddressLine NVARCHAR(50), 
    @City NVARCHAR(50), 
    @StateProvince NVARCHAR(50), 
    @CountryRegion NVARCHAR(50),  
    @PostalCode NVARCHAR(50)
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
	
	
		--	Comprobamos que el cliente referenciado existe. En caso contrario se devuelve mensaje de error 
		-- y finaliza la ejecución del procedimiento
		IF NOT EXISTS (SELECT 1 FROM SalesLT.Customer WHERE CustomerID = @CustomerID)
		BEGIN
			RAISERROR(N'Customer doesn''t exist', 16, 127) WITH NOWAIT;
			RETURN;
		END
	
		--	Iniciamos transacción para ejecutar todas las instrucciones como si fuera una sola
        BEGIN TRANSACTION;
		
		DECLARE @newAddress INT;
		
		--	Insertamos un nuevo registro
		INSERT INTO SalesLT.Address (AddressLine1, City, StateProvince, CountryRegion, PostalCode)
		VALUES (@AddressLine, @City, @StateProvince, @CountryRegion, @PostalCode)

		--	Recogemos el valor del identificador autogenerado;
		SELECT @newAddress = SCOPE_IDENTITY() ;

		--	Almacenamos la nueva relación entre Cliente y su dirección
        INSERT INTO SalesLT.CustomerAddress (CustomerID, AddressID, AddressType)            
        VALUES (@CustomerID, @newAddress, @AddressType);

		-- 	Confirmamos transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- 	Cancelamos transacción en caso de que haya habido algún error		
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END


        DECLARE  @ErrorMessage  NVARCHAR(4000),  @ErrorSeverity INT,  @ErrorState    INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
        
    END CATCH;
	

END;

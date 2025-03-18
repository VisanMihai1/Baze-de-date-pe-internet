CREATE PROCEDURE GetProduseDinCategorie
    @CategorieID INT
AS
BEGIN
    SELECT P.ProdusID, P.NumeProdus, P.Pret, P.Stoc, C.NumeCategorie, F.NumeFurnizor
    FROM Produse P
        INNER JOIN Categorii C ON P.CategorieID = C.CategorieID
        INNER JOIN Furnizori F ON P.FurnizorID = F.FurnizorID
    WHERE P.CategorieID = @CategorieID;
END;
GO

CREATE FUNCTION CalculeazaTotalVanzariPerCategorie
(
    @CategorieID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);

    SELECT @Total = SUM(DC.Cantitate * P.Pret)
    FROM DetaliiComanda DC
        INNER JOIN Produse P ON DC.ProdusID = P.ProdusID
    WHERE P.CategorieID = @CategorieID;

    RETURN ISNULL(@Total, 0);
END;
GO

CREATE PROCEDURE GetRaportVanzariLunar
    @An INT,
    @DateLunare CURSOR VARYING OUTPUT
AS
BEGIN
    SET @DateLunare = CURSOR FOR
    SELECT
        MONTH(C.DataComanda) AS Luna,
        SUM(DC.Cantitate * P.Pret) AS TotalVanzari,
        COUNT(DISTINCT C.ComandaID) AS NumarComenzi
    FROM Comenzi C
        INNER JOIN DetaliiComanda DC ON C.ComandaID = DC.ComandaID
        INNER JOIN Produse P ON DC.ProdusID = P.ProdusID
    WHERE YEAR(C.DataComanda) = @An
    GROUP BY MONTH(C.DataComanda)
    ORDER BY Luna;

    OPEN @DateLunare;
END;
GO

-- Additional stored function with return (requirement a)
CREATE FUNCTION CalculeazaValoareStoc
(
    @ProdusID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @ValoareTotala DECIMAL(10,2);
    SELECT @ValoareTotala = Pret * Stoc
    FROM Produse
    WHERE ProdusID = @ProdusID;
    RETURN ISNULL(@ValoareTotala, 0);
END;
GO

-- Stored procedure with IN/OUT parameters (requirement b)
CREATE PROCEDURE ActualizeazaStoc
    @ProdusID INT,
    @CantitateCeruta INT,
    @StocDisponibil INT OUTPUT,
    @OperatieReusita BIT OUTPUT
AS
BEGIN
    SELECT @StocDisponibil = Stoc
    FROM Produse
    WHERE ProdusID = @ProdusID;

    IF @StocDisponibil >= @CantitateCeruta
    BEGIN
        UPDATE Produse 
        SET Stoc = Stoc - @CantitateCeruta 
        WHERE ProdusID = @ProdusID;

        SET @OperatieReusita = 1;
        SET @StocDisponibil = @StocDisponibil - @CantitateCeruta;
    END
    ELSE
        SET @OperatieReusita = 0;
END;
GO

-- Function that returns a cursor (requirement c)
CREATE PROCEDURE GetTopProdusePerFurnizor
    @NumarProduse INT,
    @ResultCursor CURSOR VARYING OUTPUT
AS
BEGIN
    SET @ResultCursor = CURSOR FORWARD_ONLY STATIC FOR
        SELECT TOP (@NumarProduse)
        P.ProdusID,
        P.NumeProdus,
        F.NumeFurnizor,
        P.Pret,
        P.Stoc,
        dbo.CalculeazaValoareStoc(P.ProdusID) as ValoareTotala
    FROM Produse P
        INNER JOIN Furnizori F ON P.FurnizorID = F.FurnizorID
    ORDER BY P.Pret DESC;

    OPEN @ResultCursor;
END;
GO

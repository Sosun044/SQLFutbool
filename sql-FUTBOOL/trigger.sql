-- Maksimum maaş sınırlarını ihlal eden durumlarda iptal eder, geçerli işlemleri log tablosuna kayıt eder.
IF OBJECT_ID('dbo.trg_AfterContractUpdate', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.trg_AfterContractUpdate;
END
GO

-- Eğer işlem başarılı ise bu tabloda işlem gözükür
IF OBJECT_ID('dbo.tblContractLog', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.tblContractLog
    (
        LogID INT IDENTITY(1,1) PRIMARY KEY,
        TakimAdi NVARCHAR(100),
        OyuncuAdi NVARCHAR(100),
        EskiMaas INT,
        YeniMaas INT,
        DegisimTarihi DATETIME DEFAULT GETDATE()
    );
END
GO

CREATE TRIGGER dbo.trg_AfterContractUpdate
ON dbo.tblSozlesme
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaxMaas INT = 1500000;

    IF EXISTS 
    (
        SELECT 1
        FROM INSERTED i
        WHERE i.Maas > @MaxMaas
    )
    BEGIN
        PRINT 'Maksimum maaş sınırı aşıldı. İşlem iptal ediliyor.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO dbo.tblContractLog (TakimAdi, OyuncuAdi, EskiMaas, YeniMaas, DegisimTarihi)
    SELECT 
        t.Ad AS TakimAdi,
        p.Ad + ' ' + p.Soyad AS OyuncuAdi,
        d.Maas AS EskiMaas,
        i.Maas AS YeniMaas,
        GETDATE() AS DegisimTarihi
    FROM 
        DELETED d
    LEFT JOIN INSERTED i ON d.PersonelID = i.PersonelID
    JOIN tblPersonel p ON d.PersonelID = p.PersonelID
    JOIN tblFutbolTakimi t ON d.TakimID = t.TakimID;
END
GO

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Besiktas', 
    @OyuncuAdi = 'Mauro Icardi', 
    @YeniMaas = 2000000, 
    @YeniSonlanmaTarihi = '2025-06-30', 
    @Silinsin = 0; -- Bu işlem iptal edilmelidir
    
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Besiktas', 
    @OyuncuAdi = 'Mauro Icardi', 
    @YeniMaas = 1200000, 
    @YeniSonlanmaTarihi = '2025-06-30', 
    @Silinsin = 0; -- Bu işlem başarılı olmalıdır

SELECT * FROM dbo.tblContractLog;

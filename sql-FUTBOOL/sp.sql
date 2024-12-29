-- Personelin kontratını yenileme veya işine son vermek için prosedür
IF OBJECT_ID('dbo.sp_UpdatePlayerContract', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_UpdatePlayerContract;
END
GO

CREATE PROCEDURE dbo.sp_UpdatePlayerContract
    @TakimAdi NVARCHAR(100),
    @OyuncuAdi NVARCHAR(100),
    @YeniMaas INT,
    @YeniSonlanmaTarihi DATE,
    @Silinsin BIT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        IF @Silinsin = 0
        BEGIN
            UPDATE s
            SET s.Maas = @YeniMaas,
                s.SonlanmaTarihi = @YeniSonlanmaTarihi
            FROM tblSozlesme s
            JOIN tblPersonel p ON s.PersonelID = p.PersonelID
            JOIN tblFutbolTakimi t ON s.TakimID = t.TakimID
            WHERE t.Ad = @TakimAdi AND (p.Ad + ' ' + p.Soyad) = @OyuncuAdi;
        END
        ELSE
        BEGIN
            DELETE s
            FROM tblSozlesme s
            JOIN tblPersonel p ON s.PersonelID = p.PersonelID
            JOIN tblFutbolTakimi t ON s.TakimID = t.TakimID
            WHERE t.Ad = @TakimAdi AND (p.Ad + ' ' + p.Soyad) = @OyuncuAdi;
        END

        COMMIT TRANSACTION;
        PRINT 'İşlem başarıyla tamamlandı.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Bir hata oluştu. İşlemler geri alındı.';
        THROW;
    END CATCH
END
GO

-- Galatasaray
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Galatasaray', 
    @OyuncuAdi = 'Mauro Icardi', 
    @YeniMaas = 1200000, 
    @YeniSonlanmaTarihi = '2025-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Galatasaray', 
    @OyuncuAdi = 'Yağmur Uslu', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Fenerbahçe
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Fenerbahçe', 
    @OyuncuAdi = 'Edin Džeko', 
    @YeniMaas = 1400000, 
    @YeniSonlanmaTarihi = '2026-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Fenerbahçe', 
    @OyuncuAdi = 'Ece Türkoğlu', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Beşiktaş
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Beşiktaş', 
    @OyuncuAdi = 'Cenk Tosun', 
    @YeniMaas = 1500000, 
    @YeniSonlanmaTarihi = '2026-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Beşiktaş', 
    @OyuncuAdi = 'Ece Ertürk', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Trabzonspor
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Trabzonspor', 
    @OyuncuAdi = 'Uğurcan Çakır', 
    @YeniMaas = 1000000, 
    @YeniSonlanmaTarihi = '2026-05-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Trabzonspor', 
    @OyuncuAdi = 'Ayşe Kaya', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Manchester United
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Manchester United', 
    @OyuncuAdi = 'Bruno Fernandes', 
    @YeniMaas = 1300000, 
    @YeniSonlanmaTarihi = '2027-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Manchester United', 
    @OyuncuAdi = 'Ella Toone', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Liverpool
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Liverpool', 
    @OyuncuAdi = 'Mohamed Salah', 
    @YeniMaas = 2000000, 
    @YeniSonlanmaTarihi = '2027-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Liverpool', 
    @OyuncuAdi = 'Katie Stengel', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Arsenal
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Arsenal', 
    @OyuncuAdi = 'Bukayo Saka', 
    @YeniMaas = 1500000, 
    @YeniSonlanmaTarihi = '2026-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Arsenal', 
    @OyuncuAdi = 'Kim Little', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Chelsea
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Chelsea', 
    @OyuncuAdi = 'Raheem Sterling', 
    @YeniMaas = 1800000, 
    @YeniSonlanmaTarihi = '2027-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Chelsea', 
    @OyuncuAdi = 'Fran Kirby', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

-- Real Madrid
EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Real Madrid', 
    @OyuncuAdi = 'Karim Benzema', 
    @YeniMaas = 2200000, 
    @YeniSonlanmaTarihi = '2027-06-30', 
    @Silinsin = 0;

EXEC dbo.sp_UpdatePlayerContract 
    @TakimAdi = 'Real Madrid', 
    @OyuncuAdi = 'Marta Rodriguez', 
    @YeniMaas = NULL, 
    @YeniSonlanmaTarihi = NULL, 
    @Silinsin = 1;

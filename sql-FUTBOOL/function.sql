-- İsmi verilen takıma göre en yüksek Maaş alan oyuncu
IF OBJECT_ID('dbo.fn_GetHighestPaidPlayer', 'FN') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fn_GetHighestPaidPlayer;
END
GO

CREATE FUNCTION dbo.fn_GetHighestPaidPlayer (@TakimAdi NVARCHAR(100))
RETURNS NVARCHAR(200)
AS
BEGIN
    DECLARE @OyuncuAdi NVARCHAR(100);
    DECLARE @Maas INT;

    SELECT TOP 1
        @OyuncuAdi = p.Ad + ' ' + p.Soyad, 
        @Maas = s.Maas
    FROM tblSozlesme s
    JOIN tblPersonel p ON s.PersonelID = p.PersonelID
    JOIN tblFutbolTakimi t ON s.TakimID = t.TakimID
    WHERE t.Ad = @TakimAdi
    ORDER BY s.Maas DESC;

    RETURN 'Personel: ' + @OyuncuAdi + ', Maaş: ' + CAST(@Maas AS NVARCHAR(20));
END
GO

-- Galatasaray
SELECT dbo.fn_GetHighestPaidPlayer('Galatasaray') AS EnYuksekMaasliOyuncu;

-- Fenerbahçe
SELECT dbo.fn_GetHighestPaidPlayer('Fenerbahçe') AS EnYuksekMaasliOyuncu;

-- Beşiktaş
SELECT dbo.fn_GetHighestPaidPlayer('Beşiktaş') AS EnYuksekMaasliOyuncu;

-- Trabzonspor
SELECT dbo.fn_GetHighestPaidPlayer('Trabzonspor') AS EnYuksekMaasliOyuncu;

-- Başakşehir
SELECT dbo.fn_GetHighestPaidPlayer('Başakşehir') AS EnYuksekMaasliOyuncu;

-- Manchester United
SELECT dbo.fn_GetHighestPaidPlayer('Manchester United') AS EnYuksekMaasliOyuncu;

-- Liverpool
SELECT dbo.fn_GetHighestPaidPlayer('Liverpool') AS EnYuksekMaasliOyuncu;

-- Arsenal
SELECT dbo.fn_GetHighestPaidPlayer('Arsenal') AS EnYuksekMaasliOyuncu;

-- Chelsea
SELECT dbo.fn_GetHighestPaidPlayer('Chelsea') AS EnYuksekMaasliOyuncu;

-- Manchester City
SELECT dbo.fn_GetHighestPaidPlayer('Manchester City') AS EnYuksekMaasliOyuncu;

-- Real Madrid
SELECT dbo.fn_GetHighestPaidPlayer('Real Madrid') AS EnYuksekMaasliOyuncu;

-- Barcelona
SELECT dbo.fn_GetHighestPaidPlayer('Barcelona') AS EnYuksekMaasliOyuncu;

-- Atletico Madrid
SELECT dbo.fn_GetHighestPaidPlayer('Atletico Madrid') AS EnYuksekMaasliOyuncu;

-- Sevilla
SELECT dbo.fn_GetHighestPaidPlayer('Sevilla') AS EnYuksekMaasliOyuncu;

-- Valencia
SELECT dbo.fn_GetHighestPaidPlayer('Valencia') AS EnYuksekMaasliOyuncu;

-- Bayern Munich
SELECT dbo.fn_GetHighestPaidPlayer('Bayern Munich') AS EnYuksekMaasliOyuncu;

-- Borussia Dortmund
SELECT dbo.fn_GetHighestPaidPlayer('Borussia Dortmund') AS EnYuksekMaasliOyuncu;

-- RB Leipzig
SELECT dbo.fn_GetHighestPaidPlayer('RB Leipzig') AS EnYuksekMaasliOyuncu;

-- Bayer Leverkusen
SELECT dbo.fn_GetHighestPaidPlayer('Bayer Leverkusen') AS EnYuksekMaasliOyuncu;

-- Wolfsburg
SELECT dbo.fn_GetHighestPaidPlayer('Wolfsburg') AS EnYuksekMaasliOyuncu;

-- Juventus
SELECT dbo.fn_GetHighestPaidPlayer('Juventus') AS EnYuksekMaasliOyuncu;

-- Milan
SELECT dbo.fn_GetHighestPaidPlayer('Milan') AS EnYuksekMaasliOyuncu;

-- Inter
SELECT dbo.fn_GetHighestPaidPlayer('Inter') AS EnYuksekMaasliOyuncu;

-- Napoli
SELECT dbo.fn_GetHighestPaidPlayer('Napoli') AS EnYuksekMaasliOyuncu;

-- Roma
SELECT dbo.fn_GetHighestPaidPlayer('Roma') AS EnYuksekMaasliOyuncu;

-- Paris Saint-Germain
SELECT dbo.fn_GetHighestPaidPlayer('Paris Saint-Germain') AS EnYuksekMaasliOyuncu;

-- Marseille
SELECT dbo.fn_GetHighestPaidPlayer('Marseille') AS EnYuksekMaasliOyuncu;

-- Lyon
SELECT dbo.fn_GetHighestPaidPlayer('Lyon') AS EnYuksekMaasliOyuncu;

-- Monaco
SELECT dbo.fn_GetHighestPaidPlayer('Monaco') AS EnYuksekMaasliOyuncu;

-- Lille
SELECT dbo.fn_GetHighestPaidPlayer('Lille') AS EnYuksekMaasliOyuncu;



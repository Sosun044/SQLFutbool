-- En yüksek maaş alan kullanıcının, takımını, sözlesme bilgilerini gösteren view
IF OBJECT_ID('dbo.vw_HighestPaidPlayers', 'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_HighestPaidPlayers;
END
GO

CREATE VIEW dbo.vw_HighestPaidPlayers AS
SELECT 
    t.Ad AS TakimAdi,
    p.Ad + ' ' + p.Soyad AS OyuncuAdi,
    s.Maas,
    CASE 
        WHEN s.Maas >= 1000000 THEN 'Yüksek Maaş'
        WHEN s.Maas BETWEEN 500000 AND 999999 THEN 'Orta Maaş'
        ELSE 'Düşük Maaş'
    END AS MaasKategori,

    CONVERT(VARCHAR(10), s.GirisTarihi, 105) AS GirisTarihi,
    CONVERT(VARCHAR(10), s.SonlanmaTarihi, 105) AS SonlanmaTarihi,

    dbo.fn_GetHighestPaidPlayer(t.Ad) AS EnYuksekMaasliOyuncu
FROM 
    tblSozlesme s
JOIN 
    tblPersonel p ON s.PersonelID = p.PersonelID
JOIN 
    tblFutbolTakimi t ON s.TakimID = t.TakimID;
GO

SELECT 
    TakimAdi,
    OyuncuAdi,
    Maas,
    MaasKategori,
    GirisTarihi,
    SonlanmaTarihi,
    EnYuksekMaasliOyuncu
FROM 
    dbo.vw_HighestPaidPlayers
WHERE 
    MaasKategori = 'Yüksek Maaş'
ORDER BY 
    Maas DESC;
   

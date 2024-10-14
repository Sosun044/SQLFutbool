
SELECT s.TakimID, MAX(s.Maas) AS MaxMaas,
       (SELECT CONCAT(p.Ad, p.Soyad) 
        FROM tblSozlesme ss
        LEFT JOIN tblPersonel p ON ss.PersonelID = p.PersonelID
        WHERE ss.TakimID = s.TakimID AND ss.Maas = MAX(s.Maas)
        GROUP BY p.Ad, p.Soyad) AS EnYuksekMaasAlan
FROM tblSozlesme s
LEFT JOIN tblPersonel p ON s.PersonelID = p.PersonelID
GROUP BY s.TakimID



SELECT 
    m.MTarih, 
    esT.Ad AS EvSahibiTakim, 
    es.AttigiGol AS EvSahibiGol,
	es.TakimPuan AS TakimSkor,
    dpT.Ad AS DeplasmanTakim, 
    dp.AttigiGol AS DeplasmanGol,
	dp.TakimPuan AS TakimSkor,
	CASE 
        WHEN es.AttigiGol > dp.AttigiGol THEN es.TakimPuan + 3 
        WHEN es.AttigiGol < dp.AttigiGol THEN dp.TakimPuan + 3 
        ELSE 0
	END AS MacSonucuPuan
FROM tblMac m
INNER JOIN tblOlayOlur oo ON m.MacID = oo.MacID
INNER JOIN tblOlay o ON oo.OlayID = o.OlayID
LEFT JOIN tblEvSahibi es ON m.MacID = es.MacID
LEFT JOIN tblFutbolTakimi esT ON es.TakimID = esT.TakimID
LEFT JOIN tblDeplasman dp ON m.MacID = dp.MacID
LEFT JOIN tblFutbolTakimi dpT ON dp.TakimID = dpT.TakimID
WHERE oo.BirincilOyuncu = 14 --Arda Güler
  AND oo.ÝkincilOyuncu = 15; --Mesut Özil



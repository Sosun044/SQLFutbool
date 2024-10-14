CREATE TABLE tblKullanici
(
	TC_no CHAR(11) PRIMARY KEY,
	Ad VARCHAR(50) NOT NULL,
	Soyad VARCHAR(50) NOT NULL,
	Sifre VARCHAR(20) NOT NULL,
	Cinsiyet CHAR(1) CHECK(Cinsiyet IN ('E', 'K')) NOT NULL,
	Dogum_tarihi DATE NOT NULL,
	Yas AS DATEDIFF(yy,Dogum_tarihi, GETDATE()),
	Telefon_no CHAR(10) CONSTRAINT checkTel CHECK(Telefon_no LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	E_posta VARCHAR(50) UNIQUE CHECK(E_posta LIKE'%@%.%') NOT NULL
		
)
GO

CREATE TABLE tblAdresIl
(
	Kod CHAR(2) PRIMARY KEY,
	Ad VARCHAR(20) NOT NULL
)
GO

CREATE TABLE tblAdresIlce
(
	IlceID INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(20) NOT NULL,
	IlKodu CHAR(2) FOREIGN KEY REFERENCES tblAdresIl(Kod)
		ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
)
GO

CREATE TABLE tblAdres
(
    AdresID INT IDENTITY(1,1) PRIMARY KEY,
    Cadde VARCHAR(20) NOT NULL,
    Bina_no VARCHAR(10) NOT NULL, 
    Adres_metin VARCHAR(255),
	Il CHAR(2) FOREIGN KEY REFERENCES tblAdresIl(Kod)
		ON UPDATE CASCADE NOT NULL,
	Ilce INT FOREIGN KEY REFERENCES tblAdresIlce(IlceID)
		ON UPDATE CASCADE NOT NULL
);
GO

CREATE TABLE tblUlke
(
	UlkeID INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(30) NOT NULL,
)
GO

CREATE TABLE tblStadyum
(
	StadyumID INT IDENTITY(1,1) PRIMARY KEY,
	Kapasite INT NOT NULL,
	AdresID INT FOREIGN KEY REFERENCES tblAdres(AdresID)
		ON UPDATE CASCADE NOT NULL,
	Ulke INT FOREIGN KEY REFERENCES tblUlke(UlkeID)
		ON UPDATE CASCADE NOT NULL,
)
GO

CREATE TABLE tblPersonelAlan
(
	AlanID INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(50) NOT NULL,
)
GO

CREATE TABLE tblHakemPozisyon
(
	PozisyonID INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(30) CHECK(Ad IN('Orta Hakem', 'Yard�mc� Hakem')) NOT NULL,
)
GO

CREATE TABLE tblHakemLisans
(
	LisansID INT IDENTITY(1,1) PRIMARY KEY,
	T�r� VARCHAR(15) NOT NULL,
	Derece VARCHAR CHECK(Derece IN('Aday Hakem','�l Hakemi','S�per Lig Hakemi')) NOT NULL,
)
GO

CREATE TABLE tblHakem
(
	HakemID INT IDENTITY(1,1) PRIMARY KEY,
	PozisyonID INT FOREIGN KEY REFERENCES tblHakemPozisyon(PozisyonID)
		ON UPDATE CASCADE NOT NULL,
	LisansID INT FOREIGN KEY REFERENCES tblHakemLisans(LisansID)
		ON UPDATE CASCADE NOT NULL,
)
GO

CREATE TABLE tblFutbolTakimi
(
	TakimID INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(100) NOT NULL,
	KurulusTarihi DATE NOT NULL,
	MKBinaAdresi INT FOREIGN KEY REFERENCES tblAdres(AdresID)
		ON UPDATE CASCADE NOT NULL,
	Aciklama VARCHAR(255) NOT NULL,
	Ulke INT FOREIGN KEY REFERENCES tblUlke(UlkeID)
		ON UPDATE CASCADE NOT NULL
)
GO

CREATE TABLE tblPersonel
(
	PersonelID INT IDENTITY(1,1) PRIMARY KEY,
	TC_no CHAR(11),
	Ad VARCHAR(30) NOT NULL,
	Soyad VARCHAR(30) NOT NULL,
	Dogum_tarihi DATE NULL,
	Cinsiyet CHAR(1) CHECK(Cinsiyet IN ('E', 'K')) NOT NULL,
	E_posta VARCHAR(50) UNIQUE CHECK(E_posta LIKE'%@%.%') NOT NULL,
	AlanID INT FOREIGN KEY REFERENCES tblPersonelAlan(AlanID)
		ON UPDATE CASCADE NOT NULL,
	CalistigiTakim INT FOREIGN KEY REFERENCES tblFutbolTakimi(TakimID)
)
GO

CREATE TABLE tblMac
(
	MacID INT IDENTITY(1,1) PRIMARY KEY,
	MTarih DATE NOT NULL,
	Saat TIME NOT NULL,
	HaftaBilgi NVARCHAR(255) NOT NULL,

)
GO

CREATE TABLE tblYonetilirMac
(
	MacID INT FOREIGN KEY REFERENCES tblMac(MacID) NOT  NULL,
	HakemID INT FOREIGN KEY REFERENCES tblHakem(HakemID) NOT NULL,
	CONSTRAINT PKtblYonetilirMac PRIMARY KEY(MacID,HakemID)
)
GO

CREATE TABLE tblDaYapilir
(
	MacID INT FOREIGN KEY REFERENCES tblMac(MacID) NOT NULL,
	StadyumID INT FOREIGN KEY REFERENCES tblStadyum(StadyumID) NOT NULL,
	CONSTRAINT PKtblDaYapilir PRIMARY KEY (MacID,StadyumID)
)
GO

CREATE TABLE tblEvSahibi
(
	MacID INT FOREIGN KEY REFERENCES tblMac(MacID) NOT NULL,
	TakimID INT FOREIGN KEY REFERENCES tblFutbolTakimi(TakimID) NOT NULL,
	CONSTRAINT PKtblEvSahibi PRIMARY KEY (MacID,TakimID),
	AttigiGol INT NOT NULL,
	TakimPuan INT NOT NULL
)
GO

CREATE TABLE tblDeplasman
(
	MacID INT FOREIGN KEY REFERENCES tblMac(MacID) NOT NULL,
	TakimID INT FOREIGN KEY REFERENCES tblFutbolTakimi(TakimID) NOT NULL,
	CONSTRAINT PKtblDeplasman PRIMARY KEY (MacID,TakimID),
	AttigiGol INT NOT NULL,
	TakimPuan INT NOT NULL
)
GO

CREATE TABLE tblSozlesme
(
	TakimID INT FOREIGN KEY REFERENCES tblFutbolTakimi(TakimID) NOT NULL,
	PersonelID CHAR(11) FOREIGN KEY REFERENCES tblPersonel(PersonelID) NOT NULL,
	CONSTRAINT PKtblSozlesme PRIMARY KEY (TakimID,PersonelID),
	Maas INT NOT NULL,
	GirisTarihi DATE NOT NULL,
	SonlanmaTarihi DATE NOT NULL,
	Pozisyon VARCHAR(50) NOT NULL
)
GO

CREATE TABLE tblSampiyona
(
	SampiyonaID INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(100) NOT NULL,
	BaslangicTarih DATE NOT NULL,
	BitisTarih DATE NOT NULL,
	SampiyonTakim VARCHAR(100) NULL
)
GO

CREATE TABLE tblLigDurum
(
	TakimID INT FOREIGN KEY REFERENCES tblFutbolTakimi(TakimID) NOT NULL,
	SampiyonaID INT FOREIGN KEY REFERENCES tblSampiyona(SampiyonaID) NOT NULL,
	CONSTRAINT PKtblLigDurum PRIMARY KEY(TakimID,SampiyonaID),
	Puan INT NOT NULL,
	Beraberlik INT NOT NULL,
	Maglubiyet INT NOT NULL,
	Galibiyet INT NOT NULL,
	AtilanGol INT NOT NULL,
	YenilenGol INT NOT NULL,
	Averaj AS (AtilanGol - YenilenGol)
)
GO

CREATE TABLE tblOynanir
(
	MacID INT FOREIGN KEY REFERENCES tblMac(MacID) NOT NULL,
	SampiyonaID INT FOREIGN KEY REFERENCES tblSampiyona(SampiyonaID) NOT NULL,
	CONSTRAINT PKtblOynanir PRIMARY KEY(MacID,SampiyonaID),
)

CREATE TABLE tblOlayOlur
(
	OlayID INT IDENTITY(1,1) PRIMARY KEY,
	MacID INT FOREIGN KEY REFERENCES tblMac(MacID) NOT NULL,
	BirincilOyuncu INT FOREIGN KEY REFERENCES tblPersonel(PersonelID)
		ON UPDATE CASCADE NOT NULL,
	�kincilOyuncu INT FOREIGN KEY REFERENCES tblPersonel(PersonelID)
		ON UPDATE CASCADE NOT NULL,
	Dakika INT NOT NULL,
	T�r� VARCHAR(50) NOT NULL

)
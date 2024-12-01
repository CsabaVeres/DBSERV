-- Vásárlók tábla (részletes particionálás nélkül)
CREATE TABLE vasarlok (
    vasarlo_id SERIAL,
    nev VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cim VARCHAR(200),
    varos VARCHAR(50) NOT NULL,
    PRIMARY KEY (vasarlo_id, varos)
) PARTITION BY LIST (varos);

-- Vásárlók partíciók város alapján
CREATE TABLE vasarlok_budapest PARTITION OF vasarlok FOR VALUES IN ('Budapest');
CREATE TABLE vasarlok_debrecen PARTITION OF vasarlok FOR VALUES IN ('Debrecen');
CREATE TABLE vasarlok_egyeb PARTITION OF vasarlok DEFAULT;

-- Könyvek tábla
CREATE TABLE konyvek (
    konyv_id SERIAL PRIMARY KEY,
    cim VARCHAR(200) NOT NULL,
    szerzo VARCHAR(100),
    ar DECIMAL(10, 2) NOT NULL,
    keszlet INT NOT NULL DEFAULT 0,
    elerheto BOOLEAN NOT NULL DEFAULT TRUE
);

-- Rendelések tábla
CREATE TABLE rendelesek (
    rendeles_id SERIAL PRIMARY KEY,
    vasarlo_id INT NOT NULL,
    datum TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    statusz VARCHAR(20) DEFAULT 'Folyamatban',
    FOREIGN KEY (vasarlo_id) REFERENCES vasarlok (vasarlo_id) ON DELETE CASCADE
);

-- Rendelés tételek tábla
CREATE TABLE rendeles_tetelek (
    tetel_id SERIAL PRIMARY KEY,
    rendeles_id INT NOT NULL,
    konyv_id INT NOT NULL,
    mennyiseg INT NOT NULL,
    egysegar DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (rendeles_id) REFERENCES rendelesek (rendeles_id) ON DELETE CASCADE,
    FOREIGN KEY (konyv_id) REFERENCES konyvek (konyv_id) ON DELETE CASCADE
);

-- Számlák tábla
CREATE TABLE szamlak (
    szamla_id SERIAL PRIMARY KEY,
    rendeles_id INT NOT NULL,
    osszeg DECIMAL(10, 2) NOT NULL,
    kiallitas_datuma TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fizetesi_mod VARCHAR(20),
    fizetett BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (rendeles_id) REFERENCES rendelesek (rendeles_id) ON DELETE CASCADE
);

-- Adatok feltöltése

-- Vásárlók feltöltése (tömeges)
INSERT INTO vasarlok (nev, email, cim, varos)
SELECT DISTINCT
    'Vasarlo ' || i,
    'Vasarlo' || i || '@example.com',
    'Cím ' || i,
    CASE WHEN i % 3 = 0 THEN 'Budapest'
         WHEN i % 3 = 1 THEN 'Debrecen'
         ELSE 'Szeged'
    END
FROM generate_series(1, 50000) i;

-- Könyvek feltöltése (például 10 000 különböző könyv)
INSERT INTO konyvek (cim, szerzo, ar, keszlet)
SELECT
    'Konyv ' || i,
    CASE WHEN i % 2 = 0 THEN 'Szerzo A' ELSE 'Szerzo B' END,
    ROUND((RANDOM() * 100 + 50)::NUMERIC, 2),
    (RANDOM() * 500)::INT
FROM generate_series(1, 10000) i;

-- Rendelések feltöltése (tömeges)
INSERT INTO rendelesek (vasarlo_id, datum)
SELECT (RANDOM() * (SELECT MAX(vasarlo_id) FROM vasarlok) + 1)::INT, NOW()
FROM generate_series(1, 100000);

-- Rendelés tételek feltöltése
INSERT INTO rendeles_tetelek (rendeles_id, konyv_id, mennyiseg, egysegar)
SELECT
    (RANDOM() * 99999 + 1)::INT,
    (RANDOM() * 9999 + 1)::INT,
    (RANDOM() * 10 + 1)::INT,
    ROUND((RANDOM() * 100 + 10)::NUMERIC, 2)
FROM generate_series(1, 1000000);

-- Számlák feltöltése (tömeges)
INSERT INTO szamlak (rendeles_id, osszeg)
SELECT
    (RANDOM() * 99999 + 1)::INT,
    ROUND((RANDOM() * 9999 + 1)::NUMERIC, 2)
FROM generate_series(1, 1000000);


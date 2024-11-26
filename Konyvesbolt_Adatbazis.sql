-- Vásárlók tábla (részletes particionálás nélkül)
CREATE TABLE vasarlok (
    vasarlo_id SERIAL PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cim VARCHAR(200),
    varos VARCHAR(50)
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

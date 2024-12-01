-- Vásárlók feltöltése
INSERT INTO vasarlok (nev, email, cim, varos) VALUES
('Kovács Péter', 'peter.kovacs@gmail.com', 'Budapest, Kossuth tér 1.', 'Budapest'),
('Nagy Anna', 'anna.nagy@gmail.com', 'Debrecen, Kossuth utca 10.', 'Debrecen'),
('Tóth László', 'laszlo.toth@gmail.com', 'Szeged, Petőfi utca 5.', 'Szeged');

-- Vásárlók feltöltése (tömeges)
INSERT INTO vasarlok (vasarlo_nev, varos, regisztracio_datum)
SELECT
    'Vasarlo ' || i,
    CASE WHEN i % 3 = 0 THEN 'Budapest' WHEN i % 3 = 1 THEN 'Debrecen' ELSE 'Szeged' END,
    NOW() - (INTERVAL '1 day' * (RANDOM() * 1000)::INT)
FROM generate_series(1, 50000) i;

-- Könyvek feltöltése
INSERT INTO konyvek (cim, szerzo, ar, keszlet) VALUES
('A tenger szívében', 'Herman Melville', 3500.00, 50),
('A nagy Gatsby', 'F. Scott Fitzgerald', 4500.00, 30),
('A 451 fok Fahrenheit', 'Ray Bradbury', 2500.00, 20);

-- Könyvek feltöltése (például 10 000 különböző könyv)
INSERT INTO termekek (termek_nev, kategoria, ar, keszlet_mennyiseg)
SELECT
    'Termek ' || i,
    CASE WHEN i % 2 = 0 THEN 'Zöldség' ELSE 'Gyümölcs' END,
    RANDOM() * 100 + 50,
    (RANDOM() * 500)::INT
FROM generate_series(1, 10000) i;

-- Rendelések feltöltése
INSERT INTO rendelesek (vasarlo_id) VALUES (1), (2);

-- Rendelés tételek feltöltése
INSERT INTO rendeles_tetelek (rendeles_id, konyv_id, mennyiseg, egysegar) VALUES
(1, 1, 2, 3500.00),
(1, 2, 1, 4500.00),
(2, 3, 1, 2500.00);

-- Számlák feltöltése
INSERT INTO szamlak (rendeles_id, osszeg, fizetesi_mod) VALUES
(1, 11500.00, 'Készpénz'),
(2, 2500.00, 'Bankkártya');

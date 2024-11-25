-- Vásárlók feltöltése
INSERT INTO vasarlok (nev, email, cim, varos) VALUES
('Kovács Péter', 'peter.kovacs@gmail.com', 'Budapest, Kossuth tér 1.', 'Budapest'),
('Nagy Anna', 'anna.nagy@gmail.com', 'Debrecen, Kossuth utca 10.', 'Debrecen'),
('Tóth László', 'laszlo.toth@gmail.com', 'Szeged, Petőfi utca 5.', 'Szeged');

-- Könyvek feltöltése
INSERT INTO konyvek (cim, szerzo, ar, keszlet) VALUES
('A tenger szívében', 'Herman Melville', 3500.00, 50),
('A nagy Gatsby', 'F. Scott Fitzgerald', 4500.00, 30),
('A 451 fok Fahrenheit', 'Ray Bradbury', 2500.00, 20);

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

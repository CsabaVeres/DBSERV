CREATE OR REPLACE FUNCTION generate_szamla(rendeles_id_input INT)
RETURNS VOID AS $$
DECLARE
    rendeles_osszeg DECIMAL(10, 2);
BEGIN
    SELECT SUM(mennyiseg * egysegar) INTO rendeles_osszeg
    FROM rendeles_tetelek
    WHERE rendeles_id = rendeles_id_input;

    INSERT INTO szamlak (rendeles_id, osszeg, fizetesi_mod, fizetett)
    VALUES (rendeles_id_input, rendeles_osszeg, 'Készpénz', FALSE);
END;
$$ LANGUAGE plpgsql;

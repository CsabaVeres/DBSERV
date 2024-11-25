CREATE OR REPLACE FUNCTION update_konyv_keszlet()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE konyvek
    SET keszlet = keszlet - NEW.mennyiseg,
        elerheto = CASE WHEN keszlet - NEW.mennyiseg > 0 THEN TRUE ELSE FALSE END
    WHERE konyv_id = NEW.konyv_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_update_keszlet
AFTER INSERT ON rendeles_tetelek
FOR EACH ROW
EXECUTE FUNCTION update_konyv_keszlet();

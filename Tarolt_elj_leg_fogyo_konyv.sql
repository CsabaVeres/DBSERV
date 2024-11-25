CREATE OR REPLACE FUNCTION top_konyvek()
RETURNS TABLE (konyv_id INT, cim VARCHAR, osszes_mennyiseg INT) AS $$
BEGIN
    RETURN QUERY
    SELECT k.konyv_id, k.cim, SUM(rt.mennyiseg) AS osszes_mennyiseg
    FROM konyvek k
    JOIN rendeles_tetelek rt ON k.konyv_id = rt.konyv_id
    GROUP BY k.konyv_id, k.cim
    ORDER BY osszes_mennyiseg DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;

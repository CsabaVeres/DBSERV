SELECT v.nev AS vasarlo_nev, r.rendeles_id, r.datum, k.cim AS konyv_cim, rt.mennyiseg, rt.egysegar
FROM rendelesek r
JOIN vasarlok v ON r.vasarlo_id = v.vasarlo_id
JOIN rendeles_tetelek rt ON r.rendeles_id = rt.rendeles_id
JOIN konyvek k ON rt.konyv_id = k.konyv_id
WHERE r.statusz = 'Folyamatban';

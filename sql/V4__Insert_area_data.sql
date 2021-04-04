INSERT INTO Region(Regname,
                AreaName,
                TerName,
                TerTypeName)
SELECT DISTINCT Regname, AreaName, TerName, TerTypeName FROM zno_table
ON CONFLICT DO NOTHING;


INSERT INTO Region(Regname,
                AreaName,
                TerName,
                TerTypeName)
SELECT DISTINCT EORegName, EOAreaName, EOTerName, null as TerTypeName FROM zno_table
ON CONFLICT DO NOTHING;
INSERT INTO School (EOName,
                   EOTypeName,
                   EOParent,
                   region_id)
SELECT tt.EOName as EOName,
       tt.EOTypeName as EOTypeName,
       tt.EOParent as EOParent,
       (SELECT region_id
        FROM Region as area
        WHERE tt.EORegName = area.RegName
          AND tt.EOAreaName = area.AreaName
          AND tt.EOTerName = area.TerName) as region_id
FROM zno_table as tt
ON CONFLICT DO NOTHING;

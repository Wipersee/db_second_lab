INSERT INTO Student(
                    student_id,
                    Birth,
                    SexTypeName,
                    ExamYear,
                    RegTypeName,
                    ClassProfileName,
                    ClassLangName,
                    region_id,
                    school_id)
SELECT res.student_id, res.Birth, res.SexTypeName, res.TestYear, res.RegTypeName, res.ClassProfileName, res.ClassLangName, res.region_id, res.school_id FROM (
SELECT OutID as student_id, Birth, SexTypeName, TestYear, RegTypeName, ClassProfileName, ClassLangName, Regname, AreaName, TerName, TerTypeName, EOName,
    (SELECT region_id FROM Region where Regname=zno_table.Regname and AreaName=zno_table.AreaName and TerName=zno_table.TerName) as region_id,
    (SELECT school_id FROM School where EOName=zno_table.EOName) as school_id
     FROM zno_table
) as res;
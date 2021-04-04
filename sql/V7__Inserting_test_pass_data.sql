INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    AdaptScale,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.AdaptScale, res.school_id, res.subject_id, res.student_id FROM (
SELECT null as Lang, UkrTestStatus as TestStatus, UkrBall100 as Ball100, UkrBall12 as Ball12, UkrBall as Ball, UkrAdaptScale as AdaptScale, 
    UkrPTName, UkrTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=UkrPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=UkrTest) as subject_id
    FROM zno_table 
) as res;

INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.school_id, res.subject_id, res.student_id FROM (
SELECT histLang as Lang, histTestStatus as TestStatus, histBall100 as Ball100, histBall12 as Ball12, histBall as Ball, 
    histPTName, histTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=histPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=histTest) as subject_id
    FROM zno_table 
) as res;

INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.school_id, res.subject_id, res.student_id FROM (
SELECT mathLang as Lang, mathTestStatus as TestStatus, mathBall100 as Ball100, mathBall12 as Ball12, mathBall as Ball,
    mathPTName, mathTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=mathPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=mathTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.school_id, res.subject_id, res.student_id FROM (
SELECT physLang as Lang, physTestStatus as TestStatus, physBall100 as Ball100, physBall12 as Ball12, physBall as Ball, 
    physPTName, physTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=physPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=physTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.school_id, res.subject_id, res.student_id FROM (
SELECT chemLang as Lang, chemTestStatus as TestStatus, chemBall100 as Ball100, chemBall12 as Ball12, chemBall as Ball, 
    chemPTName, chemTest, OutID as
    student_id,
    (SELECT school_id FROM School where EOName=chemPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=chemTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.school_id, res.subject_id, res.student_id FROM (
SELECT bioLang as Lang, bioTestStatus as TestStatus, bioBall100 as Ball100, bioBall12 as Ball12, bioBall as Ball,
    bioPTName, bioTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=bioPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=bioTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.school_id, res.subject_id, res.student_id FROM (
SELECT geoLang as Lang, geoTestStatus as TestStatus, geoBall100 as Ball100, geoBall12 as Ball12, geoBall as Ball,
    geoPTName, geoTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=geoPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=geoTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    DPALevel,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.DPALevel, res.school_id, res.subject_id, res.student_id FROM (
SELECT null as Lang, engTestStatus as TestStatus, engBall100 as Ball100, engBall12 as Ball12, engBall as Ball, engDPALevel as DPAlevel, 
    engPTName, engTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=engPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=engTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    DPALevel,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.DPALevel, res.school_id, res.subject_id, res.student_id FROM (
SELECT null as Lang, fraTestStatus as TestStatus, fraBall100 as Ball100, fraBall12 as Ball12, fraBall as Ball, fraDPALevel as DPAlevel, 
    fraPTName, fraTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=fraPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=fraTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    DPALevel,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.DPALevel, res.school_id, res.subject_id, res.student_id FROM (
SELECT null as Lang, deuTestStatus as TestStatus, deuBall100 as Ball100, deuBall12 as Ball12, deuBall as Ball, deuDPALevel as DPAlevel,
    deuPTName, deuTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=deuPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=deuTest) as subject_id
    FROM zno_table 
) as res;
INSERT INTO TestPass(Lang,
                    TestStatus,
                    Ball100,
                    Ball12,
                    Ball,
                    DPALevel,
                    school_id,
                    subject_id,
                    student_id)
SELECT res.Lang, res.TestStatus, res.Ball100, res.Ball12, res.Ball, res.DPALevel, res.school_id, res.subject_id, res.student_id FROM (
SELECT null as Lang, spaTestStatus as TestStatus, spaBall100 as Ball100, spaBall12 as Ball12, spaBall as Ball, spaDPALevel as DPAlevel, 
    spaPTName, spaTest, OutID as student_id,
    (SELECT school_id FROM School where EOName=spaPTName) as school_id,
    (SELECT subject_id FROM Subject where Test=spaTest) as subject_id
    FROM zno_table 
) as res;
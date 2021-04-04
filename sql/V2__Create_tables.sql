CREATE TABLE Subject(
    subject_id SERIAL PRIMARY KEY,
    Test varchar(512)
);


CREATE TABLE Region(
    region_id SERIAL PRIMARY KEY,
    Regname varchar(256),
    AreaName varchar(512),
    TerName  varchar(256),
    TerTypeName varchar(1024),
    CONSTRAINT area_unique_constraint UNIQUE (Regname, AreaName, TerName)
);

CREATE TABLE School(
    school_id SERIAL PRIMARY KEY,
    EOName text,
    EOTypeName varchar(512) default NULL,
    EOParent text default NULL,
    region_id integer default NULL,
    CONSTRAINT school_unique_constraint UNIQUE (EOName),
    CONSTRAINT school_territory
        FOREIGN KEY(region_id)
        REFERENCES Region (region_id)
);


CREATE TABLE Student(
    student_id UUID PRIMARY KEY,
    Birth smallint,
    SexTypeName varchar(128),
    ExamYear SMALLINT,
    RegTypeName VARCHAR (1024),
    ClassProfileName VARCHAR (256),
    ClassLangName VARCHAR (256),
    region_id integer,
    school_id integer,
    CONSTRAINT student_territory
        FOREIGN KEY(region_id)
        REFERENCES Region (region_id),
    CONSTRAINT student_school
        FOREIGN KEY(school_id)
        REFERENCES School (school_id)
);

CREATE TABLE TestPass(
    test_pass_id SERIAL PRIMARY KEY,
    Lang VARCHAR (512) default NULL,
    TestStatus VARCHAR (256),
    Ball100 smallint,
    Ball12 smallint,
    Ball smallint,
    DPALevel VARCHAR (512) default NULL,
    AdaptScale smallint default 0,
    school_id integer,
    subject_id integer,
    student_id uuid,
    CONSTRAINT test_pass_school
        FOREIGN KEY(school_id)
        REFERENCES School (school_id),
    CONSTRAINT test_pass_subject
        FOREIGN KEY(subject_id)
        REFERENCES Subject (subject_id),
    CONSTRAINT test_pass_student
        FOREIGN KEY(student_id)
        REFERENCES Student (student_id)
)
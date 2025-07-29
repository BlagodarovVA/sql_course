-- 133 UNIQUE
CREATE TABLE students (
   id          NUMBER
      CONSTRAINT st_id_unique UNIQUE,
   name        VARCHAR2(15),
   course      NUMBER,
   faculty_id  INTEGER,
   avg_score   NUMBER(5,2),
   start_date  DATE,
   scholarship INTEGER
);

CREATE TABLE faculties (
   id   NUMBER,
   name VARCHAR2(15)
);

SELECT *
  FROM students;

INSERT INTO students VALUES ( 1,
                              'Vasya',
                              3,
                              1,
                              8.7,
                              TO_DATE('1-SEP-10'),
                              1520 );
INSERT INTO students VALUES ( 2,
                              'Frosya',
                              2,
                              3,
                              7.5,
                              TO_DATE('1-SEP-15'),
                              2025 );

INSERT INTO students VALUES ( NULL,
                              'Hamyakevich',
                              1,
                              2,
                              9.1,
                              TO_DATE('1-NOV-24'),
                              900 );

DROP TABLE students;
DROP TABLE faculties;

CREATE TABLE students (
   id          NUMBER,
   name        VARCHAR2(15),
   course      NUMBER,
   faculty_id  INTEGER,
   avg_score   NUMBER(5,2),
   start_date  DATE,
   scholarship INTEGER,
   CONSTRAINT st_id_unique UNIQUE ( id,
                                    name )
);

SELECT *
  FROM students;
SELECT *
  FROM faculties;

ALTER TABLE students ADD CONSTRAINT st_id_unique UNIQUE ( id );

INSERT INTO faculties VALUES ( 1,
                               'CS' );
INSERT INTO faculties VALUES ( 2,
                               'Economics' );
INSERT INTO faculties VALUES ( 2,
                               'Philosophy' );

UPDATE faculties
   SET
   id = 3
 WHERE name = 'Philosophy';

ALTER TABLE faculties ADD UNIQUE ( id );

ALTER TABLE students MODIFY (
   id
      CONSTRAINT abc UNIQUE
);
ALTER TABLE faculties MODIFY (
   id unique
);

ALTER TABLE students DROP CONSTRAINT abc;

-- 134 NOT NUL
DROP TABLE students;

CREATE TABLE students (
   id         NUMBER
      CONSTRAINT st_id_unique UNIQUE,
   name       VARCHAR2(15),
   course     NUMBER
      CONSTRAINT stud_course_notnull NOT NULL,
   -- course     NUMBER NOT NULL,
   faculty_id INTEGER
);

INSERT INTO students VALUES ( 3,
                              'Valery',
                              2,
                              4 );

SELECT *
  FROM students;

CREATE TABLE students (
   id         NUMBER,
   name       VARCHAR2(15),
   course     NUMBER,
   faculty_id INTEGER
);

ALTER TABLE students MODIFY (
   course
      CONSTRAINT st_course_notnull NOT NULL
);
ALTER TABLE students MODIFY (
   course NOT NULL
);

INSERT INTO students (
   id,
   name,
   faculty_id
) VALUES ( 5,
           'Diana',
           3 );

ALTER TABLE students MODIFY (
   course null
);

-- 135 PRIMARY KEY
DROP TABLE students;

SELECT *
  FROM students;

CREATE TABLE students (
   id         NUMBER
      CONSTRAINT st_id_pk PRIMARY KEY,
   name       VARCHAR2(15),
   course     NUMBER,
   faculty_id INTEGER
   -- CONSTRAINT st_id_pk PRIMARY KEY (id)
   -- PRIMARY KEY (id)
);

INSERT INTO students VALUES ( 3,
                              'Valery',
                              NULL,
                              4 );
INSERT INTO students VALUES ( 4,
                              'Diana',
                              2,
                              4 );

ALTER TABLE students MODIFY (
   id
      CONSTRAINT pk PRIMARY KEY
);
ALTER TABLE students ADD CONSTRAINT pk PRIMARY KEY ( id );
ALTER TABLE students ADD PRIMARY KEY ( id );
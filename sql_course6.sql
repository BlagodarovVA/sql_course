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
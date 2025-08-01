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

INSERT INTO students VALUES 
( 1, 'Vasya', 3, 1, 8.7, TO_DATE('1-SEP-10'), 1520 );
INSERT INTO students VALUES 
( 2, 'Frosya', 2, 3, 7.5, TO_DATE('1-SEP-15'), 2025 );

INSERT INTO students VALUES 
( NULL, 'Hamyakevich', 1, 2, 9.1, TO_DATE('1-NOV-24'), 900 );

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

INSERT INTO students VALUES 
( 3, 'Valery', 2, 4 );

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

-- 136 FOREIGN KEY
DROP TABLE students;
DROP TABLE faculties;

SELECT * FROM students;
SELECT * FROM faculties;

CREATE TABLE students (
   id         NUMBER,
   name       VARCHAR2(15),
   course     NUMBER,
   faculty_id INTEGER
    --CONSTRAINT st_fac_fk REFERENCES faculties ( id )
);

CREATE TABLE faculties (
   id   NUMBER, -- PRIMARY KEY,
   name VARCHAR2(15)
);

INSERT INTO students 
( id, name, course, faculty_id) 
VALUES 
( 1, 'Diana', 2, 2);
INSERT INTO students
( id, name, course, faculty_id) 
VALUES 
( 2, 'Valery', 2, NULL );

INSERT INTO faculties VALUES ( 1, 'CS' );
INSERT INTO faculties VALUES ( 2, 'Marketing' );

ALTER TABLE students MODIFY (
   faculty_id CONSTRAINT fk REFERENCES faculties ( id )
);
ALTER TABLE students MODIFY (
   CONSTRAINT fk faculty_id REFERENCES faculties ( id )
);
ALTER TABLE students MODIFY ( faculty_id REFERENCES faculties(id));
ALTER TABLE students ADD CONSTRAINT fk FOREIGN KEY faculty_id REFERENCES faculties(id);
ALTER TABLE students ADD FOREIGN KEY faculty_id REFERENCES faculties(id);

-- 137
DROP TABLE students;
DROP TABLE faculties;

SELECT * FROM students;
SELECT * FROM faculties;

CREATE TABLE faculties (
   id   NUMBER PRIMARY KEY,
   name VARCHAR2(15)
);

CREATE TABLE students (
   id         NUMBER,
   name       VARCHAR2(15),
   course     NUMBER,
   faculty_id INTEGER REFERENCES faculties
);

INSERT INTO faculties VALUES 
( 1, 'CS' );
INSERT INTO faculties VALUES 
( 2, 'Marketing' );
INSERT INTO faculties VALUES
( 3, 'FKP' );
INSERT INTO faculties VALUES 
( 4, 'KSIS' );

INSERT INTO students (
   id, name, course, faculty_id
) VALUES ( 1, 'Diana', 3, 1 );
INSERT INTO students (
   id, name, course, faculty_id
) VALUES (3, 'Valery', 2, 2);
           

delete from faculties where id = 1;

CREATE TABLE students (
   id         NUMBER,
   name       VARCHAR2(15),
   course     NUMBER,
   --faculty_id INTEGER REFERENCES faculties ON DELETE CASCADE
   faculty_id INTEGER REFERENCES faculties ON DELETE SET NULL
);

-- 138 CHECK
DROP TABLE students;
SELECT * FROM students;

CREATE TABLE students (
   id         NUMBER,
   name       VARCHAR2(15),
   course     NUMBER, -- constraint ch CHECK (course > 0 AND course < 6),
   email      VARCHAR2(15) CHECK (INSTR(email, '@')>0) unique,
   faculty_id INTEGER
   -- CHECK (course > id)
   -- constraint ch CHECK (course > 0 AND course < 6)
);

INSERT INTO students (
   id, name, course, faculty_id
) VALUES (2, 'Homyak', 5, 2);

update students set course = 10 where id = 1;

alter table students modify (id constraint ch CHECK (id>=1));
alter table students add constraint ch2 CHECK (course < 10);

INSERT INTO students VALUES ( 1, 'Diana', 3, 'diana@tut.com', 1 );























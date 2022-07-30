---SYNTAX
---CREATE DATABASE DATABASENAME;

CREATE DATABASE COMPANY_DB3;

---SYNTAX
--CREATE TABLE TABLENAME
--( 
--COLUMNNAME DATATYPE CONSTRAINT,
--COLUMNNAME5 DATATYPE CONSTRAINT,
--COLUMNNAME6 DATATYPE CONSTRAINT,
--COLUMNNAME7 DATATYPE CONSTRAINT,
----
--);
--CREATING EMPLOYEE TABLE
CREATE TABLE EMPLOYEE3
(
EMPL_ID  INT IDENTITY(1000, 1),
FNAME VARCHAR(50) NOT NULL,
LNAME VARCHAR(50) NOT NULL,
DOB DATE NOT NULL,
GENDER CHAR(1) NULL,
PHONE CHAR(10) NULL,
CITY CHAR(20) NOT NULL,
STATE CHAR(2) NOT NULL,
ZIP CHAR(5) NOT NULL
);


---PRIMARY KEY IS A UNIQUE IDENTIFIER IN A TABLE

-- SYNTAX
--ALTER TABLE TABLENAME
--ADD CONSTRAINT CONSTRAINTNAME PRIMARY KEY(COLUMNNAME);

--ADDING PK TO EMPLOYEE TABLE
ALTER TABLE EMPLOYEE3
ADD CONSTRAINT PK_EMPLOYEE3_EMPL_ID PRIMARY KEY (EMPL_ID);

--CREATING DEPARTMENT TABLE
CREATE TABLE DEPARTMENT3
(
DEPT_ID VARCHAR(5) NOT NULL,
DEPT_NAME VARCHAR(50) NOT NULL,
DEPT_STATE CHAR(2) NULL
);


---ADDING PK CONSTRAINT
ALTER TABLE DEPARTMENT3
ADD CONSTRAINT PK_DEPARTMENT3_DEPT_ID PRIMARY KEY (DEPT_ID);

--SYNTAX
--ALTER TABLE TABLENAME
--ADD COLUMNNAME DATATYPE CONSTRAINT;

---ADDING COLUMN TO EMPLOYEE3
ALTER TABLE EMPLOYEE3
ADD DEPT_ID VARCHAR(5) NOT NULL;

--FOREIGN KEY
-- A COLUMN OR FIELD IN ONE TABLE THAT REFERS TO THE PRIMARY KEY COLUMN IN 
--ANOTHER TABLE.

--SYNTAX
--ALTER TABLE CHILDTABLE
--ADD CONSTRAINT CONSTRAINTNAME FOREIGN KEY (COLUMN)
--REFERENCES PARENTTABLE(COLUMN)

 -- ADDING FK TO EMPLOYEE3 TABLE
ALTER TABLE EMPLOYEE3
ADD CONSTRAINT FK_EMPLOYEE3_DEPT_ID FOREIGN KEY(DEPT_ID)
REFERENCES DEPARTMENT3(DEPT_ID);

---RENAMING TABLE
EXEC SP_RENAME 'DEAPARTMENT', 'DEPARTMENT';

-- SYNTAX
--ALTER TABLE TABLENAME
--ALTER COLUMN COLUMNNAME DATATYPE CONSTRAINT;

--MODIFYING PHONE DATATYPE
ALTER TABLE EMPLOYEE3
ALTER COLUMN PHONE CHAR(12) NULL;

--ADDING SSN COLUMN
ALTER TABLE EMPLOYEE3
ADD SSN CHAR(9) NOT NULL;

--DROP
--SYNTAX
--ALTER TABLE TABLENAME
--DROP COLUMN COLUMNNAME;
ALTER TABLE EMPLOYEE3
DROP COLUMN SSN;

--UNIQUE CONSTRAINT ENSURES THAT ALL VALUES IN A COLUMN ARE DISTINCT.
--AND THERE CAN BE MORE THAN ONE DEFINED ON A TABLE

--ADDING UNIQUE CONSTRAINT TO SSN COLUMN
ALTER TABLE EMPLOYEE3
ADD CONSTRAINT UQ_EMPLOYEE3_SSN UNIQUE(SSN);

-- DEFAULT CONSTRAINT WILL AUTOMATICALLY ASSIGN A VALUE IF NO VALUE WAS INSTERED.
-- ADDING DEFAULT VALUE OF N FOR GENDER WHEN NO VALUE IS SPECIFIED
ALTER TABLE EMPLOYEE3
ADD CONSTRAINT DFT_EMPLOYEE3_GENDER DEFAULT ('N') FOR GENDER; 

--CHECK CONSTRAINT VERIFIES THAT ALL VALUES IN A FIELD SATISFY A GIVEN CONDITION.
-- ADDING CHECK TO VERIFY EMPLOYEE STATE
ALTER TABLE EMPLOYEE3
ADD CONSTRAINT CHK_EMPLOYEE3_STATE CHECK (STATE IN ('DC','MD','VA'));


-------7/28/2022-------
---ADDING CHECK CONSTRAINT TO VERIFY SSN LENGHT
ALTER TABLE EMPLOYEE3
ADD CONSTRAINT CHK_EMPLOYEE3_SSN CHECK (LEN(SSN) =9);

--CREATING DEPARTMENT4 TABLE
CREATE TABLE DEPARTMENT4
(
DEPT_ID VARCHAR(5) NOT NULL,
DEPT_NAME VARCHAR(50) NOT NULL,
DEPT_STATE CHAR(2) NULL
);

---DROP
--SYNTAX
--DROP TABLE TABLENAME
DROP TABLE DEPARTMENT4;


--TRUNCATE 
--SYNTAX
--TRUNCATE TABLE TABLENAME

---SYNTAX
--ALTER TABLE TABLENAME
--DROP COLUMN COLUMNNAME;

---REMOVING DEP_STATE COLUMN FROM DEPARTMENT1 TABLE
ALTER TABLE DEPARTMENT4
DROP COLUMN DEPT_STATE;


---SYNTAX
--ALTER TABLE TABLENAME
--ADD  COLUMNNAME DATATYPE CONSTRAINT;

--- ADDING A HEADCOUNT COLUMN TO DEPARTMENT4 TABLE
ALTER TABLE DEPARTMENT4
ADD HEADCOUNT INT NOT NULL;


---INDEXES ARE USED TO RETRIEVE DATA FROM DATABASES MORE QUICK, THEY HELP SPEED UP QUERIES.
----CLUSTERED 
--Whenever you apply clustered indexing in a table, it will perform sorting 
--in that table only. You can create only one clustered index in a table like primary key.
--Clustered index is as same as dictionary where the data is arranged by alphabetical order. 
--If you apply primary key to any column, then automatically it will become clustered index. 

----NONCLUSTERED
--is similar to the index of a book. The index of a book consists of a chapter name and page number, 
--if you want to read any topic or chapter then you can directly go to that page by using index of
-- that book. No need to go through each and every page of a book. 

---SYNTAX
--CREATE <CLUSTERED/ NONCLUSTERED> INDEXNAME ON TABLENAME(COLUMNNAME)
 ---CREATING INDEX ON PHONE COLUMN
 CREATE NONCLUSTERED INDEX IDX_EMPLOYEE3_PHONE ON EMPLOYEE3 (PHONE);

 ---SYNTAX
--DROP INDEX TABLENAME.INDEXNAME

--- REMOVING INDEX FROM PHONE COLUMN
DROP INDEX EMPLOYEE3.IDX_EMPLOYEE3_PHONE;


---DML COMMANDS (DATA MANIPULATION LAMGUAGE)
--INSERT POPULATE RECORDS
--UPDATE MODIFIES AN EXISTING RECORD BASED ON A GIVEN CONDITION
--DELETE REMOVES EXISTING RECORDS(BASED ON A GIVEN CONDITION)
--SELECT RETRIEVE RECORDS FROM ONE OR MORE TABLES.

--INSERT
--SYNTAX
--INSERT INTO TABLENAME (COLUMN1, COLUMN2, COLUMN3,...)
--VALUES 
--('VALUE1', 'VALUE2', 'VALUE3'),
--('VALUE1', 'VALUE2', 'VALUE3'),
--('VALUE1', 'VALUE2', 'VALUE3'),
--('VALUE1', 'VALUE2', 'VALUE3');

--POPULATING DEPARTMENT4 TABLE
INSERT INTO DEPARTMENT3 (DEPT_ID, DEPT_NAME, DEPT_STATE)
VALUES
(00001, 'IT', 'CA'),
(00002, 'CLAIMS', 'OH'),
(00003, 'UNDERWRITTING', 'DE'),
(00004, 'CUSTOMER', 'MD'),
(00005, 'SALES', NULL);

SELECT * FROM DEPARTMENT3;

INSERT INTO DEPARTMENT3 (DEPT_ID, DEPT_NAME)
VALUES
(00011, 'CALL CENTER');


---POPULATING EMPLOYEE TABLE
INSERT INTO EMPLOYEE3 (FNAME, LNAME,DOB, GENDER, PHONE, CITY, STATE, ZIP,DEPT_ID,SSN)
VALUES
('JOHN', 'SMITH', '05-10-1990', 'M', '443-123-9876', 'BALTIMORE', 'MD', '21117',00001, '123456789'),
('DAVE', 'JONES', '03-10-1800', 'M', '443-478-9876', 'COLUMBIA', 'MD', '21617',00005, '123457489'),
('EBONY', 'ALEZ', '05-10-1997', 'F', '813-123-9876', 'RESTON', 'VA', '20117',00003, '123456009'),
('DESTINY', 'OSEI', '01-10-2000', 'F', '440-123-9876', 'WASHINGTON', 'DC', '61117',00001, '003456789'),
('MICHAEL', 'DOE', '05-10-1990', 'M', '443-123-9006', 'BALTIMORE', 'MD', '21117',00002, '124866789');

SELECT * FROM  EMPLOYEE3;

INSERT INTO EMPLOYEE3 (FNAME, LNAME,DOB, GENDER, PHONE, CITY, STATE, ZIP,DEPT_ID,SSN)
VALUES
('JOHN', 'SAGE', '05-10-1990', 'M', '443-123-9876', 'HOUSTON', 'DC', '21117',00011, '734067999');

---UPDATE 
---SYNTAX
--UPDATE TABLENAME
--SET COLUMNNAME = 'NEWVALUE'
--WHERE CONDITION

---UPDATING EMPLOYEE3 PHONE NUMBER
UPDATE EMPLOYEE3
SET PHONE = '313-861-0056'
WHERE EMPL_ID =1002;

--UPDATING EMPLOYEE3 LASTNAME
UPDATE EMPLOYEE3
SET LNAME = 'BAH'
WHERE EMPL_ID = 1003;

------05/16/2022---
ALTER TABLE EMPLOYEE3
ADD DEPARTMENT VARCHAR(20);

SELECT * FROM EMPLOYEE3
SELECT * FROM DEPARTMENT3

-- UPDATING EMPLOYEE TABLE TO DYNAMICALLY POLULATE DEPARTMENT COLUMN
UPDATE EMPLOYEE3
SET DEPARTMENT = DEPARTMENT3.DEPT_NAME
FROM EMPLOYEE3,DEPARTMENT3
WHERE EMPLOYEE3.EMPL_ID = DEPARTMENT3.DEPT_ID;

---DELETE
---SYNTAX 
--DELETE 
--FROM TABLE NAME
--WHERE CONDITION (---IF THERE IS NO CONDITION THEN EVERY RECORD WILL BE DELETED)

---- REMOVING EMPLOYEE JOHN SAGE RECORD
DELETE
FROM EMPLOYEE3
WHERE EMPL_ID = 1012;
 

 SELECT * FROM EMPLOYEE3;

 DELETE
 FROM EMPLOYEE3;

---REMOVING ALL RECORDS FROM DEPARTMENT TABLE

SELECT * FROM DEPARTMENT3

TRUNCATE TABLE DEPARTMENT3;

---REMOVING FK CONSTRAINT 
ALTER TABLE EMPLOYEE3
DROP [FK_EMPLOYEE3_DEPT_ID];

---REMOVING EMPLOYEE TABLE FROM COMPANYDB3
DROP TABLE EMPLOYEE3;





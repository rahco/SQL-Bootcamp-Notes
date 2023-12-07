
/* CREATING DATABASES AND TABLES */


/* CREATE */
/* 
Create is used to create new tables. The full general syntax is:
CREATE TABLE table_name (
  column_name TYPE column_constraint,
  column_name TYPE column_constraint,
   table_constraint table_constraint
) INHERITS existing_table_name;
*/

/* Creating the account table */
CREATE TABLE account (
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

/* Creating the job table */
CREATE TABLE job (
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

/* Creating the account_job table */
CREATE TABLE account_job (
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
);


/* INSERT */
/*
INSERT allows you to add in rows to a table.
General Syntax:
INSERT INTO table (column1, column2, …)
VALUES
   (value1, value2, …),
   (value1, value2, …) ,...;
*/

/* Inserting values into the account table */
INSERT INTO account(username, password, email, created_on)
VALUES
('Jose', 'password', 'jose@mail.com', CURRENT_TIMESTAMP);

/* Inserting values into the job table */
INSERT INTO job(job_name)
VALUES
('President');

/* Inserting values into the account_job table */
INSERT INTO account_job(user_id, job_id, hire_date)
VALUES
(1, 1, CURRENT_TIMESTAMP);


/* UPDATE  */
/*
The UPDATE keyword allows for the changing of values of the columns in a table.

General syntax:
UPDATE table
SET column1 = value1,
    column2 = value2 ,...
WHERE
   condition;

Example:
UPDATE account
SET last_login = CURRENT_TIMESTAMP
    WHERE last_login IS NULL;
*/

/* Reset everything without WHERE condition */
UPDATE account
SET last_login = CURRENT_TIMESTAMP;

/* Set based on another column */
UPDATE account
SET last_login = created_on;

/* Using another table’s values (UPDATE join) */
UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id;

/* Using RETURNING to return affected rows */
UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on, last_login;


/* DELETE */

/* 
01 -> We can use the DELETE clause to remove rows from a table.
For example:
DELETE FROM table
WHERE row_id = 1

02 -> We can delete rows based on their presence in other tables
For example:
DELETE FROM tableA
USING tableB
WHERE tableA.id=TableB.id

03 -> We can delete all rows from a table
For example:
DELETE FROM table
*/

INSERT INTO job(job_name)
VALUES
('Cowboy'),
('Traine');

/* Deleting the Cowboy value from the job table */
DELETE FROM job
WHERE job_name = 'Cowboy'
RETURNING job_id, job_name;


/* ALTER Table */

/*
The ALTER clause allows for changes to an existing table structure, such as:
> Adding,dropping,or renaming columns
> Changing a column’s data type
> Set DEFAULT values for a column
> Add CHECK constraints
> Rename table

General syntax:
ALTER TABLE table_name action

> Adding columns:
ALTER TABLE table_name 
ADD COLUMN new_col TYPE

> Removing columns:
ALTER TABLE table_name 
DROP COLUMN col_name

> Alter constraints:
ALTER TABLE table_name 
ALTER COLUMN col_name
SET DEFAULT value
> OR <:
ALTER TABLE table_name 
ALTER COLUMN col_name
DROP DEFAULT
> OR <:
ALTER TABLE table_name 
ALTER COLUMN col_name
ADD CONSTRAINT constraint_name

*/

CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
);

/* Renaming table */
ALTER TABLE information
RENAME TO new_info;

/* Renaming column */
ALTER TABLE new_info
RENAME COLUMN person TO people;

/* Droping the constraint from a column */
ALTER TABLE new_info
ALTER COLUMN people 
DROP NOT NULL;


/* DROP Table */

/*

DROP allows for the complete removal of a column in a table.

General syntax:
ALTER TABLE table_name
DROP COLUMN col_name

Remove all dependencies:
ALTER TABLE table_name
DROP COLUMN col_name CASCADE

Check for existence to avoid error:
ALTER TABLE table_name
DROP COLUMN IF EXISTS col_name 

Drop multiple columns:
ALTER TABLE table_name
DROP COLUMN  col_one,
DROP COLUMN  col_two 

*/

/* Droping a column */
ALTER TABLE new_info
DROP COLUMN people;

/* Droping a column with check */
ALTER TABLE new_info
DROP COLUMN IF EXISTS people;


/* CHECK Constraint */

/*

The CHECK constraint allows us to create more customized constraints 
that adhere to a certain condition.

General syntax:
CREATE TABLE example(
ex_id SERIAL PRIMARY KEY,
age SMALLINT CHECK (age > 21),
parent_age SMALLINT CHECK ( parent_age > age)
);

*/

/* Creating the employees table with combined CHECK constraints */
CREATE TABLE employees (
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK (birthdate > '1900-01-01'),
	hire_date DATE CHECK (hire_date > birthdate),
	salary INTEGER CHECK (salary > 0)
);

/* Validating the created constraints */
INSERT INTO employees (first_name, last_name, birthdate, hire_date, salary)
VALUES
('Sammy', 'Smith', '1900-11-03', '2010-01-01', 100);


/*  */
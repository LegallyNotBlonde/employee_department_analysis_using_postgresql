-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Note: the scheme was updated after the draft was automatically 
-- created using QuickDBD tool (in some cases primary keys are also foreign keys)

-- Create 'employees' table first as it is referenced by other tables
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id CHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

-- Adjust the 'departments' table to make 'dept_no' the primary key
CREATE TABLE departments (
    dept_no CHAR(10) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no)
);

-- Create 'titles' table
CREATE TABLE titles (
    title_id CHAR(10) NOT NULL,
    title VARCHAR(30) NOT NULL,
    PRIMARY KEY (title_id)
);

-- Create 'dept_emp' table with compound primary key
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create 'dept_manager' table with compound primary key
CREATE TABLE dept_manager (
    dept_no CHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create 'salaries' table
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);



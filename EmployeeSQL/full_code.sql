-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Note: the schema was updated after the draft was automatically 
-- created using QuickDBD tool (in some cases primary keys are also foreign keys)

--TRUNCATE TABLE dept_manager, dept_emp, salaries, titles, departments, employees RESTART IDENTITY CASCADE;
--SELECT * FROM departmetns
--LIMIT 5;
-- ===============================
-- CREATE TABLES
-- ===============================
-- 1. Create 'employees' table first as it is referenced by other tables
CREATE TABLE IF NOT EXISTS employees (
    emp_no INT NOT NULL,
	emp_title_id CHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    emp_status VARCHAR(11) NOT NULL,       -- 'Active' or 'Terminated'
    departure_date DATE, 					-- NULL if still employed
	region VARCHAR(15) NOT NULL,
    PRIMARY KEY (emp_no)
);

-- 2. Create 'departments' table  with 'dept_no' as the primary key
CREATE TABLE IF NOT EXISTS departments (
    dept_no CHAR(10) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no)
);

-- 3. Create 'titles' table
CREATE TABLE IF NOT EXISTS titles (
    title_id CHAR(10) NOT NULL,
    title VARCHAR(30) NOT NULL,
    PRIMARY KEY (title_id)
);

-- 4. Create 'dept_emp' table with compound primary key
CREATE TABLE IF NOT EXISTS dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- 5. Create 'dept_manager' table with compound primary key
CREATE TABLE IF NOT EXISTS dept_manager (
    dept_no CHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- 6. Create 'salaries' table
CREATE TABLE IF NOT EXISTS salaries (
    emp_no iNT NOT NULL,
    salary NUMERIC (10,2) NOT NULL,
	benefits NUMERIC (10,2),		-- Optional benefits  
	overhead_cost NUMERIC (10,2),  -- Estimated overhead 
	total_cost NUMERIC (10,2) NOT NULL,    -- = salary + benefits + overhead     
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


-- =================================
-- CREATE FULL EMPLOYEE DATA VIEW  
-- clean view for analysis without birth date; preserves original tables 
-- =================================
CREATE VIEW employee_data AS
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.sex,
    e.hire_date,
    e.departure_date,
    e.emp_status,
    e.region,
    e.emp_title_id,
    t.title,
    d.dept_name,
    s.salary,
    s.benefits,
    s.overhead_cost,
    s.total_cost,
    dm.emp_no AS manager_emp_no
FROM employees e
LEFT JOIN salaries s ON e.emp_no = s.emp_no
LEFT JOIN titles t ON e.emp_title_id = t.title_id
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
ORDER BY e.emp_no;

SELECT * FROM employee_data
LIMIT 4;
-- ==================================
-- ANALYSIS QUERIES
-- ==================================

-- COMPANY SNAPSHOT: total active employees, total and average salary by today 
SELECT 
    COUNT(*) AS total_active_employees,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 0) AS average_salary
FROM employee_data
WHERE emp_status = 'Active';

-- BY DEPARTMENT: headcount, avg salary, number of managers  
SELECT 
    dept_name,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 0) AS avg_salary,
    COUNT(manager_emp_no) AS num_managers
FROM employee_data
WHERE emp_status = 'Active'
GROUP BY dept_name
ORDER BY employee_count DESC;

-- BY REGION: headcount, avg salary, managers  
SELECT 
    region,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary,
    COUNT(manager_emp_no) AS num_managers
FROM employee_data
WHERE emp_status = 'Active'
GROUP BY region
ORDER BY employee_count DESC;

-- EMPLOYEES OVER TIME: hiring trend by year  
SELECT 
    EXTRACT(YEAR FROM hire_date) AS hire_year,
    COUNT(*) AS employees_hired
FROM employee_data
GROUP BY hire_year
ORDER BY hire_year;

-- TERMINATION TREND: number of employees who left per year  
SELECT 
    EXTRACT(YEAR FROM departure_date) AS termination_year,
    COUNT(*) AS employees_left
FROM employee_data
WHERE departure_date IS NOT NULL
GROUP BY termination_year
ORDER BY termination_year;

-- TERMINATION TREND: number of employees who left per department
SELECT 
    dept_name AS department,
    COUNT(emp_status) AS employees_left
FROM employee_data
WHERE emp_status = 'Terminated'
GROUP BY dept_name
ORDER BY employees_left DESC;

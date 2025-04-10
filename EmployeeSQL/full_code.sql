-- =================================
-- EMPLOYEE DATA MODEL AND ANALYSIS
-- Purpose: Enable workforce reporting and cost tracking
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- =================================

-- Drop existing tables and views if needed (for rebuild scenarios)
-- TRUNCATE TABLE dept_manager, dept_emp, salaries, titles, departments, employees RESTART IDENTITY CASCADE;
-- SELECT * FROM departments
-- LIMIT 5;

DROP VIEW IF EXISTS employee_data;
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

-- 4.'dept_emp' table with compound primary key - employees by department (many-to-many)
CREATE TABLE IF NOT EXISTS dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- 5. 'dept_manager' table with compound primary key - department managers (subset of employees)
CREATE TABLE IF NOT EXISTS dept_manager (
    dept_no CHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- 6.'salaries' table - salary costs; supports historical tracking 
CREATE TABLE IF NOT EXISTS salaries (
    emp_no iNT NOT NULL PRIMARY KEY,
    salary NUMERIC (10,2) NOT NULL,
	benefits NUMERIC (10,2),		-- Optional benefits  
	overhead_cost NUMERIC (10,2),  -- Estimated overhead 
	total_cost NUMERIC (10,2) NOT NULL,    -- = salary + benefits + overhead     
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries
LIMIT 3;

-- Alter 'salaries' table for cleaner view
ALTER TABLE salaries
ALTER COLUMN salary TYPE NUMERIC(10,0),
ALTER COLUMN benefits TYPE NUMERIC(10,0),		
ALTER COLUMN overhead_cost TYPE NUMERIC(10,0), 
ALTER COLUMN total_cost TYPE NUMERIC(10,0);

-- =================================
-- CREATE/REPLACE FULL EMPLOYEE DATA VIEW  
-- clean view for analysis without birth date; preserves original tables 
-- =================================
CREATE OR REPLACE VIEW employee_data AS
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
    CASE WHEN dm.emp_no IS NOT NULL THEN 1 ELSE 0 END AS is_manager_flag
FROM employees e
LEFT JOIN salaries s ON e.emp_no = s.emp_no 
LEFT JOIN titles t ON e.emp_title_id = t.title_id
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
ORDER BY e.emp_no;

SELECT * FROM employee_data
WHERE is_manager_flag = 0    -- displays 4 rows emaployee_data for non-managers employee only
LIMIT 4;

-- ==================================
-- ANALYSIS QUERIES
-- ==================================

-- COMPANY SNAPSHOT: total active employees, total and average salary, employement duration by today 
SELECT 
    COUNT(*) AS total_active_employees,
	SUM(CASE WHEN is_manager_flag = 1 THEN 1 ELSE 0 END) AS total_num_managers,
	SUM(CASE WHEN is_manager_flag = 0 THEN 1 ELSE 0 END) AS total_num_employees,
    SUM(salary) AS total_salary_year,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary, -- shows median salary
	ROUND(AVG((now()::date - hire_date)::int) / 365.0, 2) AS avg_employment_duration_years
FROM employee_data
WHERE emp_status = 'Active';

-- BY DEPARTMENT: headcount, avg salary, number of managers, employement duration by today  
SELECT 
    dept_name,
    SUM(CASE WHEN is_manager_flag = 0 THEN 1 ELSE 0 END) dep_employee_count,
	SUM(CASE WHEN is_manager_flag = 1 THEN 1 ELSE 0 END) AS dep_num_managers,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_dep_salary,
	ROUND(AVG((now()::date - hire_date)::int) / 365.0, 2) AS avg_dep_employment_duration_years
FROM employee_data
WHERE emp_status = 'Active'
GROUP BY dept_name
ORDER BY dep_employee_count DESC;

-- BY REGION: headcount, avg salary, managers  
SELECT 
    region,
    SUM(CASE WHEN is_manager_flag = 0 THEN 1 ELSE 0 END) AS reg_employee_count,
	SUM(CASE WHEN is_manager_flag = 1 THEN 1 ELSE 0 END) AS reg_num_managers,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_reg_salary,
	ROUND(AVG((now()::date - hire_date)::int) / 365.0, 2) AS avg_reg_employment_duration_years 
FROM employee_data
WHERE emp_status = 'Active'
GROUP BY region
ORDER BY reg_employee_count DESC;

-- SALARY TRENDS TO IDENTIFY POTENTIAL 
SELECT dept_name AS department,
	title,
	COUNT(title) AS employee_number,
	MIN(salary) AS role_min_salary,
	MAX(salary) AS role_max_salary,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_role_salary
FROM employee_data
WHERE emp_status = 'Active'
GROUP BY dept_name, title
ORDER BY dept_name, title, role_min_salary;

-- EMPLOYEES OVER TIME: hiring and departure trends by year  
SELECT 
    EXTRACT(YEAR FROM hire_date) AS year,
	'Hired' AS event_type,
    COUNT(*) AS employee_count
FROM employee_data
GROUP BY year
	
UNION ALL
	
SELECT 
    EXTRACT(YEAR FROM departure_date) AS year,
	'Left' as event_type,
    COUNT(*) AS employee_count
FROM employee_data
WHERE departure_date IS NOT NULL
GROUP BY year
ORDER BY year, event_type

-- TERMINATION TREND: number of employees who left per department
SELECT 
    dept_name AS department,
	COUNT (emp_no) AS total_department_size,
    SUM(CASE WHEN emp_status = 'Terminated' THEN 1 ELSE 0 END) AS employees_left_total,
	ROUND(
	SUM(CASE WHEN emp_status = 'Terminated' THEN 1 ELSE 0 END):: numeric
	/COUNT (emp_no)*100, 0
		) AS percentage_left
FROM employee_data
GROUP BY dept_name
ORDER BY employees_left_total DESC;

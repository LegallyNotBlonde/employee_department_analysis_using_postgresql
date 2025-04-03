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

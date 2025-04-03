# 🧠 Project Overview (Using SQL)

* In this project, I designed and analyzed a PostgreSQL relational database to explore employee and department data, identify workforce trends, and support future headcount planning.

* I used QuickDBD to design the schema and created SQL queries that uncover actionable insights and calculate KPIs to support both operational and strategic workforce decisions.

![ERM Diagram](https://github.com/LegallyNotBlonde/employee_department_analysis_using_postgresql/blob/main/EmployeeSQL/ERM_diagram.png)

---

## 📁 Project Structure

* **"EmployeeSQL" Folder**: ERM diagram, schema scripts, SQL query files.
* **"data files" Folder**: Includes resource files and structured mock data.
---

## 🛠 Key SQL Concepts and Techniques
| **Concept**         | **Description**                                                                |
|---------------------|--------------------------------------------------------------------------------|
| `SELECT`            | Extracts specific data from one or more tables                                 |
| `JOIN`              | Combines data across related tables                                             |
| `WHERE`             | Filters records based on defined conditions                                     |
| `GROUP BY`          | Aggregates data into meaningful groups                                          |
| `ORDER BY`          | Sorts data by one or more columns                                               |
| `CREATE VIEW`       | Allows safe analysis without modifying the original source tables              |


## 🔍 General Workforce Trend Analysis (Current State)
Using SQL, I analyzed workforce structure across all available years to explore hiring patterns, role distribution, and department dynamics. These findings help businesses:

* Identify headcount trends  
* Evaluate organizational structure  
* Understand how roles and salaries are distributed  
* Compare departments by workforce size, cost, and manager coverage

### 📌 Sample Insights

| **Observation**                                          | **What It Tells Us**                                                                 |
|----------------------------------------------------------|--------------------------------------------------------------------------------------|
| The largest department has the lowest number of managers | Suggests possible leadership or oversight imbalance                                 |
| Salary varies within the same job title                  | Highlights potential pay inconsistencies or misalignment in leveling                |
| Some departments have no managers assigned               | Indicates possible data issues or management gaps                                   |
| Regional headcount distribution is uneven                | Helps inform HR allocation and support planning                                     |

---

### 📊 KPIs for Workforce Structure

| **KPI**                        | **What It Measures**                                      | **Why It Matters**                                                               |
|-------------------------------|-----------------------------------------------------------|----------------------------------------------------------------------------------|
| Headcount by Department       | Total employees per department                            | Highlights team sizes and resource allocation                                   |
| Manager-to-Employee Ratio     | Number of managers relative to staff                      | Identifies departments potentially under- or over-managed                       |
| Average Salary by Role/Dept   | Mean salary grouped by role or department                 | Useful for benchmarking pay equity and consistency                              |
| Department Size by Region     | Employee count by location and department                 | Helps assess geographic staffing balance                                        |
| Gender Distribution           | Employees by gender across roles and departments          | Supports diversity and equity reporting                                         |

---

## 📈 Forecasting Workforce Needs (3-Year Focus)

To support headcount forecasting, I narrowed the analysis to the last **three years**, reflecting more recent trends shaped by post-pandemic market changes.

These recent trends provide a more realistic basis for hiring projections, attrition planning, and financial estimates.

---

### 📅 Forecast-Oriented KPIs

| **KPI / Concept**             | **What It Measures**                                      | **Why It Matters**                                                               |
|-------------------------------|-----------------------------------------------------------|----------------------------------------------------------------------------------|
| Hiring Rate by Department     | Avg. new hires per department per year                    | Shows which teams are expanding and how fast                                     |
| Attrition Rate by Department  | % of employees who left over average headcount            | Helps identify retention issues                                                  |
| Quarterly Forecasting         | Seasonal trends over time                                 | Improves accuracy by addressing seasonality in hiring and exits                  |
| Scenario Planning             | Forecast under multiple future conditions                 | Helps the company prepare for change and uncertainty                             |
| Variance Analysis             | Forecast vs actual outcome comparison                     | Improves future projections by adjusting assumptions                             |
| 3-Year Focus                  | Limits input to recent data only                          | Ensures relevance by focusing on post-pandemic trends                            |

---

### 📊 Advanced Workforce KPIs

| **Metric / KPI**           | **What It Measures**                                         | **Why It Matters**                                                              |
|----------------------------|--------------------------------------------------------------|----------------------------------------------------------------------------------|
| Time-to-Hire               | Avg. number of days to fill open roles                       | Measures recruiting speed and identifies process inefficiencies                  |
| Internal Mobility Rate     | % of employees who moved into new roles internally           | Shows how well the company develops and retains internal talent                  |
| Absenteeism Rate           | Unplanned absences over total scheduled work days            | Tracks engagement and helps reduce productivity loss                             |

---

### 💸 Financial Metrics for Headcount Planning

| **Metric**                    | **What It Measures**                                           | **Why It Matters**                                                              |
|-------------------------------|----------------------------------------------------------------|----------------------------------------------------------------------------------|
| Fully Burdened Labor Rate     | Salary + benefits + overhead per employee                      | Provides true cost per employee, supports payroll budgeting                     |
| Labor Cost as % of Revenue    | Total employee cost divided by company revenue                 | Helps assess workforce cost efficiency                                          |

---

## 📊 Visualization and Reporting

- **Interactive Dashboards** for workforce size, salary distribution, and KPIs  
- **Scenario Simulations** to explore staffing plans under different business assumptions  
- **Real-Time Updates** using SQL views to power dynamic analysis without modifying core data

---

## ✅ Data Quality and Compliance

- **Built-in Data Validation** to catch nulls, duplicates, and date inconsistencies  
- **Compliance Awareness** to align with HR data standards and support DEI monitoring

---

## 🧬 Source

The original dataset was created using  [Mockaroo](https://mockaroo.com/), (2022), a realistic data generation tool. To enable deeper analysis, I extended the dataset using structured randomization techniques in Excel. These included adding realistic ranges for dates, salaries, benefits, regions, and employment status.

<p> Although synthetic, the data was shaped to reflect patterns seen in real-world HR systems, enabling meaningful and practical workforce analysis.

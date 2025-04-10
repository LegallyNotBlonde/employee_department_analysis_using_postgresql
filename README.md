# Project Overview (Using SQL)

This project focuses on analyzing workforce data within a relational PostgreSQL database to uncover trends, support organizational planning, and guide decision-making on headcount, structure, and costs.

The database design was created using QuickDBD and includes six related tables. SQL queries were developed to examine historical patterns, calculate key performance indicators, and enable forecasting aligned with evolving business needs.

![ERM Diagram](https://github.com/LegallyNotBlonde/employee_department_analysis_using_postgresql/blob/main/EmployeeSQL/ERM_diagram.png)

---

## Project Structure

* **"EmployeeSQL" Folder**: Schema diagrams, SQL scripts, and analysis queries
* **"data files" Folder**: Mock datasets tailored to simulate realistic HR scenarios
---

## Core SQL Techniques
| **Concept**         | **Description**                                                                |
|---------------------|--------------------------------------------------------------------------------|
| `SELECT`            | Retrieves relevant data from one or more tables                               |
| `JOIN`              | Combines related data across multiple tables                                   |
| `WHERE`             | Filters data based on specific conditions                                      |
| `GROUP BY`          | Summarizes data by categories                                                  |
| `ORDER BY`          | Sorts results by one or more columns for easier interpretation                 |
| `CREATE VIEW`       | Allows safe analysis without modifying the original source tables              |


## Current Workforce Analysis
The analysis spans several years of employee records to assess hiring activity, departmental makeup, and role distributions. 
<p> Key takeaways include:

* **Headcount Trends:** Changes in team size over time
* **Role Distribution:** How positions and salaries vary by department
* **Manager Coverage:** Presence and ratio of leadership within teams
* **Geographic Variation:** Regional differences in staffing levels

### Examples of Insights

| **Observation**                                          | **Interpretation**                                                           |
|----------------------------------------------------------|------------------------------------------------------------------------------|
| Largest department has the fewest managers               | May indicate leadership coverage gaps                                        |
| Salary varies within identical roles                     | Points to potential inconsistencies in compensation                          |
| Some departments lack assigned managers                  | Could reflect data integrity issues or org gaps                              |
| Uneven regional distribution                             | Suggests areas for improved staffing alignment                               |

---

### Workforce KPIs

| **KPI**                        | **Purpose**                                   | 
|--------------------------------|-----------------------------------------------|
| Headcount by Department        | Understands team size and resource allocation |
| Manager-to-Employee Ratio      | Evaluates span of control across departments  |
| Average Salary by Role         | Identifies pay patterns and benchmarks        |
| Department Size by Region      | Supports regional workforce planning          |
| Gender Distribution            | Helps assess diversity and equity             |
---

## Forecasting for the Next Three Years

The analysis narrows focus to the most recent three years—capturing trends **shaped by post-pandemic shifts in the labor market**.

This approach improves the accuracy of projections for hiring, attrition, and associated financial planning..

---

### Forecast KPIs

| **KPI**                        | **Purpose**                                     | 
|--------------------------------|-------------------------------------------------|
| Hiring Rate                    | Identifies growth areas by team                 |
| Attrition Rate                 | Highlights retention challenges                 |
| Quarterly Patterns             | Captures seasonality in workforce movement      |
| Scenario Planning              | Models future headcount under varying condition |
| Forecast Variance              | Compares projections to actuals to refine assumptions |

---

### Advanced Workforce Metrics
While the current analysis focuses on core metrics, there are several advanced KPIs that organizations often track to gain deeper insights. These were not included in this project due to data availability constraints, but are important to note for a more comprehensive workforce strategy:

| **Metric**           | **Purpose**                                               |
|----------------------|-----------------------------------------------------------|
| Time-to-Hire         | Measures efficiency of recruitment processes              |
| Internal Mobility    | Reflects talent development and retention                 |
| Absenteeism Rate     | Monitors unplanned leave and potential productivity loss  |

---

### Financial Planning Metrics

| **Metric**                    | **Purpose         **                                           |
|-------------------------------|----------------------------------------------------------------|
| Fully Burdened Labor Rate     | Captures total employee cost: salary + benefits + overhead per employee   | 
| Labor Cost as % of Revenue    | Assesses workforce efficiency relative to company size                    | 

---

## Data Visualization and Reporting
SQL views were used to generate dynamic outputs that power real-time dashboards, enabling:

* Workforce composition monitoring
* Salary distribution analysis
* Scenario-based forecasting
These visual tools support both day-to-day operations and long-term strategic discussions.

---

## Data Integrity and Source

Data was generated using  [Mockaroo](https://mockaroo.com/), (2022) and extended using structured transformations in Excel. Realistic ranges were applied for salaries, dates, and benefits to better reflect actual HR data trends.

<p> Although synthetic, the dataset was purpose-built to enable meaningful analysis aligned with common business scenarios.

## Summary
This project demonstrates how structured SQL queries and relational data modeling can uncover insights about workforce composition, guide headcount forecasting, and inform organizational planning. By focusing on both historical patterns and forward-looking metrics, it supports a more data-driven approach to managing human capital.

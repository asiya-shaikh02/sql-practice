-- =====================================================
-- SQL Practice | Asiya Shaikh
-- Database : sql_journey (MySQL 8.0)
-- Tables   : employees, departments
-- Topics   : filtering, aggregation, HAVING, CASE, JOINs,
--            data quality checks, window functions
-- =====================================================


-- -----------------------------------------------------
-- 1. FILTERING: IT employees earning 70,000 or more
-- -----------------------------------------------------
SELECT first_name, department, salary
FROM employees
WHERE department = 'IT'
  AND salary >= 70000;


-- -----------------------------------------------------
-- 2. AGGREGATION: employee count per department
-- -----------------------------------------------------
SELECT department, COUNT(employee_id) AS employee_count
FROM employees
GROUP BY department;


-- -----------------------------------------------------
-- 3. HAVING: only departments with more than 3 employees
-- -----------------------------------------------------
SELECT department, COUNT(employee_id) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(employee_id) > 3;


-- -----------------------------------------------------
-- 4. CASE: classify salaries as High / Medium / Low
-- -----------------------------------------------------
SELECT first_name,
       salary,
       CASE
           WHEN salary >= 80000 THEN 'High'
           WHEN salary >= 60000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_status
FROM employees;


-- -----------------------------------------------------
-- 5. INNER JOIN: employee name with department name
-- -----------------------------------------------------
SELECT e.first_name, d.department_name, e.salary
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id;


-- -----------------------------------------------------
-- 6. DATA QUALITY CHECK: orphan records
--    Employees whose department_id has no match in departments
-- -----------------------------------------------------
SELECT e.first_name, d.department_id
FROM employees e
LEFT JOIN departments d
  ON d.department_id = e.department_id
WHERE d.department_id IS NULL;


-- =====================================================
-- MORE DATA QUALITY CHECKS
-- (written to match the tables above; run and confirm
--  each one on your own database before publishing)
-- =====================================================

-- 7. Duplicate employee IDs
SELECT employee_id, COUNT(*) AS occurrences
FROM employees
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- 8. NULL count per important column
SELECT COUNT(*)                          AS total_rows,
       SUM(first_name IS NULL)           AS null_first_name,
       SUM(salary IS NULL)               AS null_salary,
       SUM(department_id IS NULL)        AS null_department_id
FROM employees;


-- =====================================================
-- WINDOW FUNCTIONS
-- Replace or extend with your own LAG / LEAD and
-- percentage queries from your practice files.
-- =====================================================

-- 9. Rank salaries within each department
SELECT first_name,
       department,
       salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM employees;

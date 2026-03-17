-- =============================================
-- SQL ASSIGNMENT – All 50 Questions
-- Student: Janu
-- =============================================

-- ── DATABASE & TABLE MANAGEMENT ──────────────

-- Q1. Create database
CREATE DATABASE company_db;

-- Q2. Select database
USE company_db;

-- Q3. Create skills table
CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(100)
);

-- Q4. Show all databases
SHOW DATABASES;

-- Q5. Show all tables
SHOW TABLES;

-- Q6. Rename table
RENAME TABLE employee TO staff;

-- ── DATA INSERTION ────────────────────────────

-- Q7. Insert Alice Green
INSERT INTO employee (first_name, last_name, email, hire_date, salary, dept_id, gender)
VALUES ('Alice', 'Green', 'alice.green@company.com', '2024-01-10', 62000.00, 4, 'Female');

-- Q8. Insert multiple projects
INSERT INTO project (project_name, budget, dept_id)
VALUES 
    ('Mobile App', 60000.00, 2),
    ('Training Program', 25000.00, 1);

-- Q9. Add Sales department
INSERT INTO department (dept_name, location)
VALUES ('Sales', 'Boston');

-- Q10. Insert Tom with only name and email
INSERT INTO employee (first_name, email)
VALUES ('Tom', 'tom@company.com');

-- ── DATA RETRIEVAL ────────────────────────────

-- Q11. All records from employee
SELECT * FROM employee;

-- Q12. Select with aliases
SELECT 
    emp_id AS "Employee ID",
    first_name AS "Name",
    email AS "Email Address"
FROM employee;

-- Q13. Employees hired after Jan 1 2023
SELECT * FROM employee
WHERE hire_date > '2023-01-01';

-- Q14. Projects budget > 40000 ordered descending
SELECT * FROM project
WHERE budget > 40000.00
ORDER BY budget DESC;

-- Q15. Distinct locations
SELECT DISTINCT location FROM department;

-- ── DATA MODIFICATION ────────────────────────

-- Q16. Add phone_number column
ALTER TABLE employee
ADD COLUMN phone_number VARCHAR(15) AFTER email;

-- Q17. Update John Doe salary
UPDATE employee
SET salary = 65000.00
WHERE first_name = 'John' AND last_name = 'Doe';

-- Q18. Set gender of IT dept employees
UPDATE employee
SET gender = 'Other'
WHERE dept_id = 2;

-- Q19. Drop phone_number column
ALTER TABLE employee
DROP COLUMN phone_number;

-- ── FILTERING & CONDITIONS ───────────────────

-- Q20. Salary between 60000 and 80000
SELECT * FROM employee
WHERE salary BETWEEN 60000 AND 80000;

-- Q21. First name starts with J
SELECT * FROM employee
WHERE first_name LIKE 'J%';

-- Q22. Projects in dept 1 or 2
SELECT * FROM project
WHERE dept_id IN (1, 2);

-- Q23. Email is not NULL
SELECT * FROM employee
WHERE email IS NOT NULL;

-- Q24. Departments not in New York or Chicago
SELECT * FROM department
WHERE location NOT IN ('New York', 'Chicago');

-- Q25. Employees hired in 2023
SELECT * FROM employee
WHERE YEAR(hire_date) = 2023;

-- ── AGGREGATE FUNCTIONS ──────────────────────

-- Q26. Total salary
SELECT SUM(salary) AS total_salary FROM employee;

-- Q27. Average budget
SELECT AVG(budget) AS avg_budget FROM project;

-- Q28. Highest salary
SELECT MAX(salary) AS highest_salary FROM employee;

-- Q29. Count IT dept employees
SELECT COUNT(*) AS it_employee_count
FROM employee
WHERE dept_id = 2;

-- Q30. Minimum budget
SELECT MIN(budget) AS min_budget FROM project;

-- ── JOINS ─────────────────────────────────────

-- Q31. Employees with department names
SELECT e.emp_id, e.first_name, e.last_name, d.dept_name
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id;

-- Q32. Departments with employee count
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM department d
LEFT JOIN employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Q33. Projects with department names
SELECT p.project_name, p.budget, d.dept_name
FROM project p
INNER JOIN department d ON p.dept_id = d.dept_id;

-- Q34. Employees in San Francisco
SELECT e.first_name, e.last_name, d.location
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id
WHERE d.location = 'San Francisco';

-- Q35. Departments with no projects
SELECT d.dept_name
FROM department d
LEFT JOIN project p ON d.dept_id = p.dept_id
WHERE p.dept_id IS NULL;

-- ── STRING & NUMERIC FUNCTIONS ───────────────

-- Q36. Full name concatenation
SELECT CONCAT(first_name, ' ', last_name) AS "Full Name"
FROM employee;

-- Q37. Department name uppercase
SELECT UPPER(dept_name) AS dept_name FROM department;

-- Q38. First 3 characters of email
SELECT first_name, LEFT(email, 3) AS email_prefix
FROM employee;

-- Q39. Absolute value
SELECT ABS(-50000) AS absolute_value;

-- Q40. Round average salary
SELECT ROUND(AVG(salary), 2) AS avg_salary FROM employee;

-- ── ADVANCED QUERIES ─────────────────────────

-- Q41. First 3 employees by hire date desc
SELECT * FROM employee
ORDER BY hire_date DESC
LIMIT 3;

-- Q42. Second page (records 4-6)
SELECT * FROM employee
ORDER BY emp_id
LIMIT 3 OFFSET 3;

-- Q43. Classify salary using IF
SELECT first_name, salary,
    IF(salary >= 70000, 'High', 'Low') AS salary_category
FROM employee;

-- Q44. Categorize budget using CASE
SELECT project_name, budget,
    CASE
        WHEN budget >= 60000 THEN 'Large'
        WHEN budget >= 40000 THEN 'Medium'
        ELSE 'Small'
    END AS budget_category
FROM project;

-- Q45. Total budget per department
SELECT dept_id, SUM(budget) AS total_budget
FROM project
GROUP BY dept_id;

-- Q46. Employee with longest first name
SELECT first_name, LENGTH(first_name) AS name_length
FROM employee
ORDER BY name_length DESC
LIMIT 1;

-- Q47. Employees hired in last 90 days
SELECT * FROM employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY);

-- ── DELETION & CLEANUP ───────────────────────

-- Q48. Delete employees with salary < 60000
DELETE FROM employee
WHERE salary < 60000;

-- Q49. Drop project table
DROP TABLE project;

-- Q50. Restore and verify database
-- Step 1: Run in terminal → mysql -u root -p company_db < backup_file.sql
-- Step 2: Verify
USE company_db;
SHOW TABLES;
SELECT table_name, table_rows
FROM information_schema.tables
WHERE table_schema = 'company_db';
-- Step 3: Delete DB after verification
DROP DATABASE company_db;
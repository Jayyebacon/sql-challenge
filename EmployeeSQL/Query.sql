-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT s.emp_no, 
    e.last_name,
    e.first_name, 
    e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON e.emp_no = s.emp_no
ORDER BY s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, 
    last_name, 
    hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department with dept number, name, employee number, last name, and first name.
SELECT dm.dept_no,
    d.dept_name, 
    dm.emp_no, 
    e.last_name, 
    e.first_name
FROM dept_manager AS dm
JOIN departments AS d ON dm.dept_no = d.dept_no
JOIN employees AS e ON dm.emp_no = e.emp_no;

-- 4. List the department number and name for each employee with their employee number, last name, and first name.
SELECT e.emp_no, 
    e.last_name,
    e.first_name, 
    d.dept_no, 
    d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and last name begins with B.
SELECT first_name, 
    last_name,
    sex
FROM employees
WHERE first_name = 'Hercules' AND last_name ILIKE 'B%';

-- 6. Create a temp table of most recent dept assignment per employee.
CREATE TEMP TABLE current_dept_emp AS
SELECT DISTINCT ON (emp_no) emp_no, 
    dept_no
FROM dept_emp
ORDER BY emp_no, dept_no;

-- 7. List each employee in the Sales and Development departments.
SELECT e.emp_no, 
    e.last_name,
    e.first_name,
    d.dept_name
FROM employees AS e
JOIN current_dept_emp AS cde ON e.emp_no = cde.emp_no
JOIN departments AS d ON cde.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- 8. List frequency counts of employee last names in descending order.
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

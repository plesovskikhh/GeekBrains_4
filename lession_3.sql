
-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
SELECT
	ci.title_ru AS city_name,
	r.title_ru AS region_name,
	co.title_ru AS country_name
FROM _cities AS ci
	JOIN _regions AS r ON ci.region_id = r.region_id
	JOIN _countries AS co ON ci.country_id = co.country_id
;
-- 2. Выбрать все города из Московской области.
SELECT
	r.title_ru AS region_name,
    ci.title_ru AS city_name
FROM _regions AS r
	JOIN _cities AS ci ON r.region_id = ci.region_id
WHERE r.title_ru = 'Московская область'
;
-- База данных «Сотрудники»:-- 
USE employees;
-- 1. Выбрать среднюю зарплату по отделам.-- 
SELECT
	dp.dept_name AS dept_name,
	AVG(s.salary) AS avg_salary
FROM departments dp
	JOIN dept_emp AS de ON dp.dept_no = de.dept_no
	JOIN salaries AS s ON de.emp_no = s.emp_no AND s.to_date = '9999-01-01'
GROUP BY dp.dept_name;
-- 2. Выбрать максимальную зарплату у сотрудника.
SELECT
  e.emp_no,
  CONCAT(e.first_name, ' ', e.last_name) AS full_name,
  MAX(s.salary) AS max_salary
FROM employees AS e
	JOIN salaries AS s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
ORDER BY max_salary
LIMIT 1
;
-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM employees WHERE emp_no = (SELECT s.emp_no FROM salaries AS s WHERE s.salary = (SELECT MAX(salary) FROM salaries));
-- 4. Посчитать количество сотрудников во всех отделах.
SELECT
	dp.dept_name,
	COUNT(de.emp_no) AS emp_number
FROM departments AS dp
	JOIN dept_emp AS de ON de.dept_no = dp.dept_no AND de.to_date = '9999-01-01'
GROUP BY dp.dept_name
;
-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT
	dp.dept_name,
	COUNT(de.emp_no) AS emp_number,
	SUM(s.salary) AS salary_amount
FROM departments AS dp
	JOIN dept_emp AS de ON de.dept_no = dp.dept_no AND de.to_date = '9999-01-01'
	JOIN salaries AS s ON de.emp_no = s.emp_no AND s.to_date = '9999-01-01'
GROUP BY dp.dept_name
;
-- 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.

CREATE OR REPLACE VIEW vw_dept_stat AS
SELECT
	dp.dept_name  AS dept_name,
    COUNT(1)      AS emp_number,
	AVG(s.salary) AS avg_salary,
    MAX(s.salary) AS max_salary,
    MIN(s.salary) AS min_salary
FROM departments dp
JOIN dept_emp AS de
	ON dp.dept_no = de.dept_no
    AND de.to_date = '9999-01-01'
JOIN salaries AS s 
	ON de.emp_no = s.emp_no
    AND s.to_date = '9999-01-01'
GROUP BY dp.dept_name;

SELECT * FROM vw_dept_stat;

-- 2. Создать функцию, которая найдет менеджера по имени и фамилии.

DROP FUNCTION IF EXISTS udf_get_manager_no;

DELIMITER //
CREATE FUNCTION udf_get_manager_no (first_name VARCHAR(255), last_name VARCHAR(255))
RETURNS INT DETERMINISTIC
	BEGIN
		DECLARE emp_no INT;
		SELECT 
			dm.emp_no INTO emp_no
		FROM employees AS e
		JOIN dept_emp AS de
			ON e.emp_no = de.emp_no
			AND de.to_date = '9999-01-01'
		JOIN dept_manager AS dm
			ON de.dept_no = dm.dept_no
			AND dm.to_date = '9999-01-01'
		WHERE 1 = 1
			AND e.first_name = first_name
            AND e.last_name = last_name
		LIMIT 1;
		RETURN emp_no;
	END //
DELIMITER ;

SELECT udf_get_manager_no('Duangkaew', 'Piveteau') as emp_no;

-- 3. Создать триггер, который при добавлении нового сотрудника будет
-- выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.

DROP TRIGGER IF EXISTS trg_new_employee;

DELIMITER //
CREATE TRIGGER  trg_new_employee
	AFTER INSERT
	ON employees
	FOR EACH ROW
	BEGIN
		INSERT INTO salaries
		SET emp_no = NEW.emp_no, salary = 10000, from_date = CURDATE(), to_date = '9999-01-01';
	END //
DELIMITER ;

DELETE FROM employees WHERE emp_no = 9999;

INSERT INTO employees (emp_no, first_name, last_name, gender, birth_date, hire_date)
VALUES (9999, 'Unix',  'Epoch',  'F', '1970-01-01',  CURDATE());

SELECT * FROM employees WHERE emp_no = 9999;
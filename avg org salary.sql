DECLARE
    v_avg_salary NUMBER;
BEGIN
    -- Calculate the average salary of the organization
    SELECT AVG(salary)
    INTO v_avg_salary
    FROM emp;

    -- Increase salary for eligible employees
    FOR emp_rec IN (SELECT emp_no, salary FROM emp WHERE salary < v_avg_salary) LOOP
        UPDATE emp
        SET salary = salary * 1.1 -- Increasing salary by 10%
        WHERE emp_no = emp_rec.emp_no;

        -- Inserting a record in the increment_salary table
        INSERT INTO increment_salary (emp_no, salary)
        VALUES (emp_rec.emp_no, emp_rec.salary);

        dbms_output.put_line('Salary increased for employee ' || emp_rec.emp_no);
    END LOOP;
END;
/

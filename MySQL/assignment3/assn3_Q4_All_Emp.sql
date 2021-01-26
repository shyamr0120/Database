select avg(S.salary) as "Mean salary of all employees"
from employees E, salaries S
where E.emp_no = S.emp_no;
select E.gender, avg(S.salary) "Mean salary"
from employees E, salaries S
where E.emp_no = S.emp_no
group by E.gender;
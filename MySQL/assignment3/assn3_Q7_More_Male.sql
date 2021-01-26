select M.dept_name as "departments with more male employees than female"
from
(select D.dept_name, count(*) as num
from employees E, departments D, dept_emp X
where E.emp_no = X.emp_no AND X.dept_no = D.dept_no 
AND E.gender = 'M' group by D.dept_name) as M
join (select D.dept_name, count(*) as num
from employees E, departments D, dept_emp X
where E.emp_no = X.emp_no AND X.dept_no = D.dept_no 
AND E.gender = 'F' group by D.dept_name) as F
on M.dept_name = F.dept_name
where M.num > F.num;
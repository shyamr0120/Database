select count(*)/ (select count(*) from employees E ) as num
from employees E, 
 (select X.emp_no , count(X.emp_no)
from dept_emp X
where X.from_date >=  ( select date_sub(max(E1.hire_date), interval 10 year)  from employees E1)
group by X.emp_no
having count(X.emp_no) >1 ) as multidept
where E.emp_no = multidept.emp_no;
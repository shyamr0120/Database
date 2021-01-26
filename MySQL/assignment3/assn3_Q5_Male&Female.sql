select E.gender, count(*) "Employees joined during last 5 years" 
from employees E
where E.hire_date >= ( select date_sub(max(hire_date), interval 5 year)  from employees E1)
group by E.gender;
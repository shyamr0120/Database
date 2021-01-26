select E.last_name, count(E.last_name) as allcount
from employees E, dept_manager M
where E.emp_no = M.emp_no
group by E.last_name
order by allcount;
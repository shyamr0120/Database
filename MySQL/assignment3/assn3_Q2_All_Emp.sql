select E.first_name, count(E.first_name) as allcount
from employees E
group by E.first_name
order by allcount
desc limit 1;
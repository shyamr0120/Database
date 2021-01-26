(select E.first_name, "M",count(E.first_name) as allcount
from employees E
where E.gender = 'M'
group by E.first_name
order by allcount
desc limit 1)
union
(select E.first_name, "F",count(E.first_name) as allcount
from employees E
where E.gender = 'F'
group by E.first_name
order by allcount
desc limit 1);
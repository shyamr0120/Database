select E.gender, count(*) as num
from employees E
group by E.gender;
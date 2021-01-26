select avg((datediff(curdate(), E.birth_date))/365.25)  "Mean age"
from employees E;
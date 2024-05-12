-- use primer2;

-- Prasanje1
SELECT Ci.Name, Ci.Population
FROM country as C, city as Ci
WHERE C.Continent = 'Europe' AND C.Code = Ci.CountryCode;

-- Prasanje2
SELECT E.first_name, E.last_name, J.job_title
FROM employees as E, jobs as J
WHERE E.job_id = J.job_id AND J.job_title = 'Sales Manager';

-- Prasanje3
SELECT J.job_title
FROM employees as E, jobs as J
WHERE E.job_id is NULL;

-- Prasanje4
SELECT E.first_name, E.last_name, D.first_name, D.last_name 
FROM employees as E, dependents as D
WHERE E.employee_id = D.employee_id AND E.last_name != D.last_name;

-- Prasanje5
SELECT C.Name, Ci.Name, Cl.Language
FROM country as C, city as Ci, countrylanguage as Cl
WHERE C.capital = Ci.ID AND C.Code = Cl.CountryCode AND Cl.IsOfficial = 'T';

-- Prasanje6
SELECT first_name, last_name, Year(hire_date)
FROM employees
WHERE hire_date > '2010-12-31'
ORDER BY hire_date;

-- Prasanje7
SELECT distinct C.Name
FROM employees as E, jobs as J, departments as D, locations as L, country as C
WHERE E.job_id = J.job_id AND J.job_title = 'Programmer' AND E.department_id = D.department_id AND L.location_id = D.location_id AND C.Code2 = L.country_id;




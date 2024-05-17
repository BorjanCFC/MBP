-- use primer2

ALTER TABLE country
ADD COLUMN noLanguages INT default 0;

UPDATE country as c
SET noLanguages = (
    SELECT COUNT(cl.CountryCode)
    FROM countryLanguage as cl
    WHERE cl.CountryCode = c.Code
);

DELIMITER //
CREATE TRIGGER T1 
BEFORE INSERT ON countrylanguage
FOR EACH ROW 
BEGIN
	UPDATE country
    SET noLanguages = noLanguages + 1
    WHERE code = NEW.Countrycode;
END;
//

DELIMITER ;

DELIMITER // 
CREATE TRIGGER T2 
BEFORE DELETE ON countrylanguage
FOR EACH ROW 
BEGIN
	UPDATE country
    SET noLanguages = noLanguages - 1
    WHERE code = OLD.Countrycode;
END;
//

DELIMITER ;

DELIMITER // 
CREATE TRIGGER T3
BEFORE UPDATE ON countryLanguage
FOR EACH ROW
BEGIN
        UPDATE country
        SET noLanguages = noLanguages - 1	
        WHERE Code = OLD.CountryCode;

        UPDATE country
        SET noLanguages = noLanguages + 1
        WHERE Code = NEW.CountryCode;
END;
// 

DELIMITER ;

DELIMITER //
CREATE TRIGGER T4
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.manager_id = NEW.employee_id 
    THEN
        SET NEW.manager_id = NULL;
    END IF;
END;
//

DELIMITER :

DELIMITER //
CREATE TRIGGER T5
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.manager_id = NEW.employee_id THEN
        SET NEW.manager_id = NULL;
    END IF;
END;
//

DELIMITER ;

-- Prasanje1
SELECT Ci.Name, Ci.Population
FROM country as C, city as Ci
WHERE C.Continent = 'Europe' AND C.Code = Ci.CountryCode
ORDER BY Ci.Population;

-- Prasanje2
SELECT E.first_name, E.last_name, J.job_title
FROM employees as E, jobs as J
WHERE E.job_id = J.job_id AND J.job_title = 'Sales Manager';

-- Prasanje3
SELECT job_title
FROM jobs as J
WHERE J.job_id NOT IN (SELECT job_id
FROM employees);

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

CREATE INDEX continent_idx ON country(Continent);
CREATE INDEX job_title_idx ON jobs(job_title);
CREATE INDEX last_name_emp_idx ON employees(last_name);
CREATE INDEX last_name_dep_idx ON dependents(last_name);
CREATE INDEX capital_idx ON country(Capital);

SELECT * FROM countrylanguage;

SELECT * FROM country;

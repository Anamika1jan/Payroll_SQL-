-- 🔹 Basic SQL Queries
-- View all employee records
Select * from payroll_dataset;

-- List all employees in the IT department
SELECT EmployeeID, FullName, JobTitle, CTC_LPA
FROM payroll_dataset
WHERE Department = 'IT';

-- Count number of employees per department
SELECT Department, count(*) as EmployeeCount
from payroll_dataset
group by Department;

-- Finds most demanding jobs
select JobTitle, count(*) as HighPayingJob
from payroll_dataset
group by JobTitle
Order by HighPayingJob Desc;

-- Find employees with salary above 20 LPA
select EmployeeID, FullName, Department, CTC_LPA
 from payroll_dataset
where CTC_LPA > 20
order by EmployeeID desc;

-- Intermediate SQL Queries

-- Average salary per department
select Department,Floor(avg(CTC_LPA)) AS AvgSalary
from payroll_dataset
group by department
order by AvgSalary desc;

-- Employees who joined after 2020
select EmployeeID, FullName, Department,DateOfJoining
from payroll_dataset
where DateOfJoining >2020-01-01; 

-- Find number of Active vs Resigned employees
SELECT EmploymentStatus, COUNT(*) AS Count
FROM payroll_dataset
GROUP BY EmploymentStatus;

-- Top 5 highest paid employees
select EmployeeID, FullName, Department, CTC_LPA
FROM payroll_dataset
order by CTC_LPA DESC
LIMIT 5;

-- Advanced SQL Queries

-- Department-wise highest salary employee
select p.FullName, p.Department, p.CTC_LPA
 from payroll_dataset p
 INNER JOIN 
	(select Department,Max(CTC_LPA)  AS MaxSalary
    from payroll_dataset
    group by Department) t
    ON p.Department = t.Department and p.CTC_LPA = t.MaxSalary;
 
-- Average salary by pay grade & employment status
SELECT PayGrade, EmploymentStatus, ROUND(AVG(CTC_LPA), 2) AS AvgSalary
FROM payroll_dataset
GROUP BY PayGrade, EmploymentStatus
ORDER BY PayGrade;

-- Employees who worked less than 2 years before leaving
SELECT EmployeeID, FullName, Department, DateOfJoining, DateOfLeaving,
       DATEDIFF(DateOfLeaving, DateOfJoining) AS DaysWorked
FROM payroll_dataset
WHERE EmploymentStatus = 'Resigned'
  AND DATEDIFF(DateOfLeaving, DateOfJoining) < 365*2;
  
-- Yearly hiring trend
SELECT YEAR(DateOfJoining) AS JoinYear, COUNT(*) AS Hires
FROM payroll_dataset
GROUP BY YEAR(DateOfJoining)
ORDER BY JoinYear;





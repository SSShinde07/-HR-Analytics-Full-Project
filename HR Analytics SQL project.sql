create database HR_Analytics;
use hr_analytics;
desc hr__1;
desc hr__2;
show tables;
select * from hr__1;
select * from hr__2;

#KPI 1:- Average Attrition Rate for All Department
select Department,count(attrition) `Number of Attrition`from hr__1
where attrition = 'yes'
group by Department;

create view Dept_average as
select department, round(count(attrition)/(select count(employeenumber) from hr__1)*100,2)  as attrtion_rate
from hr__1
where attrition = "yes"
group by department;
select * from dept_average; 

#KPI 2:- Average Hourly Rate for Male Research Scientist
select JobRole, round(avg(hourlyrate),2) as Average_HourlyRate,Gender
from hr__1
where jobrole= 'RESEARCH SCIENTIST' and gender='MALE'
group by jobrole,gender;

#KPI 3:-  AttritionRate VS MonthlyIncomeStats against department
create view Attrition_Vs_AvgMonthlyincome as
select hr__1.Department,
round(count(hr__1.Attrition)/(select count(hr__1.employeenumber) from hr__1)*100,2) 'Attrition rate',
round(avg(hr__2.MonthlyIncome),2) avg_income from hr__1 join hr__2
on hr__1.EmployeeNumber = hr__2.`Employee ID`
where Attrition = 'Yes'
group by hr__1.Department;


select * from Attrition_Vs_AvgMonthlyincome;


#KPI 4:- Average Working Years for Each Department 
select hr__1.Department, round(avg(hr__2.TotalWorkingYears),2) as Average_Working_Year
from hr__1 join hr__2
on hr__1.EmployeeNumber = hr__2.`Employee ID`
group by hr__1.Department;

#KPI 5:- Job Role VS Work Life Balance
select hr__1.JobRole,
round(avg(hr__2.WorkLifeBalance),2) as Average_WorkLifeBalance
from hr__1 
 join hr__2 on hr__2.`Employee ID` = hr__1.EmployeeNumber
group by hr__1.jobrole;

#KPI 6:- Attrition Rate Vs Year Since Last Promotion Relation Against Job Role 
SELECT hr__2.`YearsSinceLastPromotion`,
round((COUNT(hr__1.attrition) / (SELECT COUNT(*) FROM hr__1 WHERE attrition = 'Yes')) * 100, 2) AS 'attrition_rate'
FROM hr__1
JOIN hr__2 ON hr__1.employeenumber = hr__2.`employee id`
WHERE hr__1.attrition = 'Yes'
GROUP BY `YearsSinceLastPromotion`
ORDER BY `YearsSinceLastPromotion`;

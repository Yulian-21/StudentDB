use ITCompany
go

select * 
from Employees

select EmployeeName
from Employees

select EmployeeSurName, EmployeeName
from Employees

select distinct DateofAdmission
from Employees

update Employees
set DateofAdmission = '20050203'
where EmployeeId = 5

Select * 
from Employees
where Employees.EmployeeName Like 'Cas%' or Employees.EmployeeName Like 'Gi%'

Select * 
from Employees
where Employees.EmployeeName Like 'C%'

select *
from Employees
where DateofAdmission > '20170101'

select count(*)
from Employees
where DateofAdmission > '20170101'

select *
from ClientsRepresentative
inner join ClientCompany
on ClientsRepresentative.FromCompany = ClientCompany.CompanyID

select *
from Projects
join ClientsRepresentative
on Projects.ClientId = ClientsRepresentative.ClientID
join ClientCompany
on ClientsRepresentative.FromCompany = ClientCompany.CompanyID
--left join ProjectActivity
--on ProjectActivity.ProjectID = Projects.ProjectID
--left join Teams
--on ProjectActivity.TeamId  = Teams.TeamID

select *
from Teams
join EmployeeActivity
on Teams.TeamID = EmployeeActivity.TeamId
join Employees
on EmployeeActivity.EmployeeId = Employees.EmployeeId
where Teams.TeamName = 'TeamD'
order by EmployeeName asc

select distinct Projects.ProjectName, Projects.ProjectStartDate
from Projects
join ClientsRepresentative
on Projects.ClientId = ClientsRepresentative.ClientID
join ClientCompany
on ClientsRepresentative.FromCompany = ClientCompany.CompanyID
left join ProjectActivity
on ProjectActivity.ProjectID = Projects.ProjectID
left join Teams
on ProjectActivity.TeamId  = Teams.TeamID
join EmployeeActivity
on Teams.TeamID = EmployeeActivity.TeamId
join Employees
on EmployeeActivity.EmployeeId = Employees.EmployeeId


select distinct ProjectName
from Projects 
join ProjectActivity
on Projects.ProjectID = ProjectActivity.ProjectID
join Teams
on ProjectActivity.TeamId = Teams.TeamID
Group by (ProjectName)

select distinct ProjectName
from Projects
join ProjectActivity 
on  Projects.ProjectID = ProjectActivity.ProjectID and Projects.ProjectCompleteDate is null
join Teams
On ProjectActivity.TeamId = Teams.TeamID
join EmployeeActivity
on EmployeeActivity.TeamId = Teams.TeamID
join Employees
on EmployeeActivity.EmployeeId = Employees.EmployeeId
join ProjectManagers
on Employees.ReportingTo = ProjectManagers.PMID
where ProjectManagers.PMName = 'Georges'

Select top(3) *
from Projects
where ProjectCompleteDate is not null
order by DateDiff(day, ProjectStartDate, ProjectCompleteDate) desc


select count(*)
from Employees
join ProjectManagers
on ReportingTo = PMID
where PMName = 'Francois'

select * 
from ProjectManagers
join CEOs
on ProjectManagers.ReportingToCEO = CEOs.CEOID
where CEOName != 'Thomas'

select *
from Employees
left join EmployeeActivity
on Employees.EmployeeId = EmployeeActivity.EmployeeId
where EmployeeActivity.EmployeeId is null

select PMName, count(*)
from Employees
inner join ProjectManagers
on ProjectManagers.PMID = Employees.ReportingTo
Group by (ProjectManagers.PMName)

select TeamName, count(*)
from Employees
inner join EmployeeActivity
on Employees.EmployeeId = EmployeeActivity.EmployeeId
join  Teams
on EmployeeActivity.TeamId = Teams.TeamID
Group by (TeamName)

select CEOName, Count(*)
from Employees
join ProjectManagers
on Employees.ReportingTo = ProjectManagers.PMID
join CEOs
on ProjectManagers.ReportingToCEO = CEOs.CEOID
Group by CEOName

--serednyu kilkist proektiv na komandu i serednu kilkist emloiv na comandu

select EmployeesTotalCount.Name,  1.0* EmployeesTotalCount.EmployeesCount / ProjectsTotalCount.ProjectsCount as Average
from
(
select TeamName as Name, count(*) as EmployeesCount
from Teams
 join EmployeeActivity
on EmployeeActivity.TeamId = Teams.TeamID
 join Employees
on Employees.EmployeeId = EmployeeActivity.EmployeeId
Group By(TeamName)
) 
as EmployeesTotalCount
left join
(
Select TeamName, Count(*) as ProjectsCount
from Projects 
join ProjectActivity
on Projects.ProjectID = ProjectActivity.ProjectID
join Teams
on ProjectActivity.TeamId = Teams.TeamID
group by TeamName 
)
as ProjectsTotalCount
On ProjectsTotalCount.TeamName = EmployeesTotalCount.Name

select Top(1) PMName, Count(*)
from ProjectManagers
join Employees 
on Employees.ReportingTo = PMID
join EmployeeActivity
on EmployeeActivity.EmployeeId = Employees.EmployeeId
join Teams
on Teams.TeamID = EmployeeActivity.TeamId
Group by PMName
Order by count(*) asc

select PMName, count(*)
from ProjectManagers
join Employees
on Employees.ReportingTo = ProjectManagers.PMID
Group by PMName
Order by count(*) asc

Select EmployeeName, count(*) as ClientsCompanyCount--distinct *
from Employees 
left join EmployeeActivity
on Employees.EmployeeId = EmployeeActivity.EmployeeId
left join Teams
on Teams.TeamID = EmployeeActivity.TeamId
left join ProjectActivity
on Teams.TeamID = ProjectActivity.TeamId
left join Projects
on ProjectActivity.ProjectID = Projects.ProjectID
left join ClientsRepresentative
on Projects.ClientId = ClientsRepresentative.ClientID
left join ClientCompany
on ClientCompany.CompanyID = ClientsRepresentative.FromCompany
Group By EmployeeName
order by ClientsCompanyCount asc

select distinct *
from Employees
join Ranks
on Employees.RanksId = Ranks.RankID
join WorkingMachine
on Employees.WorkingMachineID = WorkingMachine.MachineID


select distinct EmployeeSurname, EmployeeName, DateofAdmission, RankName, DollarsPerHour, MachineName, ModelName,
PMSurName, PMName, CEOName, CEOSurname, RecruiterName, RecruiteSurName, TeamName, ProjectName, CompanyName, ClientName, ClientSurName
from Employees
join Ranks
on Employees.RanksId = Ranks.RankID
join WorkingMachine
on Employees.WorkingMachineID = WorkingMachine.MachineID
join Salary
on Ranks.SalaryId = Salary.SalaryID
join ProjectManagers
on Employees.ReportingTo = ProjectManagers.PMID
join CEOs
on ProjectManagers.ReportingToCEO = CEOID
join RecruiteOffice
on Employees.HiredBy = RecruiteOffice.RecruiterID
full join EmployeeActivity 
on Employees.EmployeeId = EmployeeActivity.EmployeeId
left join Teams 
on Teams.TeamID = EmployeeActivity.TeamId
left join ProjectActivity
on ProjectActivity.TeamId = Teams.TeamID
left join Projects
on ProjectActivity.ProjectID = Projects.ProjectID
left Join ClientsRepresentative 
on ClientsRepresentative.ClientID = Projects.ClientId
left join ClientCompany
on ClientsRepresentative.FromCompany = ClientCompany.CompanyID
order by DollarsPerHour desc


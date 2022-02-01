create database ITCompany
go

use ITCompany
go

create table CEOs
(
CEOID int Identity(1,1) not null,
CEOSurname nvarchar(70) not null,
CEOName nvarchar(80) not null
)
go

create table ProjectManagers
(
PMID int identity(1,1) not null,
PMSurName nvarchar(200) not null,
PMName nvarchar(200) not null,
ReportingToCEO int not null,
SalaryId int not null
)
go



Create table RecruiteOffice
(
RecruiterID int Identity(1,1) not null,
RecruiteSurName nvarchar(100) not null,
RecruiterName nvarchar(100) not null,
ReportingToPM int not null,
SalaryID int not null
)
go


Create table WorkingMachine
(
MachineID int Identity(1,1) not null,
MachineName nvarchar(200) not null,
)
go

Create table Salary
(
SalaryID int identity(1,1) not null,
DollarsPerHour money not null
)
go

create table ClientCompany
(
CompanyID int Identity(1,1) not null,
CompanyName nvarchar(300) not null
)

create table ClientsRepresentative
(
ClientID int Identity(1,1) not null,
ClientSurName nvarchar(200) not null,
ClientName nvarchar(200) not null
)
go

create table Teams
(
TeamID int Identity(1,1) not null,
TeamName nvarchar(200) not null,
)
go

create table Projects
(
ProjectID int Identity(1,1) not null,
ProjectName nvarchar(200) not null,
ClientId int not null
)
go


create table Employees
(
EmployeeID int identity(1,1) not null,
EmployeeSurname nvarchar(70) not null,
EmployeeName nvarchar(70) not null,
RanksId int not null,
WorkingMachineID int not null,
HiredBy int not null,
ReportingTo int not null,
InTeam int not null
)
go

create table ProjectActivity
(
ActivityID int Identity(1,1) not null,
TeamId int not null,
ProjectID int not null
)
go

create table Ranks
(
RankID int identity(1,1) not null,
RankName nvarchar(50) not null,
SalaryId int not null
)
go

Alter table CEOs
add constraint PK_CEO_CEOID
Primary key clustered (CEOID)
go

Alter table ProjectManagers
add constraint PK_ProjectManagers_PMID
Primary key clustered (PMID)
go 

Alter table RecruiteOffice
add constraint PK_RecruiteOffice_RecID
Primary key clustered (RecruiterID)
go 

Alter table WorkingMachine
add constraint PK_WorkingMachine_MachID
Primary key clustered (MachineID)
go 

Alter table Salary
add constraint PK_Salary_SalaryID
Primary key clustered (SalaryID)
go 

Alter table ClientCompany
add constraint PK_ClientCompany_CompanyID
Primary key clustered (CompanyID)
go

Alter table ClientsRepresentative
add constraint PK_ClientsRepresentative_ClientID
Primary key clustered (ClientID)
go

Alter table Teams
add constraint PK_Teams_TeamID
Primary key clustered (TeamID)
go

Alter table Projects
add constraint PK_Projects_ProjectID
Primary key clustered (ProjectID)
go

Alter table Employees
add constraint PK_Employees_EmployeeID
Primary key clustered (EmployeeID)
go

Alter table ProjectActivity
add constraint PK_ProjectActivity_ActivityID
Primary key clustered (ActivityID)
go

Alter table Ranks
add constraint PK_Ranks_RankID
Primary key clustered (RankID)
go

alter table ClientsRepresentative
add FromCompany int not null
go

alter table ProjectManagers
with check add constraint FK_ProjMngs_Ceos
foreign key (ReportingToCEO)
references CEOs(CEOID)
on update cascade
on delete cascade
go

alter table RecruiteOffice
with check add constraint FK_RecruiteOffice_ProjMngs
foreign key (ReportingToPM)
references ProjectManagers(PMID)
on update cascade
on delete cascade
go

alter table RecruiteOffice
with check add constraint FK_RecruiteOffice_Salary
foreign key (SalaryID)
references Salary(SalaryID)
on update cascade
on delete cascade
go

alter table ClientsRepresentative
with check add constraint FK_ClientsRepresentative_ClientCompany
foreign key (FromCompany)
references ClientCompany(CompanyID)
on update cascade
on delete cascade
go



alter Table Projects
with check add constraint FK_Projects_Clients
foreign Key (ClientId)
references ClientsRepresentative(ClientID)
on update cascade 
on delete cascade
go

alter table ProjectActivity
with check add constraint FK_ProjAct_Projects
Foreign key (ProjectId)
references Projects(ProjectID)
on update cascade
on delete cascade
go

alter table ProjectActivity
with check add constraint FK_ProjAct_Teams
Foreign key (TeamId)
references Teams(TeamID)
on update cascade
on delete cascade
go

alter table Employees
with check add constraint FK_Employees_Ranks
foreign key (RanksId)
References Ranks(RankID)
on update cascade
on delete cascade
go

alter table Employees
with check add constraint FK_Employees_WM
foreign key (WorkingMachineID)
References WorkingMachine(MachineID)
on update cascade
on delete cascade
go

alter table Employees
with check add constraint FK_Employees_Recruiter
foreign key (HiredBy)
References RecruiteOffice(RecruiterID)
on update cascade
on delete cascade
go



alter table Employees
with check add constraint FK_Employees_Teams
foreign key (InTeam)
References Teams(TeamID)
on update cascade
on delete cascade
go




alter table Ranks
with check add constraint FK_Ranks_Salary
foreign key (SalaryId)
references Salary(SalaryID)
on update cascade
on delete cascade
go

alter table Employees
with check add constraint FK_Employees_PM
foreign key (ReportingTo)
References ProjectManagers(PMID)
go

alter table ProjectManagers
drop column SalaryId
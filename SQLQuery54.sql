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

alter table ProjectManagers
add RankId int not null

alter table ProjectManagers
with check add constraint FK_ProjMngs_Ceos
foreign key (ReportingToCEO)
references CEOs(CEOID)
on update cascade
on delete cascade
go

alter table ProjectManagers
with check add constraint FK_ProjectManagers_Ranks
foreign key (RankId)
references Ranks(RankID)
on update no action
on delete no action
go



create table EmployeeActivity
(
ActivID int identity(1,1) not null,
EmployeeId int not null,
TeamId int not null
)

alter table Projects
add ProjectStartDate datetime not null

alter table Projects
add constraint DF_Projects_StartDate
Default getdate() for ProjectStartDate;



exec sp_rename 'RecruiteOffice.SalaryId', 'RankId';

alter table RecruiteOffice
with check add constraint FK_RecruiteOffice_Ranks
foreign key(RankId)
references Ranks(RankID)
on update no action
on delete no action
go

alter table EmployeeActivity 
with check add constraint FK_EmpAct_Employees
foreign key (EmployeeId)
references Employees(EmployeeID)
on update cascade
on delete set null

alter table EmployeeActivity 
with check add constraint FK_EmpAct_Teams
foreign key (TeamId)
references Teams(TeamID)
on update cascade
on delete set null

alter table Employees
with check add constraint FK_Employees_WM
foreign key (WorkingMachineID)
References WorkingMachine(MachineID)
on update cascade
on delete set null
go

alter table Employees drop constraint FK_Employees_Ranks;
go 

alter table Employees
with check add constraint FK_Employees_Ranks
foreign key (RanksId)
References Ranks(RankID)
on update no action
on delete no action
go

alter table Employees
with check add constraint FK_Employees_PM
foreign key (ReportingTo)
References ProjectManagers(PMID)
on update no action
on delete no action
go

alter table EmployeeActivity
alter column EmployeeId int null

alter table EmployeeActivity
alter column TeamId int null

alter table Employees
alter column WorkingMachineId int null

alter table Employees
alter column HiredBy int null

alter table Employees
alter column RanksId int null

alter table Employees
alter column ReportingTo int null



alter table Ranks drop constraint FK_Ranks_Salary;

alter table Ranks
add constraint CON_Salary_ID default '1' for SalaryId

alter table Ranks 
with check add constraint FK_Ranks_Salary
foreign key (SalaryId)
References Salary(SalaryID)
on update cascade
on delete set default



alter table Employees 
add constraint Con_Employees_WorkingMachineID default '1' for WorkingMachineID

alter table Employees
with check add constraint FK_Employees_WM
foreign key (WorkingMachineID)
References WorkingMachine(MachineID)
on update cascade
on delete set default
go

alter table Employees drop constraint FK_Employees_Recruiter;

alter table Employees
add constraint CON_Hired_By default '1' for HiredBy



alter table RecruiteOffice
alter Column ReportingToPM int null

alter table RecruiteOffice
alter Column RankId int null



alter table RecruiteOffice drop constraint FK_RecruiteOffice_ProjMngs;

alter table RecruiteOffice drop constraint FK_RecruiteOffice_Ranks;

alter table RecruiteOffice
add constraint CON_Rank_Id default '1' for RankId

alter table RecruiteOffice
with check add constraint FK_RecruiteOffice_Ranks
foreign key (RankId)
References Ranks(RankId)
on update no action
on delete no action
go


alter table RecruiteOffice drop constraint CON_Reporting_ToPM;
go

alter table RecruiteOffice
add constraint CON_Reporting_ToPM default '1' for ReportingToPM
go

alter table RecruiteOffice
with check add constraint FK_RecruiteOffice_ProjectManagers
foreign key (ReportingToPM)
References ProjectManagers(PMID)
on update cascade
on delete set default
go

alter table ProjectManagers
alter Column ReportingToCEO int null
go

alter table ProjectManagers
alter Column RankId int null
go

alter table ProjectManagers drop constraint FK_ProjMngs_Ceos;
go

alter table ProjectManagers
add constraint CON_Reporting_ToCEO default '1' for ReportingToCEO
go

alter table ProjectManagers
with check add constraint FK_ProjectManagers_CEO
foreign key (ReportingToCEO)
References CEOs(CEOID)
on update cascade
on delete set null
go

alter table ProjectManagers drop constraint FK_ProjectManagers_Ranks;

alter table ProjectManagers
add constraint CON_PJ_RankId default '1' for RankId

alter table ProjectManagers
with check add constraint FK_ProjectManagers_Ranks
foreign key (RankId)
References Ranks(RankId)
on update no action
on delete no action
go

alter table EmployeeActivity drop constraint FK_EmpAct_Employees;
alter table EmployeeActivity drop constraint FK_EmpAct_Teams;

alter table ProjectManagers
add constraint CON_PJ_RankId default '1' for RankId

alter table EmployeeActivity
with check add constraint FK_EmpAct_Employees
foreign key (EmployeeId)
References Employees(EmployeeId)
on update set null
on delete set null
go

alter table EmployeeActivity
with check add constraint FK_EmpAct_Teams
foreign key (TeamId)
References Teams(TeamID)
on update cascade
on delete cascade
go


alter table ProjectActivity drop constraint FK_ProjAct_Projects;
alter table ProjectActivity drop constraint FK_ProjAct_Teams;

alter table ProjectActivity
alter Column TeamId int null

alter table ProjectActivity
with check add constraint FK_ProjAct_Projects
foreign key (ProjectID)
References Projects(ProjectID)
on update cascade
on delete cascade
go

alter table ProjectActivity
with check add constraint FK_ProjAct_Teams
foreign key (TeamId)
References Teams(TeamID)
on update set null
on delete set null
go

insert into CEOs(CEOSurname, CEOName) values
('Washington','George'),
('Adams','John'),
('Jefferson','Thomas')

insert into Salary(DollarsPerHour) Values
('5'),
('10'),
('12'),
('15'),
('8'),
('9'),
('6'),
('20'),
('26'),
('22'),
('18')
go

insert into Ranks(RankName, SalaryId) values
('PM','9'),
('TeamLidDev','10'),
('SeniorDev','8'),
('MiddleDev','11'),
('StrongJuniorDev','5'),
('Junior','7'),
('Trainee','1'),
('SeniorQA','4'),
('MiddleQA','3'),
('JuniorQA','2'),
('SeniorUI/UX','11'),
('MiddleUI/UX','4'),
('JuniorUI/UX','1'),
('Recruiter','6'),
('HRManager','6'),
('Maid','1'),
('Custodian','7'),
('OfficeManager','2')

Insert into ProjectManagers(PMSurName, PMName, ReportingToCEO, RankId) values
('Sarkozy','Nicolas','1','9'),
('Hollande','Francois','2','9'),
('Pompidou','Georges','3','9'),
('Mitterrand','Francois','2','9'),
('de Gaulle','Charles','1','9')

alter table RecruiteOffice
with check add constraint FK_RecruiteOffice_Ranks
foreign key (RankId)
references Ranks(RankID)
on update cascade
on delete cascade



alter table WorkingMachine
add SerialNumber nvarchar(200)

exec sp_rename 'WorkingMachine.SerialNumber', 'ModelName';

Insert into WorkingMachine(MachineName, ModelName) values
('HP','Omen'),
('HP','Pavilion'),
('Lenovo','Legion'),
('MacBook','Pro'),
('MacBook','Air'),
('Dell','Inspirion'),
('Dell','Alienware'),
('Acer','Aspire')

Insert into ClientCompany(CompanyName) values
('USA'),
('France'),
('United Kingdom'),
('Ukraine'),
('Turkey'),
('China'),
('Canada'),
('Japan')

alter table ClientsRepresentative
alter column ClientSurName nvarchar(200) null

insert into ClientsRepresentative(ClientSurName, ClientName, FromCompany) values
('Biden','Josef','1'),
('','Naruhito','8'),
('Trudeau','Justin','7'),
('Recep Tayyip','Erdogan','5'),
('Zelensky','Volodymyr','4'),
('Macron','Emmanuel','2'),
('Xi','Jinping','6'),
('Johnson','Boris','3')

alter table Teams
add EmployeesCount int not null



alter table Projects
add ProjectCompleteDate datetime null

insert into Projects(ProjectName, ProjectStartDate, ProjectCompleteDate, ClientId) values
('ProjectUA','20210502','20220101','5'),
('ProjectJP','20211212','','2'),
('ProjectTU','20220202','','4'),
('ProjectUK','20200202','20211205','8'),
('ProjectCH','20180915','20200619','7'),
('ProjectCA','20140802','20210527','3'),
('ProjectUS','20101225','','1'),
('ProjectFR','20150213','20201124','6')


insert into ProjectActivity(TeamId, ProjectID) Values
('1','2'),
('1','3'),
('2','2'),
('3','7'),
('5','7'),
('7','7'),
('4','3'),
('9','2')

alter table Employees
add DateofAdmission datetime not null

insert into RecruiteOffice(RecruiteSurName, RecruiterName, ReportingToPM, RankID) values
('Schmidt','Helmut','2','14'),
('Kohl','Helmut','2','15'),
('Schroder','Gerhard','3','18'),
('Brandt','Willy','3','15'),
('Kiesinger','Kurt George','5','14'),
('Erhard','Ludwig','4','15'),
('Adenauer','Konrad','1','18'),
('von Bismarck','Otto','5','18')

alter table RecruiteOffice
drop column RecruiterID

alter table RecruiteOffice
add RecruiterID int identity(1,1) primary key clustered

alter table RecruiteOffice
drop constraint PK_RecruiteOffice_RecID

alter table Employees
with check add constraint FK_Employees_Recruiter
foreign key (HiredBy)
References RecruiteOffice(RecruiterID)
on update cascade
on delete set default
go

insert Into Employees (EmployeeSurname, EmployeeName, RanksId, WorkingMachineID, HiredBy, ReportingTo, DateofAdmission) values
('Marks','Gillian','2','1','3','1','20050203'),
('Hanson','Jimmy','3','2','5','3','20070508'),
('Braylon','Herman','5','6','7','2','20091202'),
('Ayers','Garrett','6','5','2','4','20181222'),
('Huang','Eli','4','7','4','5','20210503'),
('Cisneros','Matthew','12','2','8','3','20220101'),
('Pollard','Arturo','13','3','4','1','20201015'),
('Lamar','Hardy','10','2','1','2','20200229'),
('Mercado','Skylar','7','7','7','3','20160309'),
('Valdez','Tristan','11','8','6','2','20180719'),
('Flowers','Casey','9','4','6','4','20160815'),
('Payne','Cassandra','8','3','4','5','20140820')

alter table EmployeeActivity
add constraint FK_EmployeeActivity_ActivID
primary key clustered (ActivID)


insert into EmployeeActivity(EmployeeId, TeamId) values
('1','1'),
('2','2'),
('3','3'),
('1','4'),
('5','5'),
('6','6'),
('7','7'),
('9','8'),
('10','9'),
('11','10'),
('12','4'),
('5','3'),
('6','2'),
('4','5'),
('8','7')


alter table Employees
drop column EmployeeId

alter table Employees
add EmployeeId int identity(1,1) primary key clustered

exec sp_rename 'FK_EmployeeActivity_ActivID' , 'PK_EmployeeActivity_ActivID'

alter table Employees
drop constraint PK_Employees_EmployeeID

alter table EmployeeActivity
with check add constraint FK_EmpAct_Employees
foreign key (EmployeeId)
References Employees(EmployeeID)
on update cascade
on delete set default
go


insert into Teams(TeamName, EmployeesCount) values
('TeamA','12'),
('TeamB','5'),
('TeamC','3'),
('TeamD','3'),
('TeamE','14'),
('TeamF','4'),
('TeamG','10'),
('TeamH','6'),
('TeamI','8'),
('TeamJ','6')
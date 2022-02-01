use DfMyStudendDB
Go

create table Department
(
DepartmentID int Identity(1,1),
DepartmentName nvarchar(50) Not null
)
go

create table Curators
(
CuratorId int identity(1,1) not null,
CuratorName nvarchar(100) not null,
CuratorAge int not null
)

insert into Curators(CuratorName, CuratorAge) values
('Name1','20'),
('name2','25'),
('name3','40'),
('name4','35')

alter table Curators
add  constraint PK_Curators_CuratorID
primary key clustered (CuratorID)

insert into Curators(CuratorName, CuratorAge)
select Curators.CuratorName, Curators.CuratorAge
from Curators

select distinct *
from Curators
where Curators.CuratorId % 4 = 0


EXEC sp_rename 'Department.DeploymentName', 'DepartmentName';
go


Alter table Department
Add constraint PK_Department_DepartmentID
primary key clustered (DepartmentID)
Go

insert into Department(DepartmentName) values
('Electronic'),
('Filological'),
('Mathematical'),
('Philosophical')
go



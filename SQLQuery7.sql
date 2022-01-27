use DfMyStudendDB
Go

create table Department
(
DepartmentID int Identity(1,1),
DepartmentName nvarchar(50) Not null
)
go


EXEC sp_rename 'Department.DeploymentName', 'DepartmentName';
go


Alter table Department
Add constraint PK_Department_DepartmentID
primary key clustered (DepartmentID)
Go


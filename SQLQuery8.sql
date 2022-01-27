USE DfMyStudendDB
GO


CREATE TABLE Groups(
GroupID int Identity(1,1),
 Name nvarchar(50) not null,
 DeploymenId int not null
)
GO

EXEC sp_rename 'Groups.DeploymentID', 'DepartmentId';
go

Alter table Groups
Add constraint PK_Groups_GroupID
primary key clustered (GroupID)
Go


Alter table Groups
with check add constraint FK_Groups_Department
foreign key(DepartmentId)
references Department (DepartmentID)
On Update cascade
on delete cascade
go

USE DfMyStudendDB
GO

CREATE TABLE Students(
StudentID int Identity(1,1),
 Name nvarchar(200) not null,
 GroupId int not null
)
GO

Alter table Students
Add constraint PK_Students_StudentID
primary key clustered (StudentID)
Go

alter table Students
with check add constraint FK_Students_Groups
foreign key (GroupId)
references Groups (GroupID)
on update cascade
on delete cascade
go
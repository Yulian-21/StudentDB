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

alter table Students
add DateOfBith datetime not null
go

exec sp_rename 'Students.DateOfBith', 'DateOfBirth';
go

insert into Students(Name, GroupId, DateOfBirth) values
('Ivan', '1', '20010507'),
('Petro','2','20001222'),
('Ivan', '2', '20030929'),
('Vasyl','3','20040315'),
('Diana','7','19990124'),
('Tom','4','19980202'),
('Mike','6','20010409'),
('John','3','20010604'),
('Anastasiya','5','20010506'),
('Anna','8','20000419'),
('Mykola','6','19970512'),
('Nazar','5','20030904'),
('Alexander','1','20010911'),
('Sofiya','7','20030315'),
('Viktoria', '7','20030205')

update Students
set DateOfBirth = '20010507'
where StudentID=7

select * from Students

select Name from Students

select Distinct DateOfBirth from Students 

Select * from Students where Name like 'Ivan'

Select * from Students where DateOfBirth>'20000101'

select count (*) from Students
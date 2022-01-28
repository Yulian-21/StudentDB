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

insert into Groups(Name, DepartmentId) values
('FeS', '1' ),
('FeI', '1'),
('AAT', '2'),
('UNF', '2'),
('MKT', '3'),
('DMM', '3'),
('PKB', '4'),
('PKK', '4')
go


select * 
from Groups
INNER JOIN Department
on Groups.DepartmentId = Department.DepartmentID
go

select *
from Students
inner join Groups
on Students.GroupId = Groups.GroupID where Groups.DepartmentId = 1
go

select * 
from Students
inner join Groups
on Students.GroupId = Groups.GroupID 
where Groups.GroupID = 1
order by Students.Name asc

Select distinct BookName, AuthorName
from Library
inner join LibraryActivity
on LibraryActivity.BookId = Library.LibraryId

select * 
from Library 
  inner join LibraryActivity
    on LibraryActivity.BookId = Library.LibraryId and LibraryActivity.DeliveryDate is Null 
  inner join Students
  on LibraryActivity.StudentId = Students.StudentID 
  inner join Groups 
  on Students.GroupId = Groups.GroupID where Groups.DepartmentId = 1


--where LibraryActivity.StudentId In (select Students.StudentID
--from Students
--inner join Groups
--on Students.GroupId = Groups.GroupID where Groups.DepartmentId = 1)
--go

Select *
From Library
inner join LibraryActivity
on LibraryActivity.BookId = Library.LibraryId
where LibraryActivity.StudentId In (select Students.StudentID
from Students
inner join Groups
on Students.GroupId = Groups.GroupID where Groups.DepartmentId = 1)
go

Select Top(3)*
From Library
inner Join LibraryActivity
on LibraryActivity.BookId = Library.LibraryId and LibraryActivity.DeliveryDate is not Null 
order by DateDiff(day,  LibraryActivity.DateOfReceiving, LibraryActivity.DeliveryDate) desc
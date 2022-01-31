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

select count(*) 
from Students 
inner join Groups 
on Students.GroupId = Groups.GroupID
where Groups.Name = 'PKK'

select Groups.Name, count(*)
from Groups 
where Groups.GroupID = 2

select Groups.Name, Count(*)
from Students
inner join Groups
on Students.GroupId = Groups.GroupID
where Groups.Name like 'P%'
group by Groups.Name
having count(*)>=2

Select * 
from Groups 
inner join Department 
on Groups.DepartmentId = Department.DepartmentID
where DepartmentName not like 'Mathematical'


select Students.StudentID, Students.Name, Students.GroupId
from Students
left join LibraryActivity
on Students.StudentID = LibraryActivity.StudentId
where LibraryActivity.DateOfReceiving is NULL

select Groups.Name, count(*)
from Students
inner join Groups
on Students.GroupId = Groups.GroupID
Group by Groups.Name

--select Department.DepartmentName, count(*)
--from Department
--inner join Groups
--on Department.DepartmentID = Groups.DepartmentId
--inner Join Students 
--on Groups.GroupID = Students.GroupId
--Group by Department.DepartmentName

select Department.DepartmentName, count(*)
from Students
inner join Groups
on Students.GroupId = Groups.GroupID 
inner join Department
on Groups.DepartmentId = Department.DepartmentID
Group By Department.DepartmentName 


Select avg(Library.LibraryId)
from Library
inner join LibraryActivity
on LibraryActivity.BookId = Library.LibraryId


select Top(1)Groups.Name, count(*)--4
from LibraryActivity
inner join Students
on Students.StudentID = LibraryActivity.StudentId
inner join  Groups
on Students.GroupId = Groups.GroupID
Group by Groups.Name
order by count(*) asc



select  Library.BookName, Groups.Name as GroupName, Students.Name as StudentName
from Library
inner join LibraryActivity
on Library.LibraryId = LibraryActivity.BookId
inner join Students
on LibraryActivity.StudentId = Students.StudentID
inner join Groups 
on Groups.GroupID = Students.GroupId


select TotalBooksPerGroup.GroupName, 1.0 * TotalBooksPerGroup.TotalBooksCount / TotalStodentsPerGroup.TotalStudentsCount as Average
from
(
	select Groups.Name as GroupName, count(*) as TotalBooksCount
	from LibraryActivity
	inner join Library 
	on LibraryActivity.BookId = Library.LibraryId
	inner join Students
	on LibraryActivity.StudentId = Students.StudentID
	inner join Groups
	on Groups.GroupID = Students.GroupId
	group by Groups.Name
) as TotalBooksPerGroup
inner join
(
	select Groups.Name as GroupName, count(*) as TotalStudentsCount
	from Students
	inner join Groups
	on Students.GroupId = Groups.GroupID
	Group by Groups.Name
) as TotalStodentsPerGroup
on TotalBooksPerGroup.GroupName = TotalStodentsPerGroup.GroupName


Select * 
from Students
left join LibraryActivity
on Students.StudentID = LibraryActivity.StudentId 
inner join Groups
on Students.GroupId = Groups.GroupID
join Department
on Groups.DepartmentId = Department.DepartmentID
where Department.DepartmentName = 'Mathematical'
and LibraryActivity.DateOfReceiving is null


Select Groups.Name, count(*)
from Groups
inner join Students
on Groups.GroupID = Students.GroupId
inner join LibraryActivity
on Students.StudentID = LibraryActivity.StudentId
inner join Department
on Department.DepartmentID = Groups.DepartmentId
where Department.DepartmentName = 'Electronic'
Group by Groups.Name
having Count(*)>=2

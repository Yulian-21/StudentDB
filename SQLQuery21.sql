use DfMyStudendDB
go 

Create Table LibraryActivity(
ID int identity(1,1)not null,
StudentId int not null,
BookId int not null,
DateOfReceiving datetime not null,
DeliveryDate datetime null
)

alter table LibraryActivity
add constraint PK_LibraryActivity_ID
primary key clustered(ID)
go

alter table LibraryActivity
add constraint DF_LibraryActivity_DateOfReceiving
default getdate()
for DateOfReceiving
go

alter table LibraryActivity
with check add constraint FK_LibraryActivity_Students
foreign key (StudentId)
references Students(StudentID)
on update cascade
on delete cascade
go

alter table LibraryActivity
with check add constraint FK_LibraryActivity_Library
foreign key (BookId)
references [Library](LibraryID)
on update cascade
on delete cascade
go

Insert into LibraryActivity(StudentId, BookId, DateOfReceiving, DeliveryDate) values
('1','1','20170203','20180105'),
('2','3','20190409','20190601'),
('4','2','20180302','20180618'),
('6','5','20200525','20211130'),
('8','2','20180912','20190425'),
('5','4','20210918',''),
('3','3','20180624','20181222'),
('7','8','20220102','20220122'),
('3','1','20180205','20181012'),
('2','6','20210814','20220112')

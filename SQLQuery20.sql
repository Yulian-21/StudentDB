use DfMyStudendDB
go

Create table [Library](
[LibraryId] int identity(1,1) not null,
BookName nvarchar(200) not null
)
go

alter table Library
add constraint PK_Library_LibraryId
primary key clustered (LibraryId)
go

alter table Library
add AuthorName nvarchar(200) not null
go

insert into Library(BookName, AuthorName) values
('CLR Via C#', 'Jeffrey Richter'),
('Zapovit', 'Taras Shevchenko'),
('The Art Of Electronic', 'Pol Horovitz'),
('Politeia', 'Plato'),
('The Lord of the Rings', 'John Ronald Reyel Tolkien'),
('Discourseon Method and Metaphysical Meditations','Rene Descartes'),
('A concrete introduction to higher algebra','Lindsay Childs'),
('Abstract Algebra','John Fraleight')
Go
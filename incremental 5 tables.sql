create table watermark
(
id int identity(1,1),
tablename varchar(100),
schemaname varchar(100),
foldername varchar(100),
lpv varchar(100),
deltacolumn varchar(100)
)
select * from watermark

insert into watermark values('Students','dbo','dbo/Students',0,'Studentid')
insert into watermark values('Departments','dbo','dbo/Departments',0,'DepartmentID')
insert into watermark values('Courses','dbo','dbo/Courses','1900-01-01 00:00:00','courseupdate')
insert into watermark values('Enrollments','dbo','dbo/Enrollments','1900-01-01 00:00:00','enrollDate')
insert into watermark values('Professors','dbo','dbo/Professors','1900-01-01 00:00:00','joindatedate')
UPDATE watermark
SET deltacolumn = 'joindate'
WHERE deltacolumn = 'joindatedate'

--to get max value of all 5 tables
select max(Studentid) as maxvalue from Students
select max(DepartmentID) as maxvalue from Departments
select max(courseupdate) as maxvalue from Courses
select max(enrollDate) as maxvalue from Enrollments
select max(joindate) as maxvalue from Professors

create procedure watermark_update
@tablename varchar(100),
@lpv varchar(100)
as
update watermark
set lpv=@lpv
where tablename=@tablename





create table Students (
    studentid INT PRIMARY KEY,  -->deltacolumn
    name VARCHAR(100),
    email VARCHAR(100) unique,
	city varchar(100)
)
insert into Students values (1,'Abhi','xyz@gmail.com','tornto')
insert into Students values (2,'Joe','joe@gmail.com','texas')
insert into Students values (3,'Anna','anna@gmail.com','chicago')
insert into Students values (4,'Sam','sam@gmail.com','la')
insert into Students values (5,'Ken','ken@gmail.com','alberta')

select * from Students

create table Departments (
    DepartmentID INT PRIMARY KEY,  -->deltacolumn
    DepartmentName VARCHAR(100)
)
insert into Departments values (1,'ADE')
insert into Departments values (2,'CYS')
insert into Departments values (3,'ADA')
insert into Departments values (4,'ADE')
insert into Departments values (5,'AI')

select * from Departments

create table Courses (
    cid INT PRIMARY KEY,
    coursename VARCHAR(100),
	courseupdate datetime,    -->deltacolumn
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
)
UPDATE Courses 
SET cid = 4
WHERE cid = 5
insert into Courses values (1,'azure data engineer','2020-01-01 00:00:00',1)
insert into Courses values (2,'cyber security','2019-01-01 00:00:00',2)
insert into Courses values (3,'azure data analyst','2021-01-01 00:00:00',3)
insert into Courses values (4,'azure data engineer','2018-01-01 00:00:00',4)
insert into Courses values (5,'artificial intelligence','2024-01-01 00:00:00',5)
select * from Courses

CREATE TABLE Enrollments (
    enrollid INT PRIMARY KEY,
    studentid INT,
    cid INT,
    enrollDate datetime,    -->deltacolumn
    FOREIGN KEY (studentid) REFERENCES Students(studentid),
    FOREIGN KEY (cid) REFERENCES Courses(cid)
)

insert into Enrollments values (100,1,1,'2020-01-01 00:00:00')
insert into Enrollments values (101,2,2,'2019-01-01 00:00:00')
insert into Enrollments values (102,3,3,'2021-01-01 00:00:00')
insert into Enrollments values (103,4,4,'2018-01-01 00:00:00')
insert into Enrollments values (104,5,5,'2024-01-01 00:00:00')

select * from Enrollments

create table Professors (
    professorid INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    DepartmentID INT,
	joindate datetime,    -->deltacolumn
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
)

insert into Professors values (1001,'Emily','emily@gmail.com',1,'2017-01-01 00:00:00')
insert into Professors values (1002,'Sarah','sarah@gmail.com',3,'2023-01-01 00:00:00')
insert into Professors values (1003,'David','david@gmail.com',5,'2014-01-01 00:00:00')


select * from Students
select * from Courses
select * from Enrollments
select * from Departments
select * from Professors
select * from watermark

insert into Students values (6,'Robert','robert@gmail.com','la')
insert into Departments values (6,'AI')
insert into Courses values (6,'artificial intelligence','2025-02-28 00:00:00',6)
insert into Enrollments values (105,6,6,'2025-02-28 00:00:00')
insert into Professors values (1004,'Danish','danish@gmail.com',3,'2025-02-28 00:00:00')

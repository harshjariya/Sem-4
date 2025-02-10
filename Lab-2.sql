create database CSE_A_270
-- Create Department Table

CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

--Part – A
--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.

create  procedure pr_Department_ins
	@departmentID int , 
	@departmentName varchar(50)
AS

begin
	insert into Department values(
		@departmentID,
		@departmentName
		)
end

select * from Department

create or alter procedure pr_Designation_ins
		@DesignationID int , 
		@DesignationName varchar(100)
AS

begin
	insert into Designation values(
		@DesignationID  , 
		@DesignationName
		)
end

select * from Designation

create or alter procedure pr_Person_ins
		@FirstName VARCHAR(100) ,
		@LastName VARCHAR(100) ,
		@Salary DECIMAL(8, 2) ,
		@JoiningDate DATETIME,
		@DepartmentID INT ,
		@DesignationID INT 
AS

begin
	insert into Person values(
		@FirstName  ,
		@LastName ,
		@Salary  ,
		@JoiningDate,
		@DepartmentID  ,
		@DesignationID 
		)
end

select * from person

--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY
	
 

--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take
--columns on select list)
--4. Create a Procedure that shows details of the first 3 persons.

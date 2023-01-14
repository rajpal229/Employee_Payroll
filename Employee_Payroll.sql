-- UC1 Create database
create database Payroll_service; 

use Payroll_service;

-- UC2 Create table
Create table Employee_payroll(Id int primary key identity(1,1), Name varchar(200),Salary bigint, Startdate date);
Select * from Employee_payroll;
drop table Employee_payroll

-- UC3 insert into Employee_payroll (Date Pattern YYYY-MM-DD)

insert into Employee_payroll values ('Ram',30000,'2015-03-02');
insert into Employee_payroll values ('Shyam',25000,'2018-04-05');
insert into Employee_payroll values ('Kris',18000,'2020-01-01');
insert into Employee_payroll values ('Bella',20000,'2019-02-10');
insert into Employee_payroll values ('Bill',15000,'2019-02-10');

-- UC4 retrieve data from Employee_payroll

select * from Employee_payroll;

-- UC5 retrieve salary data as well as employees who have joined in a particular data range

select * from Employee_payroll where name = 'Kris';

select * from Employee_payroll where Startdate between CAST('2018-1-1' as date)and GETDATE();

-- UC6 adding more columns

alter table Employee_payroll add Gender varchar(10);
update Employee_payroll set Gender ='M' where Name ='Bill' or Name='Kris' or Name='Shyam' or Name='Ram';
update Employee_payroll set Gender ='F' where Name ='Bella';

select * from Employee_payroll

-- UC7 find sum, average, min, max and number of male and female employees

select SUM(Salary) as Empsalary from Employee_payroll;
select Min(Salary) as Minsalary from Employee_payroll;
select Max(Salary) as Maxsalary from Employee_payroll;
select avg(Salary) as avgsalary from Employee_payroll;
select count(id) as TotalMale from Employee_payroll where Gender='M' Group by Gender;
select count(id) as TotalFemale from Employee_payroll where Gender='F' Group by Gender;

-- UC8 extend employee_payroll data

alter table Employee_payroll add phone bigint;
alter table Employee_payroll add Emp_Address varchar(200) not null default 'Pune';
alter table Employee_payroll add Department varchar(200) not null default 'IT';

Select * from Employee_payroll;

alter table Employee_payroll add Empty_column char(1);
alter table Employee_payroll drop column Empty_column;

-- UC9 adding more columns

alter table Employee_payroll add Basic_Pay bigint;
alter table Employee_payroll add Deductions bigint;
alter table Employee_payroll add Taxable_Pay bigint;
alter table Employee_payroll add Income_Tax bigint;
alter table Employee_payroll add Net_Pay bigint;
Select * from Employee_payroll;

--uc10 adding tow more contact

insert into Employee_payroll values('Terissa', 25000, '2017-01-01', 'F', 9090909090, 'Mumbai', 'Sales', 25000 , 5000, 20000, 1000, 19000);
insert into Employee_payroll values('Terissa', 25000, '2017-01-01', 'F', 9090909090, 'Mumbai', 'Marketing', 25000 , 5000, 20000, 1000, 19000);
Select * from Employee_payroll where name= 'Terissa';


--uc11 Creating Multiple Tables for ER diagram

create table Employee(Employee_Id int,Department_ID int);
Select * from Employee;
drop table Company;
drop table Employee_payroll;

create table Company(CompanyID int primary key identity(1,1), CompanyName varchar(200));
insert into Company values('Reliance'),('Tata'),('Godrej'),('Birla');
select * from Company;

create table Employee(EmployeeID int primary key identity(1,1), CompanyID int, EmployeeName varchar(200), EmployeePhoneNumber bigInt, EmployeeAddress varchar(200),
StartDate date, Gender char, Foreign key (CompanyID) references Company(CompanyID));

insert into Employee values
(1, 'Bill', 9999999999,'Mumbai','2012-02-05','M'),
(3, 'Bella', 8888888888,'Pune','2016-04-10','F'),
(2, 'James', 7777777777,'Delhi','2014-06-15','M'),
(4, 'Susan', 6666666666,'Kanpur','2018-08-20','F'),
(2, 'Daniel', 5555555555, 'Dubai', '2020-10-25', 'M');

Select * from Employee;

create table Payroll (EmployeeID int, Foreign key (EmployeeID) references Employee(EmployeeID),BasicPay float, Deductions float, TaxablePay float, IncomeTax float, NetPay float);
Select * from Payroll;

insert into Payroll(EmployeeID, BasicPay, Deductions, TaxablePay, IncomeTax) values 
(1, 500000, 0, 500000, 0),
(2, 600000, 0, 600000, 5000),
(3, 700000, 100000, 600000, 5000),
(4, 1100000, 0, 1000000, 35000),
(5, 1100000, 100000, 1000000, 25000);

update Payroll set NetPay=TaxablePay-IncomeTax;

select * from Payroll;

create table Department (DepartmentID int primary key identity(1,1), DepartmentName varchar(100))
select * from Department;


insert into Department values ('Marketing'), ('Sales'), ('HR'), ('IT'), ('Management');

select * from Department

create table EmployeeDepartment( DepartmentID int , Foreign key (DepartmentID) references Department(DepartmentID), EmployeeID int, Foreign key (EmployeeID) references Employee(EmployeeID),)


insert into EmployeeDepartment values (1,1), (2,2), (3,3), (4,4), (5,5);

select * from EmployeeDepartment


Select * from Employee;
select * from Payroll;
select * from Department;
select * from EmployeeDepartment;

select * from Employee Emp
Left join Payroll Pr on Pr.EmployeeID=Emp.EmployeeId
where Startdate between CAST('2018-1-1' as date)and GETDATE();

select SUM(BasicPay) as Empsalary from Employee Emp
Left join Payroll Pr on Pr.EmployeeID=Emp.EmployeeId;

select MIN(BasicPay) as Minsalary from Employee Emp
Left join Payroll Pr on Pr.EmployeeID=Emp.EmployeeId;

select MAX(BasicPay) as Maxsalary from Employee Emp
Left join Payroll Pr on Pr.EmployeeID=Emp.EmployeeId;

select AVG(BasicPay) as Averagesalary from Employee Emp
Left join Payroll Pr on Pr.EmployeeID=Emp.EmployeeId;

select COUNT(EmployeeId) as TotalMale from Employee
where Gender = 'M' group by Gender;

select COUNT(EmployeeId) as TotalMale from Employee
where Gender = 'F' group by Gender;
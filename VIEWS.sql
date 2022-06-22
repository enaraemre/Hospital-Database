use Hospital
go


CREATE VIEW [Monthly_Income] AS
SELECT MONTH(Bill_Date) as Date, Sum(Amount) as Total_Income from Bill where MONTH(Bill_Date)=MONTH(GETDATE()) Group by MONTH(Bill_Date)
go

CREATE VIEW [Yearly_Income] AS
SELECT YEAR(Bill_Date) as Date, SUM(Amount)  as Total_Income from Bill where YEAR(Bill_Date)=YEAR(GETDATE()) Group by YEAR(Bill_Date)
go

CREATE VIEW[Patient_Information] AS
SELECT Patient.P_Name + ' ' + Patient.Surname as Patient_Name, Phone, Birthdate, Gender, Street + ', ' + Building + ', No:' + Flat + ', ' + Area + ', ' + City as Adress
FROM Patient JOIN P_Adress ON Patient.Id=P_Adress.Patient_Id
go

CREATE VIEW[Staff_Information] AS
SELECT Staff.S_Name + ' ' + Staff.Surname as Staff_Name, Phone, Birthdate, Gender,Salary,
Position,D_Name as Department,Street + ', ' + Building + ', No:' + Flat + ', ' + Area + ', ' + City as Adress from Staff 
 JOIN Department ON Staff.Dep_Id=Department.Id JOIN S_Adress ON Staff.Id=S_Adress.Staff_Id
go

CREATE VIEW [Monthly_Expenses] AS
SELECT Sum(Salary)  as Total_Salary from Staff
go

CREATE VIEW [Yearly_Expenses] AS
SELECT Sum(Salary)*12 as Total_Yearly_Salary from Staff
go
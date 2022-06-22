
use Hospital 
go


--Finds Treatment_Id of the patient if the patient in Hospital

CREATE FUNCTION Find_Pid (@Pid int)
RETURNS int AS
BEGIN
declare @Tid int
set @Tid = (select id from Treatment where Patient_Id=@Pid and Bed_Status='Yes')
    RETURN @Tid
END;
go


--Check Doctor Rezervation According to  id and if prefered date or today (if null)

CREATE PROCEDURE Doctor_Rezervation (@Id int,@date date)
AS
BEGIN TRY
BEGIN TRANSACTION
if @date is null 
begin
set @date=GETDATE()
end
Select P_Name + ' ' + Patient.Surname AS PatientName,R_Date,S_Name + ' ' + Staff.Surname as DoctorName from Patient Join Rezervation 
on Patient.Id=Rezervation.Patient_Id join Staff on Rezervation.Staff_Id=Staff.Id 
Where Rezervation.Staff_Id=@Id and R_Date=@date
COMMIT TRANSACTION
END TRY
BEGIN CATCH
if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
END CATCH
GO

exec Doctor_Rezervation @id=4,@date=null
go

--Treatment List of The Patient

CREATE PROCEDURE Patient_Treatment (@id int)
AS
BEGIN TRY
BEGIN TRANSACTION
Select Patient.P_Name + ' ' + Patient.Surname as Patient_Name,Treatment.Id as Treatment_Id,Illness,Explenation,Bed_Status,S_Date,Staff.S_Name + ' ' + Staff.Surname as Doctor_Name 
from Patient
Join Treatment on Patient.Id=Treatment.Patient_Id join Staff on Treatment.Staff_Id=Staff.Id where Patient.Id=@id
COMMIT TRANSACTION
END TRY
BEGIN CATCH
if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
END CATCH
GO

exec Patient_Treatment @id=1
go

--Bill list of the patient

CREATE PROCEDURE Patient_Bill (@id int)
AS
BEGIN TRY
BEGIN TRANSACTION
Select Patient.P_Name + ' ' + Patient.Surname as Patient_Name,Treatment.Id as Treatment_Id,Illness,Bill.Id,Amount,Deadline,Bill_Date as Invoice_Date
FROM Patient 
JOIN Treatment ON Patient.Id=Treatment.Patient_Id 
JOIN Bill ON Patient.Id=Bill.Patient_Id 
where Patient.Id=@id and Bill.Treatment_Id=Treatment.Id
COMMIT TRANSACTION
END TRY
BEGIN CATCH
if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
END CATCH
GO

exec Patient_Bill @id=2
go

--Profit by staff

CREATE PROCEDURE Profit_By_Doctor_Monthly (@id int,@month int)
AS
BEGIN TRY
BEGIN TRANSACTION
declare @totalincome int,@salary int
set @totalincome = (select Sum(Bill.Amount) from Bill Join Treatment ON Bill.Treatment_Id=Treatment.Id JOIN Staff ON Treatment.Staff_Id=Staff.Id 
where Staff.Id=@id and MONTH(Bill_Date)=@month)
set @salary = (select salary from Staff where Id=@id)
Select Staff.S_Name + ' ' + Staff.Surname as Doctor_Name, @totalincome as Total_Income, @salary as Expenses, @totalincome-@salary as Profit 
FROM Staff where id=@id
COMMIT TRANSACTION
END TRY
BEGIN CATCH
if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
END CATCH
GO

exec Profit_By_Doctor_Monthly @id=3,@month=5
go


--Find Bed of the patient by patient id

CREATE PROCEDURE Find_Bed (@id int)
AS
BEGIN TRY
BEGIN TRANSACTION
declare @Tid int
set @Tid = dbo.Find_Pid(@id)
Select Bed.Id,D_Name from Bed JOIN Department ON Bed.Dep_Id=Department.Id where Treatment_Id=@Tid 
COMMIT TRANSACTION
END TRY
BEGIN CATCH
if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
END CATCH
GO

exec Find_Bed @id=1
go
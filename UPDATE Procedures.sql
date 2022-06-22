--UPDATE PROCEDURES
use Hospital
go

--AFTER CHANGING BED STATUS IT UPDATES BED,DEPARTMENT,TREATMENT TABLE
CREATE PROCEDURE Change_Bed_Status @id int,@status varchar(50)
as
begin try
begin transaction 
if @status = 'Yes'
	begin
		declare @stafid int,@dep_id int,@avabed int 
		set @stafid = (Select Staff_Id from Treatment where Id=@id)
		set @dep_id= (Select distinct Dep_Id from Staff where Id=@stafid)
		set @avabed = (Select Bed from Department where Id=@dep_id)
	    if @avabed > 0
			begin
				declare @date date,@bed_id int
				set @date=GETDATE()
				set @bed_id= (select top 1 Id from Bed where Dep_Id=@dep_id and Treatment_Id IS NULL)
				update Bed set Treatment_Id=@id,Entry_Date=@date where Id=@bed_id
				update Department set Bed=(@avabed-1) where Id=@dep_id
			end
		else
			begin
				Select 'There is no available bed in the department, please consult your manager' as ERROR
				update Treatment set Bed_Status='Not Available Bed' where Id=@id
			end
	end
else
		begin
		declare @stafid2 int,@dep_id2 int,@avabed2 int 
		set @stafid2 = (Select Staff_Id from Treatment where Id=@id)
		set @dep_id2= (Select distinct Dep_Id from Staff where Id=@stafid2)
		set @avabed2 = (Select Bed from Department where Id=@dep_id2)
		update Bed set Treatment_Id=Null,Entry_Date=Null where Treatment_id=@id
		update Department set Bed=(@avabed2+1) where Id=@dep_id2
		update Treatment set Bed_Status='No' where Id=@id
		end
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go

exec Change_Bed_Status @id=62,@status='No'
go
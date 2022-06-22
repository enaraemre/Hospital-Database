--TRIGGERS

Use Hospital
go


--ADDING BED AUTOMATICALLY AFTER INSERTING DEPARTMENT

CREATE TRIGGER [Add_Bed_TR]
ON [Department]
AFTER INSERT 
AS BEGIN
begin try
begin transaction
declare @number int
declare @i int
set @i=1
declare @k int
Set @k=(select convert(int,(select current_value from sys.sequences where name = 'Dep_Seq')))
Set @number = (SELECT Bed from Department where Id=@k)
while @number >0 and @i<=@number
begin
insert into Bed values(next value for Bed_Seq,null,@k,null)
set @i=@i+1
end
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
end catch
END;

go

--WHEN WE CHOOSE 'YES' FOR BED STATUS, TRIGGER SET A BED FOR CURRENT TREATMENT AND UPDATE AVAILABLE BED NUMBER
--IF THERE IS NO AVAILABLE BED IT GIVES ERROR
CREATE TRIGGER [Set_Bed_To_Patient]
ON [Treatment]
AFTER INSERT
AS BEGIN
begin try
begin transaction
declare @bed varchar(50),@seqt int
set @seqt=(select convert(int,(select current_value from sys.sequences where name = 'Treatment_Seq'))) 
set @bed = (Select Bed_Status from Treatment where Id=@seqt)
if @bed = 'Yes'
	begin
		declare @stafid int,@dep_id int,@avabed int 
		set @stafid = (Select Staff_Id from Treatment where Id=@seqt)
		set @dep_id= (Select distinct Dep_Id from Staff where Id=@stafid)
		set @avabed = (Select Bed from Department where Id=@dep_id)
	    if @avabed > 0
			begin
				declare @date date,@bed_id int
				set @date=GETDATE()
				set @bed_id= (select top 1 Id from Bed where Dep_Id=@dep_id and Treatment_Id IS NULL)
				update Bed set Treatment_Id=@seqt,Entry_Date=@date where Id=@bed_id
				update Department set Bed=(@avabed-1) where Id=@dep_id
			end
		else
			begin
				Select 'There is no available bed in the department, please consult your manager' as ERROR
				update Treatment set Bed_Status='Not Available Bed' where Id=@seqt
			end
	end
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
end catch
END;

go


--List of people need to be quarentined
CREATE TRIGGER [Quarentined_Illness]
ON [Treatment]
AFTER INSERT,UPDATE 
AS BEGIN
begin try
begin transaction
declare @Tid int,@Building varchar(100),@Street varchar(200),@Area varchar(200),@City varchar(50),@Illness varchar(max),@Pid int
set @Tid=(select convert(int,(select current_value from sys.sequences where name = 'Treatment_Seq')))
set @Pid = (Select Treatment.Patient_Id from Treatment where Id=@Tid)
set @Illness = (select Illness + ' ' + Explenation from Treatment where Id=@Tid)
if @illness like '%corona%' or @Illness like '%quarentine%' or @Illness like '%quarentina%' or @Illness like '%covid%'
begin
set @Building = (select Building from P_Adress JOIN Treatment ON Treatment.Patient_Id=P_Adress.Patient_Id where P_Adress.Patient_Id=@Pid)
set @Street = (select Street from P_Adress JOIN Treatment ON P_Adress.Patient_Id= Treatment.Patient_Id where P_Adress.Patient_Id=@Pid)
set @Area = (select Area from P_Adress JOIN Treatment ON Treatment.Patient_Id=P_Adress.Patient_Id where P_Adress.Patient_Id=@Pid)
set @City = (select City from P_Adress JOIN Treatment ON Treatment.Patient_Id=P_Adress.Patient_Id where P_Adress.Patient_Id=@Pid)
Select P_Name + ' ' + Surname as Patient_Name,Phone from Patient JOIN P_Adress ON Patient.Id=P_Adress.Patient_Id
where City=@City and Area=@Area and Street=@Street and Building=@Building group by P_Name,Surname,Phone
end
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
end catch
END;

go





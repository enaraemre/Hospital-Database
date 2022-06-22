use Hospital
go

--INSERT PROCEDURES**

CREATE PROCEDURE insertDepartment @name varchar(150),@bed int
as
begin try
begin transaction 
   INSERT INTO Department VALUES (next value for Dep_Seq,@name,@bed)
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go


Create PROCEDURE insertStaff @Dep_Id int,@Name varchar(200),@SName varchar(100),@Phone varchar(20),@BDate date,@Gender varchar(20),@Salary bigint,@Position varchar(100)
as
begin try
begin transaction 
   INSERT INTO Staff VALUES (next value for Staff_Seq,@Dep_Id,@Name,@SName,@Phone,@BDate,@Gender,@Salary,@Position)
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go



CREATE PROCEDURE insertPatient @Name varchar(200),@SName varchar(100),@Phone varchar(20),@BDate date,@Gender varchar(15)
as
begin try
begin transaction 
   INSERT INTO Patient VALUES (next value for Patient_Seq,@Name,@SName,@Phone,@BDate,@Gender)
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go



CREATE PROCEDURE insertPAdress @Id int,@Area varchar(200),@Street varchar(200),@Building varchar(100),@Flat varchar(50),@City varchar(50)
as
begin try
begin transaction 
   INSERT INTO P_Adress VALUES (next value for Pad_Seq,@Id,@Area,@Street,@Building,@Flat,@City)
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go



CREATE PROCEDURE insertSAdress @Id int,@Area varchar(200),@Street varchar(200),@Building varchar(100),@Flat varchar(50),@City varchar(50)
as
begin try
begin transaction 
   INSERT INTO S_Adress VALUES (next value for Sad_Seq,@Id,@Area,@Street,@Building,@Flat,@City)
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go



CREATE PROCEDURE insertRez @id1 int,@id2 int,@date Date
as
begin try

begin transaction 
   INSERT INTO Rezervation VALUES (next value for Rez_Seq,@id1,@id2,@date)
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go




CREATE PROCEDURE insertTreatment @id1 int,@id2 int,@Ill varchar(200),@Exp varchar(max),@Bed varchar(50)
as
begin try
begin transaction 
	declare @Date date,@id3 int
	set @Date = GETDATE()
	set @id3=null
    INSERT INTO Treatment VALUES (next value for Treatment_Seq,@id1,@id2,@id3,@Ill,@Exp,@Date,@Bed)
commit transaction
end try
begin catch
 if @@TRANCOUNT>0 rollback
 Select error_number() as ErrorNumber, Error_Message() as ErrprMessage;
end catch

go




CREATE PROCEDURE AddBill @Tid int,@Deadline date,@Amount bigint
as
begin try
begin transaction 
    declare @Date date,@Pid int,@BedStatus varchar(50)
	set @Date = GETDATE()
	set @Pid = (Select Patient_Id from Treatment where Id=@Tid)
	set @BedStatus= (Select Bed_Status from Treatment where Id=@Tid)
	INSERT INTO Bill VALUES (next value for Bill_Seq,@Tid,@Pid,@Date,@Deadline,@Amount)
	update Treatment set Bill_Id = (select Id from Bill where Treatment_Id=@Tid) where Id=@Tid
	if @BedStatus='Yes'
	begin
	exec Change_Bed_Status @id=Tid,@status='No'
	end
	
commit transaction
end try
begin catch
  if @@TRANCOUNT>0 rollback
  Select error_number() as ErrorNumber, Error_Message() as ErrorMessage;
end catch

go




--DEPARTMENT TABLE

exec insertDepartment @name= 'Menagement', @bed=0
exec insertDepartment @name= 'Dermatology', @bed=3
exec insertDepartment @name= 'Cardiology', @bed=10
exec insertDepartment @name= 'Otorhinolaryngology', @bed=15
exec insertDepartment @name= 'Neurology', @bed=20
exec insertDepartment @name= 'Orthopaedics', @bed=25
exec insertDepartment @name= 'Gynecology', @bed=30
exec insertDepartment @name= 'Other Staff', @bed=0
exec insertDepartment @name= 'Anesthesy', @bed=4
exec insertDepartment @name= 'Gastroenterology', @bed=6
exec insertDepartment @name= 'Ophthalmology', @bed=2
go



--STAFF TABLE

exec insertStaff @Dep_Id=1,@Name='Jack',@SName='Daniels',@Phone='905369604889',@BDate='1993-04-04',@Gender='Male',@Salary=10000,@Position='Manager'
exec insertStaff @Dep_Id=2,@Name='Ali',@SName='Mercedes',@Phone='905324589654',@BDate='1985-04-25',@Gender='Male',@Salary=3500,@Position=NULL
exec insertStaff @Dep_Id=3,@Name='Mehmet',@SName='Oz',@Phone='904567852354',@BDate='1980-02-15',@Gender='Male',@Salary=4000,@Position='Doctor'
exec insertStaff @Dep_Id=4,@Name='Feraye',@SName='Sahin',@Phone='905484589654',@BDate='1990-09-13',@Gender='Female',@Salary=3000,@Position='Nurse'
exec insertStaff @Dep_Id=7,@Name='Nicole',@SName='Nice',@Phone='905484589654',@BDate='1990-09-07',@Gender='Female',@Salary=10000,@Position='Gynecolog'
exec insertStaff @Dep_Id=5,@Name='Kelly',@SName='Chaddy',@Phone='905484589654',@BDate='1990-09-10',@Gender='Female',@Salary=9000,@Position='Doctor'
exec insertStaff @Dep_Id=1,@Name='Bercy',@SName='Angel',@Phone='905484589654',@BDate='1990-09-03',@Gender='Female',@Salary=10000,@Position='Manager'
exec insertStaff @Dep_Id=8,@Name='Amber',@SName='Heard',@Phone='905484589654',@BDate='1990-09-23',@Gender='Female',@Salary=1000,@Position='Cleaner'
exec insertStaff @Dep_Id=3,@Name='Yigit',@SName='Korkmaz',@Phone='905484589654',@BDate='1990-07-12',@Gender='Male',@Salary=8000,@Position='Cardiolog'
exec insertStaff @Dep_Id=6,@Name='Jesus',@SName='Mary',@Phone='905484589654',@BDate='1990-04-08',@Gender='Male',@Salary=12000,@Position='Neurolog'
exec insertStaff @Dep_Id=8,@Name='Judicael',@SName='Sam',@Phone='905484589654',@BDate='1990-02-07',@Gender='Male',@Salary=15000,@Position='Orthopaedic'
exec insertStaff @Dep_Id=8,@Name='Jonny',@SName='Depp',@Phone='905484589654',@BDate='1990-09-13',@Gender='Male',@Salary=3000,@Position='Recepcionist'
exec insertStaff @Dep_Id=9,@Name='Burcum',@SName='Sanane',@Phone='48543765987',@BDate='1973-08-25',@Gender='Female',@Salary=8000,@Position='DeptManager'
exec insertStaff @Dep_Id=10,@Name='Hangar',@SName='Onsekiz',@Phone='905354122654',@BDate='1967-04-15',@Gender='Male',@Salary=8000,@Position='DeptManager'
exec insertStaff @Dep_Id=11,@Name='Marul',@SName='Salata',@Phone='90122212354',@BDate='1969-12-30',@Gender='Male',@Salary=8000,@Position='DeptManager'
exec insertStaff @Dep_Id=9,@Name='Gulnihal',@SName='Korkmaz',@Phone='905484326654',@BDate='1990-09-13',@Gender='Female',@Salary=3000,@Position='Nurse'
exec insertStaff @Dep_Id=10,@Name='Burcum',@SName='Sanane',@Phone='48543765987',@BDate='1973-03-25',@Gender='Female',@Salary=3000,@Position='Nurse'
exec insertStaff @Dep_Id=11,@Name='Ali Ekber',@SName='Hardun',@Phone='904433319654',@BDate='1975-12-05',@Gender='Male',@Salary=3000,@Position='Nurse'
exec insertStaff @Dep_Id=9,@Name='Suheyl',@SName='Bahce',@Phone='904567121254',@BDate='1983-12-23',@Gender='Male',@Salary=4000,@Position='Doctor'
exec insertStaff @Dep_Id=10,@Name='Uzum',@SName='Pekmezi',@Phone='905484589554',@BDate='1991-11-13',@Gender='Female',@Salary=4000,@Position='Doctor'
exec insertStaff @Dep_Id=11,@Name='Meyve',@SName='Severim',@Phone='48333765987',@BDate='1973-03-29',@Gender='Female',@Salary=4000,@Position='Doctor'
exec insertStaff @Dep_Id=8,@Name='Kardes',@SName='Gelsin',@Phone='905324123654',@BDate='1985-04-11',@Gender='Male',@Salary=3500,@Position='Cleaner'
go


--PATIENT TABLE
exec insertPatient @Name='Yigit',@SName='Korkmaz',@Phone='48731505203',@BDate='1989-05-05',@Gender='Male'
exec insertPatient @Name='Nice',@SName='Nicole',@Phone='48731564987',@BDate='1997-07-07',@Gender='Female'
exec insertPatient @Name='Mehmet Emre',@SName='Pelte',@Phone='48731564234',@BDate='1993-04-04',@Gender='Male'
exec insertPatient @Name='Jason',@SName='Momoa',@Phone='48731564234',@BDate='1970-04-04',@Gender='Male'
exec insertPatient @Name='Kevin',@SName='Hart',@Phone='48731564234',@BDate='1982-04-04',@Gender='Male'
exec insertPatient @Name='Jennifer',@SName='Garner',@Phone='48731564234',@BDate='1974-04-04',@Gender='Female'
exec insertPatient @Name='Elen',@SName='Show',@Phone='48731564234',@BDate='1969-04-04',@Gender='Female'
exec insertPatient @Name='Will',@SName='Smith',@Phone='48731564234',@BDate='1967-04-04',@Gender='Male'
exec insertPatient @Name='Arsene',@SName='Nduwayo',@Phone='48731564234',@BDate='1995-04-04',@Gender='Male'
exec insertPatient @Name='Angelina',@SName='Jolie',@Phone='48731564234',@BDate='1972-04-04',@Gender='Female'
exec insertPatient @Name='Serena',@SName='William',@Phone='48731564234',@BDate='1998-04-04',@Gender='Female'
exec insertPatient @Name='Justin',@SName='Bieber',@Phone='48731564234',@BDate='1997-04-04',@Gender='Male'
exec insertPatient @Name='Arnold',@SName='Shw',@Phone='48731564234',@BDate='1953-04-04',@Gender='Male'
exec insertPatient @Name='Barack',@SName='Obama',@Phone='48731564234',@BDate='1968-04-04',@Gender='Male'
exec insertPatient @Name='Taylor',@SName='Swift',@Phone='48731564234',@BDate='1998-04-04',@Gender='Female'
exec insertPatient @Name='Caroy',@SName='Taylor the king',@Phone='48731564234',@BDate='1996-04-04',@Gender='Male'
exec insertPatient @Name='Lukasz',@SName='Pawel',@Phone='48731564234',@BDate='1992-04-04',@Gender='Male'
exec insertPatient @Name='Mateusz',@SName='Adam',@Phone='48731564234',@BDate='1990-05-07',@Gender='Male'
exec insertPatient @Name='Benhur',@SName='Sikyorgan',@Phone='4822115203',@BDate='1989-05-05',@Gender='Male'
exec insertPatient @Name='Arslan',@SName='Parcasi',@Phone='48744666987',@BDate='1995-07-07',@Gender='Female'
exec insertPatient @Name='Orhan',@SName='Nahor',@Phone='48721211234',@BDate='1993-04-04',@Gender='Male'
exec insertPatient @Name='Selcuk',@SName='Oral',@Phone='48123134322',@BDate='1979-02-11',@Gender='Male, '
exec insertPatient @Name='Berdan',@SName='Mardini',@Phone='485554213766',@BDate='1988-09-12',@Gender='Male'
exec insertPatient @Name='Kerem',@SName='Alisik',@Phone='48724464234',@BDate='1983-04-22',@Gender='Female'
exec insertPatient @Name='Ayan',@SName='Beyan',@Phone='4822115209',@BDate='1955-08-12',@Gender='Male'
exec insertPatient @Name='Mehteran',@SName='Takimi',@Phone='48744666987',@BDate='1959-06-19',@Gender='Female'
exec insertPatient @Name='Azveren',@SName='Maldan',@Phone='48721211234',@BDate='1973-05-04',@Gender='Male'
exec insertPatient @Name='Steve',@SName='Buscemi',@Phone='48111223322',@BDate='1969-02-11',@Gender='Male'
exec insertPatient @Name='Mike',@SName='Portnoy',@Phone='485555223766',@BDate='1978-11-12',@Gender='Male'
exec insertPatient @Name='Iste',@SName='Budur',@Phone='48724227734',@BDate='1963-04-22',@Gender='Female'
exec insertPatient @Name='Denizve',@SName='Gunes',@Phone='4846815203',@BDate='1996-05-05',@Gender='Male'
exec insertPatient @Name='John',@SName='Doe',@Phone='48744126987',@BDate='1945-07-07',@Gender='Female'
exec insertPatient @Name='Beskere',@SName='Bes',@Phone='48723331234',@BDate='2003-04-14',@Gender='Male'
go


--PATIENT ADRESS

exec insertPAdress @Id=1,@Area='Lumumbowo-Miasteczko Akademickie',@Street='Tamka',@Building='4',@Flat='40',@City='Lodz'
exec insertPAdress @Id=2,@Area='Central Business Axis',@Street='Jana Matejki',@Building='Dormitory',@Flat='250',@City='Lodz'
exec insertPAdress @Id=3,@Area='Srodmiscie',@Street='Narutowicza',@Building='79',@Flat='23',@City='Lodz'
exec insertPAdress @Id=4,@Area='zgierz',@Street='Dluga',@Building='09',@Flat='23',@City='Lodz'
exec insertPAdress @Id=5,@Area='zgierz',@Street='Dluga',@Building='09',@Flat='23',@City='Lodz'
exec insertPAdress @Id=6,@Area='zgierz',@Street='Dluga',@Building='09',@Flat='23',@City='Lodz'
exec insertPAdress @Id=7,@Area='Rabien',@Street='Ananasowa',@Building='17',@Flat='10',@City='Lodz'
exec insertPAdress @Id=8,@Area='Rabien',@Street='Ananasowa',@Building='17',@Flat='10',@City='Lodz'
exec insertPAdress @Id=9,@Area='Rabien',@Street='Ananasowa',@Building='17',@Flat='10',@City='Lodz'
exec insertPAdress @Id=10,@Area='blablabla',@Street='laplap',@Building='79',@Flat='23',@City='Lodz'
exec insertPAdress @Id=11,@Area='hehehe',@Street='jajaja',@Building='79',@Flat='23',@City='Lodz'
exec insertPAdress @Id=12,@Area='freedom',@Street='zone',@Building='79',@Flat='23',@City='Lodz'
exec insertPAdress @Id=13,@Area='Dolna',@Street='flower',@Building='79',@Flat='23',@City='Lodz'
exec insertPAdress @Id=14,@Area='Baluty',@Street='Sikerce',@Building='113',@Flat='2',@City='Lodz'
exec insertPAdress @Id=15,@Area='Baluty',@Street='Sikerce',@Building='113',@Flat='2',@City='Lodz'
exec insertPAdress @Id=16,@Area='Baluty',@Street='Sikerce',@Building='113',@Flat='2',@City='Lodz'
exec insertPAdress @Id=17,@Area='Widzew',@Street='Mierda',@Building='83',@Flat='21',@City='Lodz'
exec insertPAdress @Id=18,@Area='Widzew',@Street='Mierda',@Building='83',@Flat='21',@City='Lodz'
exec insertPAdress @Id=19,@Area='Widzew',@Street='Mierda',@Building='83',@Flat='21',@City='Lodz'
exec insertPAdress @Id=20,@Area='Srodmiscie',@Street='Tramwajowa',@Building='59',@Flat='33',@City='Lodz'
exec insertPAdress @Id=21,@Area='Srodmiscie',@Street='Tramwajowa',@Building='59',@Flat='33',@City='Lodz'
exec insertPAdress @Id=22,@Area='Srodmiscie',@Street='Tramwajowa',@Building='59',@Flat='33',@City='Lodz'
exec insertPAdress @Id=23,@Area='Srodmiscie',@Street='Wierzbowa',@Building='47',@Flat='05',@City='Lodz'
exec insertPAdress @Id=24,@Area='Srodmiscie',@Street='Wierzbowa',@Building='47',@Flat='05',@City='Lodz'
exec insertPAdress @Id=25,@Area='Srodmiscie',@Street='Wierzbowa',@Building='47',@Flat='05',@City='Lodz'
exec insertPAdress @Id=26,@Area='Retkinia',@Street='Janusza Kusocińskiego',@Building='117',@Flat='09',@City='Lodz'
exec insertPAdress @Id=27,@Area='Retkinia',@Street='Janusza Kusocińskiego',@Building='117',@Flat='09',@City='Lodz'
exec insertPAdress @Id=28,@Area='Retkinia',@Street='Janusza Kusocińskiego',@Building='117',@Flat='09',@City='Lodz'
exec insertPAdress @Id=29,@Area='Konstantynów Łódzki',@Street='Parkowa',@Building='24',@Flat='01',@City='Lodz'
exec insertPAdress @Id=30,@Area='Konstantynów Łódzki',@Street='Parkowa',@Building='24',@Flat='01',@City='Lodz'
exec insertPAdress @Id=31,@Area='Konstantynów Łódzki',@Street='Parkowa',@Building='24',@Flat='01',@City='Lodz'
exec insertPAdress @Id=32,@Area='Konstantynów Łódzki',@Street='Parkowa',@Building='24',@Flat='01',@City='Lodz'
exec insertPAdress @Id=33,@Area='Ankaranin',@Street='Dikmeni',@Building='69',@Flat='31',@City='Ankara'
go


--STAFF ADRESS
exec insertSAdress @Id=1,@Area='Lumumbowo-Miasteczko Akademickie',@Street='Tamka',@Building='4',@Flat='40',@City='Lodz'
exec insertSAdress @Id=2,@Area='Central Business Axis',@Street='Jana Matejki',@Building='Dormitory',@Flat='250',@City='Lodz'
exec insertSAdress @Id=3,@Area='Srodmiscie',@Street='Narutowicza',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=4,@Area='sfgh',@Street='dtf',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=5,@Area='estrygh',@Street='rtdy',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=6,@Area='nm,',@Street='dfgh',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=7,@Area='rtdyhj',@Street='dxfgch',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=8,@Area='fcvgbn',@Street='fxgvb',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=9,@Area='tfgyvhk',@Street='fghn',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=10,@Area='fxcvgb',@Street='dfxgn',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=11,@Area='rtyu',@Street='zdfgnm,',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=12,@Area='zsdxf',@Street='sdxfcv',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=13,@Area='rfg',@Street='dfgh',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=14,@Area='Deus',@Street='Ex',@Building='19',@Flat='33',@City='Lodz'
exec insertSAdress @Id=15,@Area='Long',@Street='Island',@Building='39',@Flat='23',@City='Lodz'
exec insertSAdress @Id=16,@Area='Nereden',@Street='Nereye',@Building='79',@Flat='23',@City='Lodz'
exec insertSAdress @Id=17,@Area='Geldi',@Street='Turkiye',@Building='79',@Flat='13',@City='Lodz'
exec insertSAdress @Id=18,@Area='Yarrani',@Street='Degil',@Building='22',@Flat='23',@City='Lodz'
exec insertSAdress @Id=19,@Area='Yareni',@Street='Bulmak',@Building='53',@Flat='53',@City='Lodz'
exec insertSAdress @Id=20,@Area='Isik',@Street='Hizinda',@Building='119',@Flat='11',@City='Lodz'
exec insertSAdress @Id=21,@Area='aklsdm',@Street='eqwe,',@Building='49',@Flat='2',@City='Lodz'
exec insertSAdress @Id=22,@Area='mera',@Street='bufor',@Building='17',@Flat='4',@City='Lodz'
go



--REZERVATION

exec insertRez @id1=2,@id2=1,@date='2022-05-25'
exec insertRez @id1=3,@id2=2,@date='2022-05-26'
exec insertRez @id1=4,@id2=3,@date='2022-05-23'
exec insertRez @id1=5,@id2=5,@date='2023-05-25'
exec insertRez @id1=9,@id2=6,@date='2022-05-26'
exec insertRez @id1=11,@id2=7,@date='2023-05-25'
exec insertRez @id1=2,@id2=8,@date='2022-05-25'
exec insertRez @id1=6,@id2=9,@date='2022-05-26'
exec insertRez @id1=11,@id2=10,@date='2022-05-23'
exec insertRez @id1=5,@id2=11,@date='2022-05-23'
exec insertRez @id1=2,@id2=12,@date='2022-05-26'
exec insertRez @id1=4,@id2=13,@date='2022-05-23'
exec insertRez @id1=4,@id2=14,@date='2023-05-23'
exec insertRez @id1=9,@id2=15,@date='2022-06-26'
exec insertRez @id1=10,@id2=16,@date='2022-05-25'
exec insertRez @id1=6,@id2=17,@date='2022-06-25'
exec insertRez @id1=3,@id2=18,@date='2022-05-23'
exec insertRez @id1=11,@id2=19,@date='2022-06-25'
exec insertRez @id1=20,@id2=19,@date='2022-05-22'
exec insertRez @id1=20,@id2=20,@date='2022-05-22'
exec insertRez @id1=20,@id2=21,@date='2022-05-22'
exec insertRez @id1=21,@id2=22,@date='2022-05-22'
exec insertRez @id1=21,@id2=23,@date='2022-05-22'
exec insertRez @id1=21,@id2=24,@date='2022-05-29'
exec insertRez @id1=22,@id2=25,@date='2022-05-29'
exec insertRez @id1=22,@id2=26,@date='2022-05-29'
exec insertRez @id1=22,@id2=27,@date='2022-05-29'
exec insertRez @id1=20,@id2=28,@date='2022-05-29'
exec insertRez @id1=20,@id2=29,@date='2022-06-22'
exec insertRez @id1=21,@id2=30,@date='2022-06-22'
exec insertRez @id1=21,@id2=31,@date='2022-06-22'
exec insertRez @id1=22,@id2=32,@date='2023-03-23'
exec insertRez @id1=22,@id2=33,@date='2023-02-25'
go


--TREATMENT

exec insertTreatment @id1=2,@id2=1,@Ill='Apse',@Exp='There is an apse between eyes on the nose, need medication and stays in hospital',@Bed='No'
exec insertTreatment @id1=3,@id2=2,@Ill='Stenocardia',@Exp='Without a reason she has stenocardia, given medication and will check next week same hours.',@Bed='No'
exec insertTreatment @id1=4,@id2=4,@Ill='Covid',@Exp='Covid Test is positive, home quarentine, no hard symtoms',@Bed='No'
exec insertTreatment @id1=4,@id2=14,@Ill='Flu',@Exp='Allergy, Antibiotics given adn offered rest in home',@Bed='No'
exec insertTreatment @id1=11,@id2=10,@Ill='Heart Surgeon',@Exp='successfull surgeon',@Bed='Yes'
exec insertTreatment @id1=5,@id2=11,@Ill='Broken Leg',@Exp='Fixed',@Bed='No'
exec insertTreatment @id1=4,@id2=9,@Ill='Corona',@Exp='Covid Test is positive, home quarentine, no hard symtoms',@Bed='No'
exec insertTreatment @id1=3,@id2=18,@Ill='Birth',@Exp='Normal born accured',@Bed='Yes'
exec insertTreatment @id1=20,@id2=19,@Ill='Broken Heart',@Exp='Bad case of friendzone',@Bed='No'
exec insertTreatment @id1=20,@id2=20,@Ill='Crazy',@Exp='Bashing head to walls',@Bed='Yes'
exec insertTreatment @id1=20,@id2=21,@Ill='Covid',@Exp='Covid Test is positive, quarentine needed, hard symtoms',@Bed='Yes'
exec insertTreatment @id1=21,@id2=22,@Ill='Migraine',@Exp='Constant headache',@Bed='No'
exec insertTreatment @id1=21,@id2=10,@Ill='Diarhea',@Exp='Patient admitted he ate kebab, obvioso',@Bed='Yes'
exec insertTreatment @id1=5,@id2=11,@Ill='Alcohol Poisoning',@Exp='Mixed vodka and wine, patient did not know any better',@Bed='Yes'
exec insertTreatment @id1=4,@id2=9,@Ill='Cant lick his elbow',@Exp='Arm restructured to meet the patients needs',@Bed='No'
exec insertTreatment @id1=3,@id2=18,@Ill='Birth',@Exp='Baby flow out of window, mom needs to cool down',@Bed='Yes'

go

-- 2 bills for the treatments
--@tid is treatment id
--BILL according to Treatment ID

exec AddBill @Tid=1,@Deadline=null,@Amount=2000
exec AddBill @Tid=5,@Deadline=null,@Amount=10000
exec AddBill @Tid=4,@Deadline=null,@Amount=500
exec AddBill @Tid=9,@Deadline=null,@Amount=999
exec AddBill @Tid=12,@Deadline=null,@Amount=300
go
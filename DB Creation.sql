
use Hospital
go


CREATE TABLE Bed 
    (
     Id INTEGER NOT NULL, 
	 Treatment_Id INTEGER, 
     Dep_Id INTEGER , 
     Entry_Date DATE 
    )
GO 
   

ALTER TABLE Bed ADD CONSTRAINT Bed_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE SEQUENCE Bed_Seq
start with 1
increment by 1
go



CREATE TABLE Bill
    (
     Id INTEGER NOT NULL, 
     Treatment_Id INTEGER NOT NULL,
	 Patient_Id INTEGER NOT NULL,
     Bill_Date DATE NOT NULL , 
     Deadline DATE , 
     Amount BIGINT NOT NULL 
    )
GO

ALTER TABLE Bill ADD CONSTRAINT Bill_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE NONCLUSTERED INDEX 
    Bill_Treatment_IDX ON Bill
    ( 
     Treatment_Id 
    ) 
GO

CREATE NONCLUSTERED INDEX 
    Bill_Patient_IDX ON Bill
    ( 
     Patient_Id 
    ) 
GO

CREATE SEQUENCE Bill_Seq
start with 1
increment by 1
go



CREATE TABLE Department 
    (
     Id INTEGER NOT NULL, 
     D_Name VARCHAR (150) NOT NULL , 
     Bed INTEGER 
    )
GO

ALTER TABLE Department ADD CONSTRAINT Department_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE SEQUENCE Dep_Seq
start with 1
increment by 1
go




CREATE TABLE P_Adress 
    (
     Id INTEGER NOT NULL, 
     Patient_Id INTEGER NOT NULL , 
     Area VARCHAR (200) NOT NULL , 
     Street VARCHAR (200) , 
     Building VARCHAR (100) , 
     Flat VARCHAR (50) , 
     City VARCHAR (50) 
    )
GO 

    CREATE NONCLUSTERED INDEX 
    P_Adress_Area_IDX ON P_Adress 
    ( 
     Area 
    ) 
GO

CREATE NONCLUSTERED INDEX 
    P_Adress__IDX ON P_Adress 
    ( 
     Patient_Id 
    ) 
GO

ALTER TABLE P_Adress ADD CONSTRAINT P_Adress_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE SEQUENCE Pad_Seq
start with 1
increment by 1
go





CREATE TABLE Patient 
    (
     Id INTEGER NOT NULL, 
     P_Name VARCHAR (200) NOT NULL , 
     Surname VARCHAR (100) NOT NULL , 
     Phone VARCHAR (20) NOT NULL , 
     Birthdate DATE , 
     Gender VARCHAR (15) 
    )
GO

ALTER TABLE Patient ADD CONSTRAINT Patient_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE SEQUENCE Patient_Seq
start with 1
increment by 1
go




CREATE TABLE Rezervation 
    (
     Id INTEGER NOT NULL, 
     Staff_Id INTEGER NOT NULL , 
     Patient_Id INTEGER NOT NULL , 
     R_Date DATETIME NOT NULL 
    )
GO

ALTER TABLE Rezervation ADD CONSTRAINT Rezervation_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE NONCLUSTERED INDEX 
    Rezervation_Staff__IDX ON Rezervation 
    ( 
     Staff_Id 
    ) 
GO

CREATE NONCLUSTERED INDEX 
    Rezervation_Patient__IDX ON Rezervation 
    ( 
     Patient_Id 
    ) 
GO

CREATE NONCLUSTERED INDEX 
    Rezervation_Date__IDX ON Rezervation 
    ( 
     R_Date 
    ) 
GO

CREATE SEQUENCE Rez_Seq
start with 1
increment by 1
go



CREATE TABLE S_Adress 
    (
     Id INTEGER NOT NULL, 
     Staff_Id INTEGER NOT NULL , 
     Area VARCHAR (200) NOT NULL , 
     Street VARCHAR (200) , 
     Building VARCHAR (100) , 
     Flat VARCHAR (50) , 
     City VARCHAR (50) 
    )
GO 


CREATE NONCLUSTERED INDEX 
    S_Adress__IDX ON S_Adress 
    ( 
     Staff_Id 
    ) 
GO

ALTER TABLE S_Adress ADD CONSTRAINT S_Adress_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE SEQUENCE Sad_Seq
start with 1
increment by 1
go



CREATE TABLE Staff 
    (
     Id INTEGER NOT NULL, 
     Dep_Id INTEGER NOT NULL , 
     S_Name VARCHAR (200) NOT NULL , 
     Surname VARCHAR (100) NOT NULL , 
     Phone VARCHAR (20) NOT NULL , 
     Birthdate DATE , 
     Gender VARCHAR (20) , 
     Salary BIGINT ,
	 Position VARCHAR(100)
    )
GO

ALTER TABLE Staff ADD CONSTRAINT Staff_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE NONCLUSTERED INDEX 
    S_Dep__IDX ON Staff 
    ( 
     Dep_Id 
    ) 
GO

CREATE SEQUENCE Staff_Seq
start with 1
increment by 1
go




CREATE TABLE Treatment 
    (
     Id INTEGER NOT NULL, 
     Staff_Id INTEGER NOT NULL , 
     Patient_Id INTEGER NOT NULL , 
     Bill_Id INTEGER , 
     Illness VARCHAR (200) NOT NULL , 
     Explenation VARCHAR (max) , 
     S_Date DATE NOT NULL ,
	 Bed_Status varchar(50)
    )
GO 

CREATE NONCLUSTERED INDEX 
    Treatment_Staff__IDX ON Treatment 
    ( 
     Staff_Id 
    ) 
GO

CREATE NONCLUSTERED INDEX 
    Treatment_Patient_IDX ON Treatment 
    ( 
     Patient_Id 
    ) 
GO



ALTER TABLE Treatment ADD CONSTRAINT Treatment_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE SEQUENCE Treatment_Seq
start with 1
increment by 1
go




ALTER TABLE Bed 
    ADD CONSTRAINT Bed_Department_FK FOREIGN KEY 
    ( 
     Dep_Id
    ) 
    REFERENCES Department 
    ( 
     Id 
    ) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE 
GO

ALTER TABLE Bed 
    ADD CONSTRAINT Bed_Treatment_FK FOREIGN KEY 
    ( 
     Treatment_Id
    ) 
    REFERENCES Treatment 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Bill
    ADD CONSTRAINT Bill_Patient_FK FOREIGN KEY 
    ( 
     Patient_Id
    ) 
    REFERENCES Patient 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE CASCADE 
GO

ALTER TABLE Bill
    ADD CONSTRAINT _Bill_Treatment_FK FOREIGN KEY 
    ( 
     Treatment_Id
    ) 
    REFERENCES Treatment 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE P_Adress 
    ADD CONSTRAINT P_Adress_Patient_FK FOREIGN KEY 
    ( 
     Patient_Id
    ) 
    REFERENCES Patient 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Rezervation 
    ADD CONSTRAINT Rezervation_Patient_FK FOREIGN KEY 
    ( 
     Patient_Id
    ) 
    REFERENCES Patient 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Rezervation 
    ADD CONSTRAINT Rezervation_Staff_FK FOREIGN KEY 
    ( 
     Staff_Id
    ) 
    REFERENCES Staff 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE CASCADE 
GO

ALTER TABLE S_Adress 
    ADD CONSTRAINT S_Adress_Staff_FK FOREIGN KEY 
    ( 
     Staff_Id
    ) 
    REFERENCES Staff 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE CASCADE 
GO

ALTER TABLE Staff 
    ADD CONSTRAINT Staff_Department_FK FOREIGN KEY 
    ( 
     Dep_Id
    ) 
    REFERENCES Department 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE CASCADE 
GO

ALTER TABLE Treatment 
    ADD CONSTRAINT Treatment_Bill_FK FOREIGN KEY 
    ( 
     Bill_id
    ) 
    REFERENCES Bill 
    ( 
     Id 
    ) 
    ON DELETE SET NULL
    ON UPDATE CASCADE 
GO

ALTER TABLE Treatment 
    ADD CONSTRAINT T_Patient_FK FOREIGN KEY 
    ( 
     Patient_Id
    ) 
    REFERENCES Patient 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Treatment 
    ADD CONSTRAINT T_Staff_FK FOREIGN KEY 
    ( 
     Staff_Id
    ) 
    REFERENCES Staff 
    ( 
     Id 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION
GO



ALTER TABLE S_Adress
	ADD CONSTRAINT UQ_StaffAddress UNIQUE (id)
GO

ALTER TABLE Treatment
	ADD CONSTRAINT UQ_Treatment UNIQUE (id)
GO

ALTER TABLE Staff
	ADD CONSTRAINT UQ_Staff UNIQUE (id)
GO

ALTER TABLE Rezervation
	ADD CONSTRAINT UQ_Rezervation UNIQUE (id)
GO

ALTER TABLE Patient
	ADD CONSTRAINT UQ_Patient UNIQUE (id)
GO

ALTER TABLE P_Adress
	ADD CONSTRAINT UQ_PatientAdress UNIQUE (id)
GO

ALTER TABLE Department
	ADD CONSTRAINT UQ_Department UNIQUE (id)
GO

ALTER TABLE Bill
	ADD CONSTRAINT UQ_Bill UNIQUE (id)
GO

ALTER TABLE Bed
	ADD CONSTRAINT UQ_Bed UNIQUE (id)
GO
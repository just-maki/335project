CREATE TABLE Professors(
	pssn VARCHAR(9) NOT NULL,
	pname VARCHAR(25),
	p_strtAdr VARCHAR(25),
	p_cityAdr VARCHAR(20),
	p_stateAdr VARCHAR(12),
	p_zipCode INT,
	p_areaCode VARCHAR(3),
	p_7digNo VARCHAR(8),
	p_Sex VARCHAR(10),
	p_Title VARCHAR(10),
	p_Salary FLOAT,
	p_clgDeg VARCHAR(10),
	p_fullAdr VARCHAR(65) AS (concat_ws(' ', p_strtAdr, p_cityAdr, p_stateAdr, p_zipCode)),
	p_teleNo VARCHAR(12) AS (concat_ws('-', p_areaCode, p_7digNo)),
	PRIMARY KEY(pssn)
);

CREATE TABLE Department(
	dep_No VARCHAR(3) NOT NULL,
	dep_Name VARCHAR(4),
	dep_teleNo VARCHAR(14),
	dep_OffLoc VARCHAR(30),
	dep_chairp VARCHAR(9) NOT NULL,
	PRIMARY KEY(dep_No),
	FOREIGN KEY(dep_chairp) REFERENCES Professors(pssn),
);

CREATE TABLE Course(
	crse_No VARCHAR(7) NOT NULL,
	crse_Title VARCHAR(20),
	crse_txtBook VARCHAR(20),
	crse_Units INT,
	crse_preReq VARCHAR(20),
	crse_depOffered VARCHAR(3),
	PRIMARY KEY(crse_No),
	FOREIGN KEY(crse_depOffered) REFERENCES Department(dep_no)
);
CREATE TABLE Section(
	cors_No VARCHAR(7) NOT NULL,
	sect_Prof VARCHAR(9) NOT NULL,
	sect_No VARCHAR(7),
	sect_Classrm VARCHAR(10),
	sect_seatNo INT,
	sect_meetDays VARCHAR(20),
	sect_startTime VARCHAR(5),
	sect_endTime VARCHAR(5),
	FOREIGN KEY(cors_No) REFERENCES Course(crse_no),
	FOREIGN KEY(sect_Prof) REFERENCES Professors(pssn),
);

CREATE TABLE Students(
	stdnt_CWID VARCHAR(9) NOT NULL,
	stdnt_FName VARCHAR(15),
	stdnt_Lname VARCHAR(15),
	stdnt_fullName VARCHAR(30) AS (concat_ws(' ', stdnt_Fname, stdnt_Lname)),
	stdnt_teleNo VARCHAR(12),
	stdnt_Major VARCHAR(15) NOT NULL,
	stdnt_Minor VARCHAR(15) NOT NULL,
	PRIMARY KEY(stdnt_CWID),
	FOREIGN KEY(stdnt_Major) REFERENCES Department(dep_no),
	FOREIGN KEY(stdnt_Minor) REFERENCES Department(dep_no)
);

CREATE TABLE EnrollRec(
	er_Student VARCHAR(9) NOT NULL,
	er_crseNo VARCHAR(7) NOT NULL,
	er_sectNo VARCHAR(7) NOT NULL,
	er_Grade CHAR(2),
	FOREIGN KEY(er_Student) REFERENCES Students(stdnt_CWID),
	FOREIGN KEY(er_crseNo) REFERENCES Section(cors_No),
    FOREIGN KEY(er_sectNo) REFERENCES Section(sect_No)
);

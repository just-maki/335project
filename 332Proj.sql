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
	dep_No VARCHAR(3) NOT NULL PRIMARY KEY,
	dep_Name VARCHAR(4),
	dep_teleNo VARCHAR(14),
	dep_OffLoc VARCHAR(30),
	dep_chairp VARCHAR(9) FOREIGN KEY REFERENCES Professors(pssn)
);

CREATE TABLE Course(
	crse_No VARCHAR(7) NOT NULL PRIMARY KEY,
	crse_Title VARCHAR(20),
	crse_txtBook VARCHAR(20),
	crse_Units INT,
	crse_preReq VARCHAR(20),
	crse_depOffered VARCHAR(3) FOREIGN KEY REFERENCES Department(dep_no)
);

CREATE TABLE Section(
	cors_No VARCHAR(7) NOT NULL FOREIGN KEY REFERENCES Course(crse_no),
	sect_Prof VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES Professors(pssn),
	sect_No VARCHAR(7),
	sect_Classrm VARCHAR(10),
	sect_seatNo INT,
	sect_meetDays VARCHAR(20),
	sect_startTime VARCHAR(5),
	sect_endTime VARCHAR(5)
);

CREATE TABLE Students(
	stdnt_CWID VARCHAR(9) NOT NULL PRIMARY KEY,
	stdnt_FName VARCHAR(15),
	stdnt_Lname VARCHAR(15),
	stdnt_fullName VARCHAR(30) AS (concat_ws(' ', stdnt_Fname, stdnt_Lname)),
	stdnt_teleNo VARCHAR(12),
	stdnt_Major VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES Department(dep_no),
	stdnt_Minor VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES Department(dep_no)
);

CREATE TABLE EnrollRec(
	er_Student VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES Students(stdnt_CWID),
	er_crseNo VARCHAR(7) NOT NULL FOREIGN KEY REFERENCES Section(cors_No),
	er_sectNo VARCHAR(7) NOT NULL FOREIGN KEY REFERENCES Section(sect_No),
	er_Grade CHAR(2)
);

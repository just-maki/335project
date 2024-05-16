CREATE TABLE Professors(
	pssn NUMERIC(9) PRIMARY KEY,
	pname VARCHAR(40),
	p_strtAdr VARCHAR(25),
	p_cityAdr VARCHAR(20),
	p_state   CHAR(2),
	p_zipCode NUMERIC(5),
	p_areaCode NUMERIC(3),
	p_7digNo NUMERIC(7),
	p_Sex VARCHAR(10),
	p_Title VARCHAR(10),
	p_Salary FLOAT,
	p_clgDeg VARCHAR(10),
	p_fullAdr VARCHAR(65) AS (concat_ws(' ', p_strtAdr, p_cityAdr, p_stateAdr, p_zipCode)),
	p_teleNo VARCHAR(12) AS (concat_ws('-', p_areaCode, p_7digNo))
);

CREATE TABLE Department(
	dep_No NUMERIC(3) PRIMARY KEY,
	dep_Name VARCHAR(4),
	dep_teleNo VARCHAR(14),
	dep_OffLoc VARCHAR(30),
	dep_chairp VARCHAR(9),
	FOREIGN KEY (dep_chairp) REFERENCES Professors(pssn)[ON DELETE SET NULL | ON DELETE CASCADE]
);

CREATE TABLE Course(
	crse_No VARCHAR(7)   PRIMARY KEY,
	crse_Title VARCHAR(30),
	crse_txtBook VARCHAR(50),
	crse_Units TINYINT,
	crse_preReq VARCHAR(20),
	crse_depOffered VARCHAR(4),
	FOREIGN KEY (crse_depOffered) REFERENCES Department(dep_no)[ON DELETE SET NULL | ON DELETE CASCADE]
);
CREATE TABLE CrSection(
	cors_No VARCHAR(7),
	sect_Prof VARCHAR(9),
	sect_No VARCHAR(7),
	sect_Classrm VARCHAR(10),
	sect_seatNo INT,
	sect_meetDays VARCHAR(20),
	sect_startTime VARCHAR(5),
	sect_endTime VARCHAR(5),
	PRIMARY KEY (cors_No, sect_Prof),
	FOREIGN KEY (cors_No)   REFERENCES Course(crse_no)[ON DELETE SET NULL | ON DELETE CASCADE],
	FOREIGN KEY (sect_Prof) REFERENCES Professors(pssn)[ON DELETE SET NULL | ON DELETE CASCADE]
);

CREATE TABLE Students(
	stdnt_CWID NUMERIC(9) PRIMARY KEY,
	stdnt_FName VARCHAR(20),
	stdnt_Lname VARCHAR(20),
	stdnt_fullName VARCHAR(30) AS (concat_ws(' ', stdnt_Fname, stdnt_Lname)),
	stdnt_teleNo NUMERIC(10),
	stdnt_Major VARCHAR(15),
	stdnt_Minor VARCHAR(15),
	FOREIGN KEY (stdnt_Major) REFERENCES Department(dep_no)[ON DELETE SET NULL | ON DELETE CASCADE],
	FOREIGN KEY (stdnt_Minor) REFERENCES Department(dep_no)[ON DELETE SET NULL | ON DELETE CASCADE]
);

CREATE TABLE EnrollRec(
	er_Student VARCHAR(9),
	er_crseNo VARCHAR(7),
	er_sectNo VARCHAR(7),
	er_Grade ENUM('A', 'B', 'C', 'D', 'F','W'),
	PRIMARY KEY(er_Student, er_crseNo, er_sectNo),
	FOREIGN KEY (er_Student) REFERENCES Students(stdnt_CWID)[ON DELETE SET NULL | ON DELETE CASCADE],
	FOREIGN KEY (er_crseNo)  REFERENCES Section(cors_No)[ON DELETE SET NULL | ON DELETE CASCADE],
        FOREIGN KEY (er_sectNo)  REFERENCES Section(sect_No)[ON DELETE SET NULL | ON DELETE CASCADE]
);



CREATE TABLE Professors(
	pssn VARCHAR(9) PRIMARY KEY,
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
	dep_No VARCHAR(3) PRIMARY KEY,
	dep_Name VARCHAR(4),
	dep_teleNo VARCHAR(14),
	dep_OffLoc VARCHAR(30),
	dep_chairp VARCHAR(9),
	FOREIGN KEY (dep_chairp) REFERENCES Professors(pssn)
);
CREATE TABLE Course(
	crse_No VARCHAR(7)   PRIMARY KEY,
	crse_Title VARCHAR(30),
	crse_txtBook VARCHAR(50),
	crse_Units TINYINT,
	crse_preReq VARCHAR(20),
	crse_depOffered VARCHAR(3),
	FOREIGN KEY (crse_depOffered) REFERENCES Department(dep_No)
);
CREATE TABLE CrSection(
	cors_No VARCHAR(7),
	sect_Prof VARCHAR(9),
	sect_No VARCHAR(15),
	sect_Classrm VARCHAR(30),
	sect_seatNo INT,
	sect_meetDays VARCHAR(15),
	sect_startTime VARCHAR(5),
	sect_endTime VARCHAR(5),
	FOREIGN KEY (cors_No)   REFERENCES Course(crse_no),
	FOREIGN KEY (sect_Prof) REFERENCES Professors(pssn)
);
CREATE TABLE Students(
	stdnt_CWID VARCHAR(8) PRIMARY KEY,
	stdnt_FName VARCHAR(20),
	stdnt_Lname VARCHAR(20),
	stdnt_fullName VARCHAR(30) AS (concat_ws(' ', stdnt_Fname, stdnt_Lname)),
	stdnt_teleNo NUMERIC(10),
	stdnt_Major VARCHAR(3),
	stdnt_Minor VARCHAR(3),
	FOREIGN KEY (stdnt_Major) REFERENCES Department(dep_no),
	FOREIGN KEY (stdnt_Minor) REFERENCES Department(dep_no)
);
CREATE TABLE EnrollRec(
	er_Student VARCHAR(8),
	er_crseNo VARCHAR(7),
	er_Grade ENUM('A+', 'A', 'A-', 'B+', 'B', 'B-','C+', 'C', 'C-','D','F', 'W'),
	FOREIGN KEY (er_Student) REFERENCES Students(stdnt_CWID),
	FOREIGN KEY (er_crseNo)  REFERENCES Course(crse_No)
);
INSERT INTO Professors (pssn, pname, p_strtAdr, p_cityAdr, p_state, p_zipCode, p_areaCode, p_7digNo, p_Sex, p_Title, p_Salary, p_clgDeg) VALUES
(123456789, 'Alan Turing', '123 Main St', 'Irvine', 'CA', 92697, 949, 1234567, 'Male', 'Professor', 150000, 'PhD'),
(987654321, 'Grace Hopper', '456 Elm St', 'Fullerton', 'CA', 92831, 714, 2345678, 'Female', 'Professor', 140000, 'PhD'),
(192837465, 'John von Neumann', '789 Maple St', 'Santa Ana', 'CA', 92701, 657, 3456789, 'Male', 'Professor', 145000, 'PhD');
INSERT INTO Department (dep_No, dep_Name, dep_teleNo, dep_OffLoc, dep_chairp) VALUES
(101, 'CS', '949-123-4567', 'Engineering Building 101', '123456789'),
(102, 'MATH', '714-234-5678', 'Science Building 202', '987654321');
INSERT INTO Course (crse_No, crse_Title, crse_txtBook, crse_Units, crse_preReq, crse_depOffered) VALUES
('CS101', 'Intro to CS', 'Introduction to Computer Science', 3, NULL, 101),
('CS102', 'Data Structures', 'Data Structures and Algorithms', 3, 'CS101', 101),
('MATH101', 'Calculus I', 'Calculus: Early Transcendentals', 4, NULL, 102),
('MATH102', 'Linear Algebra', 'Linear Algebra and Its Applications', 3, 'MATH101', 102);
INSERT INTO CrSection (cors_No, sect_Prof, sect_No, sect_Classrm, sect_seatNo, sect_meetDays, sect_startTime, sect_endTime) VALUES
('CS101', '123456789', '01', 'CS Building 105', 30, 'MWF', '09:00', '10:15'),
('CS102', '987654321', '01', 'CS Building 106', 30, 'MWF', '10:30', '11:45'),
('MATH101', '192837465', '01', 'Math Building 201', 35, 'TTh', '08:00', '09:30'),
('MATH102', '987654321', '01', 'Math Building 202', 35, 'TTh', '10:00', '11:30'),
('CS101', '123456789', '02', 'CS Building 107', 30, 'MWF', '13:00', '14:15'),
('MATH101', '192837465', '02', 'Math Building 203', 35, 'TTh', '13:00', '14:30');
INSERT INTO Students(stdnt_CWID, stdnt_FName, stdnt_LName, stdnt_teleNo, stdnt_Major,stdnt_Minor) VALUES
(88621587,'Francisco','Godoy',9499917091, 101, 102),
(88624211,'Maxwell','Lebda',7146248774, 101, 102),
(88626721,'Helena','Truang',921708825, 101, 102),
(88620523,'Santiago','Gimenez',3126248534, 101, 102),
(88624099,'Chloe','Klein',9494046942, 101, 102),
(88624119,'Nils','Niestch',7142215711, 101, 102),
(88644602,'Coby','Bryan',8180134587, 101, 102),
(88625210,'Shad','Betar',714102332, 101, 102);
INSERT INTO EnrollRec (er_Student, er_crseNo, er_Grade) VALUES
('88621587', 'CS101', 'A'),
('88624211', 'CS101', 'B'),
('88626721', 'CS101', 'A-'),
('88620523', 'CS102', 'B+'),
('88624099', 'CS102', 'A'),
('88624119', 'MATH101','C'),
('88644602', 'MATH101','B'),
('88625210', 'MATH102', 'A'),
('88621587', 'MATH102', 'B+'),
('88624211', 'CS101', 'A'),
('88626721', 'CS101', 'B-'),
('88620523', 'MATH101', 'C+'),
('88624099', 'MATH101', 'B'),
('88624119', 'MATH101', 'A'),
('88644602', 'CS101', 'B+'),
('88625210', 'CS102', 'A'),
('88621587', 'MATH101', 'A-'),
('88624211', 'MATH102', 'B'),
('88626721', 'CS101', 'A'),
('88620523', 'MATH101', 'B+');

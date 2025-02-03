-- Create the database
CREATE DATABASE IF NOT EXISTS clubmanagementsystem;
USE clubmanagementsystem;

-- Create the Admin table
CREATE TABLE Admin (
    Admin_ID INT AUTO_INCREMENT PRIMARY KEY,
    Admin_Name VARCHAR(50) NOT NULL,
    Admin_Password VARCHAR(255) NOT NULL,
    Admin_Contact_Num VARCHAR(15) NOT NULL
);

-- Create the Student table
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    IC_Num VARCHAR(12) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Contact_Num VARCHAR(15) NOT NULL,
    Faculty VARCHAR(50) NOT NULL,
    Program VARCHAR(50) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Active',
    Password VARCHAR(255) NOT NULL
);

-- Create the Club table
CREATE TABLE Club (
    Club_ID INT AUTO_INCREMENT PRIMARY KEY,
    Club_Name VARCHAR(50) NOT NULL,
    Club_Desc TEXT,
    Club_Est_Date DATE NOT NULL,
    Club_Email VARCHAR(50) NOT NULL,
    Club_Category VARCHAR(50) NOT NULL,
    Club_Status VARCHAR(20) DEFAULT 'Active',
    President_ID INT,
    FOREIGN KEY (President_ID) REFERENCES Student(Student_ID) ON DELETE SET NULL
);

-- Create the Role table
CREATE TABLE Role (
    Role_ID INT AUTO_INCREMENT PRIMARY KEY,
    Role_Name VARCHAR(50) NOT NULL,
    Role_Desc TEXT
);

-- Create the Club Member table
CREATE TABLE Club_Member (
    Club_Member_ID INT AUTO_INCREMENT PRIMARY KEY,
    Student_ID INT NOT NULL,
    Club_ID INT NOT NULL,
    Member_Status VARCHAR(20) DEFAULT 'Pending',
    Register_Date DATE NOT NULL,
    Role_ID INT NOT NULL,
    UNIQUE (Student_ID, Role_ID), -- Prevent duplicate roles for a student
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON DELETE CASCADE,
    FOREIGN KEY (Club_ID) REFERENCES Club(Club_ID) ON DELETE CASCADE,
    FOREIGN KEY (Role_ID) REFERENCES Role(Role_ID)
);

-- Create the President Application table
CREATE TABLE President_Application (
    Application_ID INT AUTO_INCREMENT PRIMARY KEY,
    Application_Date DATE NOT NULL,
    Approval_Status VARCHAR(20) DEFAULT 'Pending',
    Student_ID INT NOT NULL,
    Admin_ID INT NOT NULL,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON DELETE CASCADE,
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID) ON DELETE CASCADE
);

-- Create the Event table
CREATE TABLE Event (
    Event_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Desc TEXT,
    Event_Location VARCHAR(100) NOT NULL,
    Event_Status VARCHAR(20) DEFAULT 'Scheduled',
    Club_ID INT NOT NULL,
    Admin_ID INT NOT NULL,
    FOREIGN KEY (Club_ID) REFERENCES Club(Club_ID) ON DELETE CASCADE,
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID) ON DELETE CASCADE
);

-- Insert sample data for Admin
INSERT INTO Admin (Admin_Name, Admin_Password, Admin_Contact_Num)
VALUES
('Alice Smith', 'password123', '1234567890'),
('Bob Johnson', 'securepass456', '9876543210'),
('Charlie Davis', 'admin789', '1122334455'),
('Diana Moore', 'mypassword321', '5566778899'),
('Edward Clark', 'pass5678', '7788990011');

-- Insert sample data for Role
INSERT INTO Role (Role_Name, Role_Desc)
VALUES
('President', 'President of the club'),
('Member', 'General member of the club');

-- Insert sample data for Student
INSERT INTO Student (Student_ID, Name, IC_Num, Email, Contact_Num, Faculty, Program, Status, Password)
VALUES
(2024, 'Muhammad Aqil', '030428103049', '2024916837@student.uitm.edu.my', '0108166096', 'FSKM', 'CSC230', 'Active', 'password2024'),
(2025, 'Aisyah Binti Ali', '041012029876', '2025916837@student.uitm.edu.my', '0112123456', 'FSG', 'BIO230', 'Active', 'password2025');

-- Insert sample data for Club
INSERT INTO Club (Club_Name, Club_Desc, Club_Est_Date, Club_Email, Club_Category, Club_Status, President_ID)
VALUES
('Tech Club', 'A club for tech enthusiasts', '2023-01-15', 'techclub@uitm.edu.my', 'Technology', 'Active', 2024),
('Science Club', 'Exploring the world of science', '2023-02-20', 'scienceclub@uitm.edu.my', 'Science', 'Active', 2025);

-- Insert sample data for Club_Member
INSERT INTO Club_Member (Student_ID, Club_ID, Member_Status, Register_Date, Role_ID)
VALUES (2024, 1, 'Active', '2023-12-01', 2),
(2025, 2, 'Pending', '2024-01-15', 2);

SELECT * FROM Student WHERE Student_ID = 2024 AND Password = 'password2024';

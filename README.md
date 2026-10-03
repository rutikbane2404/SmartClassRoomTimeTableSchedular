# Smart Classroom & Timetable Scheduler

A Java-based web application designed to simplify academic timetable management, classroom allocation, faculty workload analysis, and timetable resource utilization in educational institutions.

The system provides a centralized platform for managing faculty, students, subjects, classes, classrooms, weekly timetables, daily timetables, analytics, and PDF-based reports.

---

## 📌 Project Overview

Managing academic timetables manually becomes difficult when multiple faculty members, subjects, classrooms, divisions, and time slots are involved.

The Smart Classroom & Timetable Scheduler provides a centralized web-based solution for managing these activities.

The system allows administrators to:

- Manage faculty
- Manage students
- Manage subjects
- Manage classes/divisions
- Manage classrooms
- Create and manage weekly timetables
- Create and manage daily timetables
- View timetable information
- Analyze faculty workload
- Analyze classroom utilization
- Analyze time-slot utilization
- Identify peak classroom usage
- Generate analytical reports
- Export timetables/reports as PDF
- Send PDF reports through email

---

## ✨ Features

### 👨‍💼 Administration

- Role-based login
- Faculty management
- Student management
- Subject management
- Class management
- Classroom management
- Timetable management

### 📅 Timetable Management

- Weekly timetable creation
- Daily timetable creation
- Timetable editing
- Timetable viewing
- Day-wise timetable management
- Time-slot based scheduling
- Faculty and classroom allocation

### 📊 Analytics

- Faculty workload analysis
- Room utilization analysis
- Time utilization analysis
- Peak-time analysis
- Classroom usage comparison
- Analytical report generation

### 📄 Reports

- Weekly timetable PDF export
- Daily timetable PDF export
- Room analytics reports
- Print-friendly reports
- Email integration for PDF reports

---

## 🏗️ System Architecture

The project follows the MVC architecture.


                    ┌─────────────────────┐
                    │       Browser       │
                    │ JSP / HTML / CSS /  │
                    │ JavaScript /        │
                    │ Bootstrap / Charts  │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │      Servlets       │
                    │    Controller Layer │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │        DAO          │
                    │   Data Access Layer │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │        JDBC         │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │       MySQL         │
                    │      Database       │
                    └─────────────────────┘


🛠️ Technologies Used:
Frontend
JSP
HTML5
CSS3
Bootstrap
JavaScript
Chart.js
Backend
Java
Servlets
JavaBeans / Model classes
JDBC
DAO Pattern
MVC Architecture
Database
MySQL
Server
Apache Tomcat 9
Libraries
MySQL Connector/J
JavaMail
Java Activation Framework
iTextPDF
Development Tools
Eclipse IDE
MySQL Workbench
Git
GitHub


📂 Project Structure:

SmartClassRoomTimeTableSchedular
│
├── database
│   └── smartclassroomtimetableschedular.sql
│
├── src
│   └── main
│       ├── java
│       │   ├── controller
│       │   ├── dao
│       │   ├── model
│       │   └── util
│       │
│       └── webapp
│           ├── css
│           ├── images
│           ├── js
│           ├── jsp
│           │   ├── admin
│           │   ├── auth
│           │   ├── faculty
│           │   └── student
│           ├── META-INF
│           └── WEB-INF
│
├── .gitignore
└── README.md


🗄️ Database:
The project uses MySQL database:
smartclassroomtimetableschedular
The database schema is provided in:
database/smartclassroomtimetableschedular.sql
The database contains tables for areas including:
Users
Classes
Classrooms
Faculty
Faculty availability
Students
Subjects
Weekly timetable
Daily timetable
Attendance
Feedback
Notifications
Foreign-key relationships are used to connect timetable records with classes, subjects, faculty members, and classrooms.


🔐 Configuration:
Database and email credentials are not stored directly in the source code.
The application reads them from environment variables
Database
DB_PASSWORD=your_mysql_password
Email
EMAIL_USERNAME=your_email_address
EMAIL_PASSWORD=your_gmail_app_password


🚀 How to Run:
1. Requirements
Install:
Java JDK 21
Eclipse IDE
Apache Tomcat 9
MySQL Server
MySQL Workbench
Git
2. Clone the repository
git clone https://github.com/rutikbane2404/SmartClassRoomTimeTableSchedular.git
Then open the project in Eclipse.
3. Create the database
Create a MySQL database:
CREATE DATABASE smartclassroomtimetableschedular;
Import:
database/smartclassroomtimetableschedular.sql
into the database.
4. Configure environment variables
Set the following Windows environment variables:
DB_PASSWORD
EMAIL_USERNAME
EMAIL_PASSWORD
Use your own local credentials
5. Configure Tomcat
Add Apache Tomcat 9 to Eclipse and deploy the project.
Start the Tomcat server.
6. Open the application
Open the application through the Tomcat server URL.
http://localhost:8080/
The exact application context path depends on the Eclipse/Tomcat deployment configuration.


📊 Analytics Modules:
The project includes analytical features that convert timetable data into useful information.
Faculty Workload Analysis
Analyzes the number of lectures assigned to faculty members and displays workload information using charts.
Room Utilization Analysis
Analyzes classroom usage and identifies frequently occupied and underutilized rooms.
Time Utilization Analysis
Analyzes classroom usage across different lecture time slots.
Peak Time Analysis
Identifies time periods with higher classroom demand.
Automated Analytical Reports
Combines timetable and utilization information into structured reports that can be viewed, printed, or exported.


📄 PDF & Email Integration:
The system supports PDF generation for timetable information.
Generated PDF reports can also be sent through email using JavaMail.
Email credentials are configured through environment variables rather than being stored in the source code.


## 📸 Screenshots

### 🔐 Authentication

#### Admin Login
![Admin Login](Screenshots/Admin%20Login.png)

#### Faculty Login
![Faculty Login](Screenshots/Faculty%20Login.png)

#### Student Login
![Student Login](Screenshots/Student%20Login.png)

---

### 📊 Dashboards

#### Admin Dashboard
![Admin Dashboard](Screenshots/Admin%20Dashboard.png)

#### Faculty Dashboard
![Faculty Dashboard](Screenshots/Faculty%20Dashboard.png)

#### Student Dashboard
![Student Dashboard](Screenshots/Student%20dashboard.png)

---

### 📅 Timetable Management

#### Weekly Timetable
![Weekly Timetable](Screenshots/Weekly%20TT.png)

---

### 📈 Analytics

#### Faculty Workload Analytics
![Faculty Workload Analytics](Screenshots/Screenshot%202026-05-06%20000427.png)

#### Room Utilization Analytics
![Room Utilization Analytics](Screenshots/Rooms%20Usage%20analytics.png)

#### Time Utilization Analytics
![Time Utilization Analytics](Screenshots/Time%20Usage%20analytics.png)

#### Utilization Charts
![Utilization Charts](Screenshots/Utilization%20Charts.png)

---

### 📄 Reports & PDF

#### Analytical Report
![Analytical Report](Screenshots/Fianal%20Analytical%20report.png)

#### PDF Export
![PDF Feature](Screenshots/PDF%20Feature.png)

#### Email Integration
![Email Integration](Screenshots/Email%20feature.png)


🔒 Security Considerations
The project uses:
Session-based login
Role-based access
Server-side request handling
Environment variables for database and email credentials
Database foreign-key relationships
Form validation


🎯 Project Objectives:
The major objectives of the project are:
Reduce manual timetable management effort.
Centralize academic scheduling information.
Simplify faculty, student, subject, class, and classroom management.
Support weekly and daily timetable management.
Analyze faculty workload.
Analyze classroom and time-slot utilization.
Generate useful analytical reports.
Support PDF export and email-based report sharing.


🔮 Future Scope:
Possible future enhancements include:
AI-based timetable generation
Constraint-based scheduling
Automatic timetable conflict resolution
Dynamic timetable rescheduling
Student and faculty self-service portals
Advanced predictive analytics
Mobile application
Cloud deployment
Push notifications
Google Calendar integration
Integration with institutional ERP systems


👨‍💻 Developer:
Rutik Sudhir Bane
MCA Student
Mumbai University


📜 License:
This project is developed for academic and educational purposes.

<%@ page import="java.sql.*, util.DBConnection"%>
<%@ page import="model.User"%>
<%@ page import="java.util.*, model.FacultyWorkload" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
User user = (User) session.getAttribute("user");

if (user == null || !user.getRole().equals("ADMIN")) {

	response.sendRedirect("../auth/Login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>SmartClass Admin Dashboard</title>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background: #f1f5f9;
	font-family: Arial;
}

/* 🔥 SIDEBAR */
.sidebar {
	width: 280px;
	height: 100vh;
	background: #0f172a;
	position: fixed;
	top: 0;
	left: 0;
	overflow-y: auto;
	transition: 0.3s;
	z-index: 999;
}

.sidebar-header {
	padding: 25px;
	border-bottom: 1px solid #1e293b;
}

.sidebar-header h2 {
	color: white;
	font-weight: bold;
}

.sidebar a {
	display: block;
	color: #cbd5e1;
	text-decoration: none;
	padding: 14px 25px;
	transition: 0.3s;
	font-size: 15px;
}

.sidebar a:hover {
	background: #1e293b;
	color: white;
}

.sidebar-title {
	color: #64748b;
	font-size: 13px;
	padding: 20px 25px 10px;
}

/* 🔥 MAIN */
.main {
	margin-left: 280px;
	padding: 30px;
}

/* 🔥 TOPBAR */
.topbar {
	background: white;
	padding: 18px 25px;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

/* 🔥 CARDS */
.dashboard-card {
	border-radius: 18px;
	padding: 25px;
	color: white;
	transition: 0.3s;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.dashboard-card:hover {
	transform: translateY(-5px) scale(1.02);
}

/* 🔥 TABLE */
.table-card {
	background: white;
	border-radius: 15px;
	padding: 20px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
}

/* 🔥 ANNOUNCEMENT */
.notice-box {
	background: linear-gradient(to right, #2563eb, #1d4ed8);
	color: white;
	padding: 20px;
	border-radius: 15px;
}

/* 🔥 BUTTONS */
.quick-btn {
	border-radius: 10px;
	padding: 10px 20px;
}

/* 🔥 TOGGLE */
.toggle-btn {
	display: none;
}

/* 🔥 MOBILE */
@media ( max-width :991px) {
	.sidebar {
		left: -280px;
	}
	.sidebar.active {
		left: 0;
	}
	.main {
		margin-left: 0;
	}
	.toggle-btn {
		display: block;
	}
}
</style>

</head>

<body>

	<%
	int facultyCount = 0;
	int studentCount = 0;
	int weeklyCount = 0;
	int dailyCount = 0;

	try {

		Connection con = DBConnection.getConnection();

		Statement st = con.createStatement();

		ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM faculty");

		if (rs1.next())
			facultyCount = rs1.getInt(1);

		ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM students");

		if (rs2.next())
			studentCount = rs2.getInt(1);

		ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM timetable");

		if (rs3.next())
			weeklyCount = rs3.getInt(1);

		ResultSet rs4 = st.executeQuery("SELECT COUNT(*) FROM daily_timetable");

		if (rs4.next())
			dailyCount = rs4.getInt(1);

	} catch (Exception e) {
		e.printStackTrace();
	}
	%>

	<!-- 🔥 SIDEBAR -->

	<div class="sidebar" id="sidebar">

		<div class="sidebar-header">

			<h2>🎓 SmartClass</h2>

		</div>

		<a href="AdminDashboard.jsp"> <i class="fa fa-home"></i> Dashboard
		</a>

		<div class="sidebar-title">FACULTY MANAGEMENT</div>

		<a href="RegisterFaculty.jsp"> ➕ Add Faculty </a> <a
			href="ManageFaculty.jsp"> 👨‍🏫 Manage Faculty </a>

		<div class="sidebar-title">STUDENT MANAGEMENT</div>

		<a href="StudentRegistration.jsp"> ➕ Add Student </a> <a
			href="ManageStudent.jsp"> 👨‍🎓 Manage Students </a>

		<div class="sidebar-title">SUBJECT MANAGEMENT</div>

		<a href="ManageSubjects.jsp"> 📚 Manage Subjects </a>

		<div class="sidebar-title">CLASSROOM MANAGEMENT</div>

		<a href="ManageClassrooms.jsp"> 🏫 Manage Classrooms </a>

		<div class="sidebar-title">CLASS MANAGEMENT</div>

		<a href="ManageClasses.jsp"> 🎓 Manage Classes </a>

		<div class="sidebar-title">WEEKLY TIMETABLE</div>

		<a href="createWeekly.jsp"> 📅 Create Weekly </a> 
		<a href="viewWeekly.jsp"> 📖 View Weekly </a> 
		<a href="gridWeekly.jsp">🧩 Weekly Grid </a>

		<div class="sidebar-title">DAILY TIMETABLE</div>

		<a href="createDaily.jsp"> 📆 Create Daily </a> 
		<a href="viewDaily.jsp"> 📖 View Daily </a> 
		<a href="gridDaily.jsp">🧩 Daily Grid </a>

		<div class="sidebar-title">REPORTS & ANALYTICS</div>

		<a href="../../AnalyticsServlet">📊 Faculty Workload</a> 
		<a href="../../RoomAnalyticsServlet">
    Room Utilization
</a>
		<a href="#"> ⚠ Clash Reports </a> 
		<a href="#"> 📢	Announcements </a>

		<div class="sidebar-title">SETTINGS</div>

		<a href="#"> ⚙ System Settings </a> <a
			href="<%=request.getContextPath()%>/LogoutServlet"> 🚪 Logout </a>

	</div>

	<!-- 🔥 MAIN -->

	<div class="main">

		<!-- 🔥 TOPBAR -->

		<div class="topbar">

			<div>

				<button class="btn btn-dark toggle-btn" onclick="toggleSidebar()">

					☰</button>

				<h2>📊 Dashboard Overview</h2>

				<p class="text-muted">
					Welcome back, <b><%=user.getName()%></b>
				</p>

			</div>

			<div>

				<input type="text" class="form-control" placeholder="Search...">

			</div>

		</div>

		<!-- 🔥 NOTICE -->

		<div class="notice-box mt-4">

			<h4>📢 Smart Announcement</h4>

			<p class="mb-0">Welcome to Smart Classroom & Timetable Scheduler
				System. Manage schedules, classrooms, faculty, students and reports
				efficiently.</p>

		</div>

		<!-- 🔥 CARDS -->

		<div class="row mt-4">

			<div class="col-md-3 mb-3">

				<a href="../faculty/showFaculty.jsp" style="text-decoration: none;">

					<div class="dashboard-card bg-primary">

						<h5>Faculty</h5>

						<h1>
							<%=facultyCount%>
						</h1>

						<p>Total Faculty Members</p>

					</div>

				</a>

			</div>

			<div class="col-md-3 mb-3">

				<a href="../student/showStudents.jsp" style="text-decoration: none;">

					<div class="dashboard-card bg-success">

						<h5>Students</h5>

						<h1>
							<%=studentCount%>
						</h1>

						<p>Registered Students</p>

					</div>

				</a>

			</div>

			<div class="col-md-3 mb-3">

				<a href="viewWeekly.jsp" style="text-decoration: none;">

					<div class="dashboard-card bg-warning">

						<h5>Weekly Slots</h5>

						<h1>
							<%=weeklyCount%>
						</h1>

						<p>Weekly Lectures</p>

					</div>

				</a>

			</div>

			<div class="col-md-3 mb-3">

				<a href="viewDaily.jsp" style="text-decoration: none;">

					<div class="dashboard-card bg-danger">

						<h5>Daily Lectures</h5>

						<h1>
							<%=dailyCount%>
						</h1>

						<p>Today's Lectures</p>

					</div>

				</a>

			</div>

		</div>

		<!-- 🔥 QUICK ACTIONS -->

		<div class="table-card mt-4">

			<h4>⚡ Quick Actions</h4>

			<div class="mt-3">

				<a href="RegisterFaculty.jsp" class="btn btn-primary quick-btn">
					Add Faculty </a> <a href="StudentRegistration.jsp"
					class="btn btn-success quick-btn"> Add Student </a> <a
					href="createWeekly.jsp" class="btn btn-warning quick-btn">Create
					Weekly </a> <a href="createDaily.jsp" class="btn btn-danger quick-btn">
					Create Daily </a> <a href="AddClasses.jsp"
					class="btn btn-secondary quick-btn"> Add Class</a> <a
					href="AddClassroom.jsp" class="btn btn-info quick-btn"> Add
					ClassRoom</a> <a href="ManageSubjects.jsp"
					class="btn btn-light quick-btn"> Add Subject </a>
			</div>

		</div>

		<!-- 🔥 RECENT TIMETABLE -->

		<div class="table-card mt-4">

			<h4 class="mb-3">🕒 Recent Weekly Timetable</h4>

			<table class="table table-bordered table-hover">

				<tr class="table-dark">

					<th>Class</th>
					<th>Day</th>
					<th>Time</th>

				</tr>

				<%
				try {

					Connection con = DBConnection.getConnection();

					Statement st = con.createStatement();

					String sql =

					"SELECT c.class_name,t.day_of_week,t.start_time,t.end_time " +

							"FROM timetable t " +

							"JOIN classes c ON t.class_id=c.class_id " +

							"ORDER BY t.timetable_id DESC LIMIT 5";

					ResultSet rs = st.executeQuery(sql);

					while (rs.next()) {
				%>

				<tr>

					<td><%=rs.getString("class_name")%></td>

					<td><%=rs.getString("day_of_week")%></td>

					<td><%=rs.getString("start_time")%> - <%=rs.getString("end_time")%>
					</td>

				</tr>

				<%
				}

				} catch (Exception e) {
				e.printStackTrace();
				}
				%>

			</table>

		</div>

		<!-- 🔥 ANALYTICS -->

		<div class="row mt-4">

			<div class="col-md-6">

				<div class="table-card">

					<h4>📈 System Analytics</h4>

					<ul class="list-group mt-3">

						<li class="list-group-item">✔ Faculty Active : <%=facultyCount%>
						</li>

						<li class="list-group-item">✔ Students Registered : <%=studentCount%>
						</li>

						<li class="list-group-item">✔ Weekly Timetables : <%=weeklyCount%>
						</li>

						<li class="list-group-item">✔ Daily Timetables : <%=dailyCount%>
						</li>

					</ul>

				</div>

			</div>

			<div class="col-md-6">

				<div class="table-card">

					<h4>🚀 Smart Features</h4>

					<ul class="list-group mt-3">

						<li class="list-group-item">⚡ Clash Detection</li>

						<li class="list-group-item">⚡ Timetable Grid View</li>

						<li class="list-group-item">⚡ Faculty Workload</li>

						<li class="list-group-item">⚡ Smart Classroom Tracking</li>

					</ul>

				</div>

			</div>
			
			<div class="card p-4 mt-4 shadow-sm">

				<h4 class="mb-3">⭐ Student Feedbacks</h4>

				<table class="table table-bordered table-hover">

					<tr class="table-dark">
						<th>Student</th>
						<th>Faculty</th>
						<th>Subject</th>
						<th>Rating</th>
						<th>Feedback</th>
					</tr>

					<%
					try {

						Connection con = DBConnection.getConnection();

						String sql = "SELECT su.name student_name, fu.name faculty_name, " + "f.subject, f.rating, f.feedback_text "
						+ "FROM feedback f " + "JOIN users su ON f.student_id=su.user_id "
						+ "JOIN users fu ON f.faculty_id=fu.user_id " + "ORDER BY f.feedback_id DESC";
						PreparedStatement ps = con.prepareStatement(sql);

						ResultSet rs = ps.executeQuery();

						while (rs.next()) {
					%>

					<tr>
						<td><%=rs.getString("student_name")%></td>
						<td><%=rs.getString("faculty_name")%></td>
						<td><%=rs.getString("subject")%></td>
						<td>⭐ <%=rs.getInt("rating")%>/5
						</td>
						<td><%=rs.getString("feedback_text")%></td>
					</tr>

					<%
					}
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>

				</table>

			</div>

		</div>

	</div>

	<script>
		function toggleSidebar() {

			document.getElementById("sidebar").classList.toggle("active");

		}
	</script>

</body>
</html>
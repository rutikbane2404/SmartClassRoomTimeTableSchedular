<%@ page import="java.sql.*, util.DBConnection, model.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
User user = (User) session.getAttribute("user");

if (user == null || !user.getRole().equals("FACULTY")) {
	response.sendRedirect("../auth/Login.jsp");
	return;
}

String today = java.time.LocalDate.now().getDayOfWeek().toString().substring(0, 3);

int totalLectures = 0;
int totalClasses = 0;
int totalSubjects = 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>Faculty Dashboard</title>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">

<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
* {
	font-family: 'Poppins', sans-serif;
}

body {
	background: #eef2ff;
	overflow-x: hidden;
}

/* TOP HEADER */
.top-header {
	background: linear-gradient(135deg, #1e3a8a, #2563eb);
	padding: 35px;
	border-radius: 0 0 30px 30px;
	color: white;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
	animation: fadeDown 1s ease;
}

.profile-box {
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
}

.profile-left {
	display: flex;
	align-items: center;
	gap: 20px;
}

.avatar {
	width: 90px;
	height: 90px;
	border-radius: 50%;
	background: white;
	color: #2563eb;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 40px;
	font-weight: bold;
}

/* STAT CARDS */
.stat-card {
	border: none;
	border-radius: 20px;
	color: white;
	padding: 25px;
	transition: 0.4s;
	animation: fadeUp 1s ease;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.stat-card:hover {
	transform: translateY(-8px) scale(1.02);
}

.bg1 {
	background: linear-gradient(135deg, #0ea5e9, #2563eb);
}

.bg2 {
	background: linear-gradient(135deg, #10b981, #059669);
}

.bg3 {
	background: linear-gradient(135deg, #f59e0b, #d97706);
}

/* TABLE CARDS */
.main-card {
	background: white;
	border: none;
	border-radius: 20px;
	padding: 25px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
	animation: fadeUp 1s ease;
}

.table {
	border-radius: 15px;
	overflow: hidden;
}

.table thead {
	background: #0f172a;
	color: white;
}

/* BUTTONS */
.custom-btn {
	border: none;
	padding: 12px 20px;
	border-radius: 12px;
	font-weight: 500;
	transition: 0.3s;
	text-decoration: none;
	display: inline-block;
}

.custom-btn:hover {
	transform: translateY(-3px);
}

.btn-blue {
	background: #2563eb;
	color: white;
}

.btn-green {
	background: #10b981;
	color: white;
}

.btn-red {
	background: #ef4444;
	color: white;
}

/* NOTICE */
.notice-box {
	background: white;
	border-left: 5px solid #2563eb;
	border-radius: 15px;
	padding: 20px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	animation: fadeUp 1s ease;
}

/* ANIMATION */
@
keyframes fadeUp {from { opacity:0;
	transform: translateY(40px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@
keyframes fadeDown {from { opacity:0;
	transform: translateY(-40px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>

</head>

<body>

	<!-- HEADER -->

	<div class="top-header">

		<div class="container">

			<div class="profile-box">

				<div class="profile-left">

					<div class="avatar">👨‍🏫</div>

					<div>

						<h2 class="fw-bold">
							Welcome,
							<%=user.getName()%>
						</h2>

						<p class="mb-0">Faculty Dashboard • SmartClass</p>

					</div>

				</div>

				<div>

					<a href="<%=request.getContextPath()%>/LogoutServlet"
						class="custom-btn btn-red"> Logout </a>

				</div>

			</div>

		</div>

	</div>

	<div class="container mt-4">

		<!-- STATS -->

		<div class="row g-4">

			<%
			try {

				Connection con = DBConnection.getConnection();

				String countSql = "SELECT COUNT(*) total FROM timetable t " + "JOIN faculty f ON t.faculty_id=f.faculty_id "
				+ "JOIN users u ON f.faculty_id=u.user_id " + "WHERE u.email=?";

				PreparedStatement cps = con.prepareStatement(countSql);

				cps.setString(1, user.getEmail());

				ResultSet crs = cps.executeQuery();

				if (crs.next()) {
					totalLectures = crs.getInt("total");
				}

				String classSql = "SELECT COUNT(DISTINCT class_id) total FROM timetable t "
				+ "JOIN faculty f ON t.faculty_id=f.faculty_id " + "JOIN users u ON f.faculty_id=u.user_id "
				+ "WHERE u.email=?";

				PreparedStatement cps2 = con.prepareStatement(classSql);

				cps2.setString(1, user.getEmail());

				ResultSet crs2 = cps2.executeQuery();

				if (crs2.next()) {
					totalClasses = crs2.getInt("total");
				}

				String subjectSql = "SELECT COUNT(DISTINCT subject_id) total FROM timetable t "
				+ "JOIN faculty f ON t.faculty_id=f.faculty_id " + "JOIN users u ON f.faculty_id=u.user_id "
				+ "WHERE u.email=?";

				PreparedStatement cps3 = con.prepareStatement(subjectSql);

				cps3.setString(1, user.getEmail());

				ResultSet crs3 = cps3.executeQuery();

				if (crs3.next()) {
					totalSubjects = crs3.getInt("total");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
			%>

			<div class="col-md-4">

				<div class="stat-card bg1">

					<h5>Total Lectures</h5>

					<h1 class="fw-bold">
						<%=totalLectures%>
					</h1>

				</div>

			</div>

			<div class="col-md-4">

				<div class="stat-card bg2">

					<h5>Assigned Classes</h5>

					<h1 class="fw-bold">
						<%=totalClasses%>
					</h1>

				</div>

			</div>

			<div class="col-md-4">

				<div class="stat-card bg3">

					<h5>Subjects Handling</h5>

					<h1 class="fw-bold">
						<%=totalSubjects%>
					</h1>

				</div>

			</div>

		</div>

		<!-- NOTICE -->

		<div class="notice-box mt-4">

			<h5 class="fw-bold">📢 Faculty Notice</h5>

			<p class="mb-0 text-muted">You can view your lectures, classes,
				subjects and today's teaching schedule here. Stay updated with your
				academic activities.</p>

		</div>

		<!-- TODAY LECTURES -->

		<div class="main-card mt-4">

			<div class="d-flex justify-content-between align-items-center mb-3">

				<h4 class="fw-bold">📅 Today’s Lectures</h4>

				<span class="badge bg-primary p-2"> <%=today%>
				</span>

			</div>

			<table class="table table-hover">

				<thead>
					<tr>
						<th>Class</th>
						<th>Subject</th>
						<th>Room</th>
						<th>Time</th>
					</tr>
				</thead>

				<tbody>

					<%
					try {

						Connection con = DBConnection.getConnection();

						String sql = "SELECT c.class_name, s.subject_name, " + "r.room_number, d.start_time, d.end_time "
						+ "FROM daily_timetable d " + "JOIN faculty f ON d.faculty_id=f.faculty_id "
						+ "JOIN users u ON f.faculty_id=u.user_id " + "JOIN classes c ON d.class_id=c.class_id "
						+ "JOIN subjects s ON d.subject_id=s.subject_id " + "JOIN classrooms r ON d.room_id=r.room_id "
						+ "WHERE u.email=? AND d.lecture_date=CURDATE()";

						PreparedStatement ps = con.prepareStatement(sql);

						ps.setString(1, user.getEmail());

						ps.setString(2, today.toUpperCase());

						ResultSet rs = ps.executeQuery();

						boolean found = false;

						while (rs.next()) {

							found = true;
					%>

					<tr>

						<td><%=rs.getString("class_name")%></td>

						<td><%=rs.getString("subject_name")%></td>

						<td><%=rs.getString("room_number")%></td>

						<td><%=rs.getString("start_time")%> - <%=rs.getString("end_time")%>
						</td>

					</tr>

					<%
					}

					if (!found) {
					%>

					<tr>

						<td colspan="4" class="text-center text-danger fw-bold">No
							lectures scheduled today</td>

					</tr>

					<%
					}

					} catch (Exception e) {
					e.printStackTrace();
					}
					%>

				</tbody>

			</table>

		</div>

		<!-- WEEKLY TIMETABLE -->

		<div class="main-card mt-4 mb-5">

			<div class="d-flex justify-content-between align-items-center mb-3">

				<h4 class="fw-bold">🗓 Weekly Timetable</h4>

				<span><a href="showFaculty.jsp" class="custom-btn btn-blue">

						Faculty List </a> <a href="../student/showStudents.jsp"
					class="custom-btn btn-blue"> Student List </a></span>

			</div>

			<table class="table table-hover">

				<thead>

					<tr>
						<th>Day</th>
						<th>Class</th>
						<th>Subject</th>
						<th>Room</th>
						<th>Time</th>
					</tr>

				</thead>

				<tbody>

					<%
					try {

						Connection con = DBConnection.getConnection();

						String sql = "SELECT t.day_of_week, c.class_name, " + "s.subject_name, r.room_number, "
						+ "t.start_time, t.end_time " + "FROM timetable t " + "JOIN faculty f ON t.faculty_id=f.faculty_id "
						+ "JOIN users u ON f.faculty_id=u.user_id " + "JOIN classes c ON t.class_id=c.class_id "
						+ "JOIN subjects s ON t.subject_id=s.subject_id " + "JOIN classrooms r ON t.room_id=r.room_id "
						+ "WHERE u.email=? " + "ORDER BY t.day_of_week";

						PreparedStatement ps = con.prepareStatement(sql);

						ps.setString(1, user.getEmail());

						ResultSet rs = ps.executeQuery();

						while (rs.next()) {
					%>

					<tr>

						<td><%=rs.getString("day_of_week")%></td>

						<td><%=rs.getString("class_name")%></td>

						<td><%=rs.getString("subject_name")%></td>

						<td><%=rs.getString("room_number")%></td>

						<td><%=rs.getString("start_time")%> - <%=rs.getString("end_time")%>
						</td>

					</tr>

					<%
					}

					} catch (Exception e) {
					e.printStackTrace();
					}
					%>

				</tbody>

			</table>

		</div>

		<div class="main-card mt-4 mb-5">

			<div class="d-flex justify-content-between align-items-center mb-4">

				<h4 class="fw-bold">🚀 Smart Timetable Features</h4>

			</div>

			<div class="row g-4">

				<div class="col-md-3">

					<a href="../admin/viewWeekly.jsp" class="text-decoration-none">

						<div class="stat-card bg1 text-center">

							<h3>🗓</h3>

							<h5 class="mt-3">View Weekly</h5>

							<p class="mb-0">Full Weekly lecture schedule</p>

						</div>

					</a>

				</div>

				<div class="col-md-3">

					<a href="../admin/viewDaily.jsp" class="text-decoration-none">

						<div class="stat-card bg2 text-center">

							<h3>📅</h3>

							<h5 class="mt-3">View Daily</h5>

							<p class="mb-0">Daily scheduled lectures</p>

						</div>

					</a>

				</div>

				<div class="col-md-3">

					<a href="../admin/gridWeekly.jsp" class="text-decoration-none">

						<div class="stat-card bg3 text-center">

							<h3>📊</h3>

							<h5 class="mt-3">Weekly Grid</h5>

							<p class="mb-0">Smart weekly grid timetable</p>

						</div>

					</a>

				</div>

				<div class="col-md-3">

					<a href="../admin/gridDaily.jsp" class="text-decoration-none">

						<div class="stat-card bg1 text-center">

							<h3>⚡</h3>

							<h5 class="mt-3">Daily Grid</h5>

							<p class="mb-0">Daily smart timetable grid</p>

						</div>

					</a>

				</div>

			</div>

		</div>

	</div>

</body>
</html>
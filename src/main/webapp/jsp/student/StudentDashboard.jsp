
<%@ page import="java.sql.*, util.DBConnection, model.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
User user = (User) session.getAttribute("user");

if (user == null || !user.getRole().equals("STUDENT")) {
	response.sendRedirect("../auth/Login.jsp");
	return;
}

String today = java.time.LocalDate.now().getDayOfWeek().toString().substring(0, 3);
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>

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
}

.header {
	background: linear-gradient(135deg, #4f46e5, #2563eb);
	padding: 35px;
	color: white;
	border-radius: 0 0 30px 30px;
}

.dashboard-card {
	border: none;
	border-radius: 20px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
	transition: 0.4s;
}

.dashboard-card:hover {
	transform: translateY(-5px);
}

.table {
	border-radius: 15px;
	overflow: hidden;
}

.table thead {
	background: #111827;
	color: white;
}

.feature-btn {
	border: none;
	padding: 12px 18px;
	border-radius: 12px;
	color: white;
	text-decoration: none;
	display: inline-block;
	font-weight: 500;
}

.blue {
	background: #2563eb;
}

.green {
	background: #10b981;
}

.red {
	background: #ef4444;
}
</style>

</head>

<body>

	<div class="header">

		<div
			class="container d-flex justify-content-between align-items-center">

			<div>
				<h2>
					👨‍🎓 Welcome,
					<%=user.getName()%>
				</h2>

				<p class="mb-0">Student Academic Dashboard</p>
			</div>

			<a href="<%=request.getContextPath()%>/LogoutServlet"
				class="feature-btn red"> Logout </a>

		</div>

	</div>

	<div class="container mt-4">

		<div class="row g-4 mb-4">

			<div class="col-md-4">
				<div class="card dashboard-card p-4 bg-primary text-white">
					<h5>Today's Day</h5>
					<h2><%=today%></h2>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card dashboard-card p-4 bg-success text-white">
					<h5>Weekly Timetable</h5>
					<p>View complete weekly lecture schedule</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card dashboard-card p-4 bg-warning text-dark">
					<h5>Feedback System</h5>
					<p>Rate faculty and submit feedback</p>
				</div>
			</div>

		</div>

		<div class="card dashboard-card p-4 mb-4">

			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4>📅 Today's Lectures</h4>
			</div>

			<table class="table table-hover">

				<thead>
					<tr>
						<th>Subject</th>
						<th>Faculty</th>
						<th>Room</th>
						<th>Time</th>
					</tr>
				</thead>

				<tbody>

					<%
					try {

						Connection con = DBConnection.getConnection();

						String sql = "SELECT s.subject_name, u.name faculty_name, " + "r.room_number, t.start_time, t.end_time "
						+ "FROM timetable t " + "JOIN subjects s ON t.subject_id=s.subject_id "
						+ "JOIN faculty f ON t.faculty_id=f.faculty_id " + "JOIN users u ON f.faculty_id=u.user_id "
						+ "JOIN classrooms r ON t.room_id=r.room_id " + "JOIN students st ON t.class_id=st.class_id "
						+ "WHERE st.student_id=? AND t.day_of_week=?";

						PreparedStatement ps = con.prepareStatement(sql);

						ps.setInt(1, user.getUserId());
						ps.setString(2, today);

						ResultSet rs = ps.executeQuery();

						while (rs.next()) {
					%>

					<tr>
						<td><%=rs.getString("subject_name")%></td>
						<td><%=rs.getString("faculty_name")%></td>
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

		<div class="card dashboard-card p-4 mb-4">

			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4>🔍 Search Weekly Lectures</h4>
			</div>

			<form method="get" action="StudentDashboard.jsp">

				<div class="row">

					<div class="col-md-3 mb-3">
						<input type="text" name="day" class="form-control"
							placeholder="Search Day">
					</div>

					<div class="col-md-3 mb-3">
						<input type="text" name="subject" class="form-control"
							placeholder="Search Subject">
					</div>

					<div class="col-md-3 mb-3">
						<input type="text" name="faculty" class="form-control"
							placeholder="Search Faculty">
					</div>

					<div class="col-md-3 mb-3">
						<button type="submit" class="btn btn-primary w-100">
							Search</button>
					</div>

				</div>

			</form>

			<table class="table table-hover mt-3">

				<thead>
					<tr>
						<th>Day</th>
						<th>Subject</th>
						<th>Faculty</th>
						<th>Room</th>
						<th>Time</th>
					</tr>
				</thead>

				<tbody>

					<%
					try {

						Connection con = DBConnection.getConnection();

						String day = request.getParameter("day");
						String subject = request.getParameter("subject");
						String faculty = request.getParameter("faculty");

						String sql = "SELECT t.day_of_week, s.subject_name, u.name faculty_name, "
						+ "r.room_number, t.start_time, t.end_time " + "FROM timetable t "
						+ "JOIN subjects s ON t.subject_id=s.subject_id " + "JOIN faculty f ON t.faculty_id=f.faculty_id "
						+ "JOIN users u ON f.faculty_id=u.user_id " + "JOIN classrooms r ON t.room_id=r.room_id "
						+ "JOIN students st ON t.class_id=st.class_id " + "WHERE st.student_id=? " + "AND t.day_of_week LIKE ? "
						+ "AND s.subject_name LIKE ? " + "AND u.name LIKE ?";

						PreparedStatement ps = con.prepareStatement(sql);

						ps.setInt(1, user.getUserId());
						ps.setString(2, "%" + (day == null ? "" : day) + "%");
						ps.setString(3, "%" + (subject == null ? "" : subject) + "%");
						ps.setString(4, "%" + (faculty == null ? "" : faculty) + "%");

						ResultSet rs = ps.executeQuery();

						while (rs.next()) {
					%>

					<tr>
						<td><%=rs.getString("day_of_week")%></td>
						<td><%=rs.getString("subject_name")%></td>
						<td><%=rs.getString("faculty_name")%></td>
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

		<div class="card dashboard-card p-4 mb-5">

			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4>⭐ Faculty Feedback</h4>
			</div>

			<form action="../../FeedbackServlet" method="post">

				<div class="row">

					<div class="col-md-6 mb-3">
						<label>Select Faculty</label> <select name="facultyId"
							class="form-control" required>

							<option value="">Choose Faculty</option>

							<%
							try {

								Connection con = DBConnection.getConnection();

								Statement st = con.createStatement();

								ResultSet rs = st
								.executeQuery("SELECT f.faculty_id, u.name FROM faculty f " + "JOIN users u ON f.faculty_id=u.user_id");

								while (rs.next()) {
							%>

							<option value="<%=rs.getInt("faculty_id")%>">
								<%=rs.getString("name")%>
							</option>

							<%
							}
							} catch (Exception e) {
							e.printStackTrace();
							}
							%>

						</select>
					</div>

					<div class="col-md-6 mb-3">
						<label>Select Subject</label> <select name="subject"
							class="form-control" required>

							<option value="">Choose Subject</option>

							<%
							try {

								Connection con = DBConnection.getConnection();

								String sql = "SELECT DISTINCT s.subject_name " + "FROM subjects s "
								+ "JOIN timetable t ON s.subject_id=t.subject_id " + "JOIN students st ON t.class_id=st.class_id "
								+ "WHERE st.student_id=?";

								PreparedStatement ps = con.prepareStatement(sql);

								ps.setInt(1, user.getUserId());

								ResultSet rs = ps.executeQuery();

								while (rs.next()) {
							%>

							<option value="<%=rs.getString("subject_name")%>">
								<%=rs.getString("subject_name")%>
							</option>

							<%
							}
							} catch (Exception e) {
							e.printStackTrace();
							}
							%>

						</select>
					</div>

				</div>

				<div class="mb-3">
					<label>Rating (1-5)</label> <input type="number" name="rating"
						min="1" max="5" class="form-control" required>
				</div>

				<div class="mb-3">
					<label>Feedback</label>
					<textarea name="feedback" class="form-control" rows="4" required></textarea>
				</div>

				<input type="hidden" name="studentId"
					value="<%=user.getUserId()%>">

				<button class="btn btn-success w-100">Submit Feedback</button>

			</form>

		</div>

	</div>

</body>
</html>
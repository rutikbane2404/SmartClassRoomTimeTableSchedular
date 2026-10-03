<%@ page import="java.sql.*, java.util.*, util.DBConnection"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<title>Daily Grid Timetable</title>

<meta charset="UTF-8">

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

.top-banner {
	background: linear-gradient(135deg, #0f172a, #2563eb);
	padding: 35px;
	color: white;
	text-align: center;
	border-bottom-left-radius: 35px;
	border-bottom-right-radius: 35px;
}

.main-container {
	width: 95%;
	margin: auto;
	margin-top: 35px;
}

.search-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	margin-bottom: 30px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
}

.grid-card {
	background: white;
	border-radius: 25px;
	padding: 30px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

.table {
	border-radius: 20px;
	overflow: hidden;
}

.table thead {
	background: #0f172a;
	color: white;
}

.table th {
	text-align: center;
	padding: 20px;
	font-size: 18px;
}

.table td {
	height: 160px;
	vertical-align: middle;
	text-align: center;
	background: #f8fafc;
}

.time-slot {
	font-size: 20px;
	font-weight: 700;
	color: #0f172a;
	width: 220px;
}

.lecture-box {
	background: linear-gradient(135deg, #3b82f6, #2563eb);
	color: white;
	border-radius: 20px;
	padding: 15px;
	margin-bottom: 15px;
	box-shadow: 0 8px 20px rgba(37, 99, 235, 0.25);
}

.subject {
	font-size: 18px;
	font-weight: 700;
}

.faculty {
	margin-top: 8px;
	font-size: 14px;
}

.room {
	margin-top: 5px;
	font-size: 13px;
}

.empty {
	color: #94a3b8;
	font-size: 15px;
}

.search-btn {
	background: #2563eb;
	border: none;
	padding: 12px;
	font-weight: 600;
	border-radius: 12px;
}
</style>

</head>

<body>

	<div class="top-banner">

		<h1>📅 Daily Lecture Grid</h1>

		<p>Search lectures scheduled on specific date</p>

	</div>

	<div class="main-container">

		<div class="search-card">

			<form method="get">

				<div class="row g-3 align-items-end">

					<div class="col-md-4">

						<label class="form-label"> Select Lecture Date </label> <input
							type="date" name="lectureDate" class="form-control"
							value="<%=request.getParameter("lectureDate") != null ? request.getParameter("lectureDate") : java.time.LocalDate.now()%>"
							required>

					</div>

					<div class="col-md-3">

						<button class="btn btn-primary w-100 search-btn">🔍
							Search Grid</button>

					</div>

					<div class="col-md-3">

						<a href="gridDaily.jsp" class="btn btn-dark w-100"> Show Today

						</a>

					</div>

				</div>

			</form>

		</div>

		<div class="grid-card">

			<table class="table table-bordered">

				<thead>

					<tr>

						<th>Time Slot</th>
						<th>Scheduled Lectures</th>

					</tr>

				</thead>

				<tbody>

					<%
					Connection con = DBConnection.getConnection();

					String selectedDate = request.getParameter("lectureDate");

					if (selectedDate == null || selectedDate.isEmpty()) {

						selectedDate = java.time.LocalDate.now().toString();

					}

					String timeQuery =

							"SELECT DISTINCT start_time,end_time " + "FROM daily_timetable " + "WHERE lecture_date=? "
							+ "ORDER BY start_time";

					PreparedStatement pstTime = con.prepareStatement(timeQuery);

					pstTime.setString(1, selectedDate);

					ResultSet rsTime = pstTime.executeQuery();

					boolean hasData = false;

					while (rsTime.next()) {

						hasData = true;

						String startTime = rsTime.getString("start_time");

						String endTime = rsTime.getString("end_time");
					%>

					<tr>

						<td class="time-slot">⏰ <%=startTime%> - <%=endTime%>

						</td>

						<td>
							<%
							String sql =
							"SELECT " +
							"c.class_name, " +
							"s.subject_name, " +
							"u.name AS faculty_name, " +
							"r.room_number " +

							"FROM daily_timetable t " +

							"JOIN classes c ON t.class_id=c.class_id " +
							"JOIN subjects s ON t.subject_id=s.subject_id " +
							"JOIN faculty f ON t.faculty_id=f.faculty_id " +

							"JOIN users u ON f.faculty_id = u.user_id " +  // ✅ FIXED

							"JOIN classrooms r ON t.room_id=r.room_id " +

							"WHERE t.lecture_date=? " +
							"AND t.start_time=? " +
							"AND t.end_time=?";
						
							PreparedStatement ps = con.prepareStatement(sql);

							ps.setString(1, selectedDate);
							ps.setString(2, startTime);
							ps.setString(3, endTime);

							ResultSet rs = ps.executeQuery();

							boolean lectureFound = false;

							while (rs.next()) {

								lectureFound = true;
							%>

							<div class="lecture-box">

								<div class="subject">

									📘
									<%=rs.getString("subject_name")%>

								</div>

								<div class="faculty">

									👨‍🏫
									<%=rs.getString("faculty_name")%>

								</div>

								<div class="room">

									🏫 Room :
									<%=rs.getString("room_number")%>

								</div>

								<div class="mt-2">

									🎓 Class : <b><%=rs.getString("class_name")%></b>

								</div>

							</div> <%
 }

 if (!lectureFound) {
 %>

							<div class="empty">No Lecture</div> <%
 }
 %>

						</td>

					</tr>

					<%
					}

					if (!hasData) {
					%>

					<tr>

						<td colspan="2">

							<div class="empty">

								🚫 No lectures scheduled on <b><%=selectedDate%></b>

							</div>

						</td>

					</tr>

					<%
					}

					con.close();
					%>

				</tbody>

			</table>

		</div>

	</div>

</body>
</html>
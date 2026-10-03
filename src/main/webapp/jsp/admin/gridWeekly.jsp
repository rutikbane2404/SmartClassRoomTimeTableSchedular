<%@ page import="java.sql.*, java.util.*, util.DBConnection"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Weekly Smart Grid Timetable</title>

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
	background: linear-gradient(135deg, #1e3a8a, #2563eb);
	padding: 35px;
	color: white;
	text-align: center;
	border-bottom-left-radius: 35px;
	border-bottom-right-radius: 35px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.top-banner h1 {
	font-weight: 700;
}

.main-container {
	width: 95%;
	margin: auto;
	margin-top: 40px;
}

.grid-card {
	background: white;
	border-radius: 25px;
	padding: 30px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
	animation: fadeUp 0.8s ease;
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
	height: 140px;
	vertical-align: middle;
	text-align: center;
	padding: 15px;
	background: #f8fafc;
}

.lecture-box {
	background: linear-gradient(135deg, #3b82f6, #2563eb);
	color: white;
	border-radius: 18px;
	padding: 15px;
	transition: 0.4s;
	animation: zoomIn 0.5s ease;
	box-shadow: 0 6px 18px rgba(37, 99, 235, 0.25);
}

.lecture-box:hover {
	transform: scale(1.05);
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

.time-slot {
	font-weight: 700;
	color: #0f172a;
	font-size: 20px;
}

.empty {
	color: #94a3b8;
	font-size: 15px;
}

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
keyframes zoomIn {from { opacity:0;
	transform: scale(0.8);
}

to {
	opacity: 1;
	transform: scale(1);
}
}
</style>

</head>

<body>

	<div class="top-banner">

		<h1>📅 Weekly Smart Timetable</h1>

		<p>Dynamic Grid View Based On Admin Lecture Timings</p>

	</div>

	<div class="main-container">

		<div class="grid-card">

			<table class="table table-bordered">

				<thead>

					<tr>

						<th>Time</th>
						<th>MON</th>
						<th>TUE</th>
						<th>WED</th>
						<th>THU</th>
						<th>FRI</th>
						<th>SAT</th>

					</tr>

				</thead>

				<tbody>

					<%
					Connection con = DBConnection.getConnection();

					List<String> timeSlots = new ArrayList<>();

					String timeSql = "SELECT DISTINCT start_time FROM timetable ORDER BY start_time";

					PreparedStatement pstTime = con.prepareStatement(timeSql);

					ResultSet rsTime = pstTime.executeQuery();

					while (rsTime.next()) {

						timeSlots.add(rsTime.getString("start_time"));
					}

					String[] days = { "MON", "TUE", "WED", "THU", "FRI", "SAT" };

					for (String time : timeSlots) {
					%>

					<tr>

						<td class="time-slot">⏰ <%=time%>
						</td>

						<%
						for (String day : days) {

							String sql = "SELECT s.subject_name, u.name, r.room_number, t.end_time " + "FROM timetable t "
							+ "JOIN subjects s ON t.subject_id=s.subject_id " + "JOIN faculty f ON t.faculty_id=f.faculty_id "
							+ "JOIN users u ON f.faculty_id=u.user_id " + "JOIN classrooms r ON t.room_id=r.room_id "
							+ "WHERE t.day_of_week=? AND t.start_time=?";

							PreparedStatement ps = con.prepareStatement(sql);

							ps.setString(1, day);
							ps.setString(2, time);

							ResultSet rs = ps.executeQuery();
						%>

						<td>
							<%
							if (rs.next()) {
							%>

							<div class="lecture-box">

								<div class="subject">
									<%=rs.getString("subject_name")%>
								</div>

								<div class="faculty">
									👨‍🏫
									<%=rs.getString("name")%>
								</div>

								<div class="room">
									🏫 Room
									<%=rs.getString("room_number")%>
								</div>

								<div class="mt-2">
									🕒
									<%=time%>
									-
									<%=rs.getString("end_time")%>
								</div>

							</div> <%
 } else {
 %>

							<div class="empty">No Lecture</div> <%
 }
 %>

						</td>

						<%
						}
						%>

					</tr>

					<%
					}
					%>

				</tbody>

			</table>

		</div>

	</div>

</body>
</html>
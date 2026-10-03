<%@ page
	import="java.util.*, dao.DailyTimeTableDAO, model.DailyTimeTable"%>

<!DOCTYPE html>
<html>
<head>
<title>Daily Timetable</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>

	<div class="container mt-4">

		<h2>Daily Timetable</h2>

		<!-- 🔥 FILTER FORM -->
		<form method="get" class="mb-3">
			<input type="date" name="date" class="form-control w-25 d-inline">
			<button class="btn btn-primary">Filter</button>

			<!-- 🔥 SHOW ALL BUTTON -->
			<a href="viewDaily.jsp" class="btn btn-secondary">Show All</a>
		</form>


		<table class="table table-bordered table-hover">

			<tr class="table-dark">
				<th>No</th>
				<th>Date</th>
				<th>Class</th>
				<th>Subject</th>
				<th>Faculty</th>
				<th>Room</th>
				<th>Time</th>
				<th>Action</th>
			</tr>

			<%
			String selectedDate = request.getParameter("date");

			DailyTimeTableDAO dao = new DailyTimeTableDAO();
			List<DailyTimeTable> list = dao.getAllDaily();

			int count = 1;

			for (DailyTimeTable t : list) {

				// 🔥 CONDITION
				if (selectedDate == null || selectedDate.isEmpty() || selectedDate.equals(t.getLectureDate())) {
			%>

			<tr>
				<td><%=count++%></td>
				<td><%=t.getLectureDate()%></td>
				<td><%=t.getClassName()%></td>
				<td><%=t.getSubjectName()%></td>
				<td><%=t.getFacultyName()%></td>
				<td><%=t.getRoomNumber()%></td>
				<td><%=t.getStartTime()%> - <%=t.getEndTime()%></td>

				<!-- ACTION -->
				<td><a
					href="<%=request.getContextPath()%>/DailyTimeTableServlet?action=edit&id=<%=t.getTimetableId()%>"
					class="btn btn-warning btn-sm">Edit</a> <a
					href="<%=request.getContextPath()%>/DailyTimeTableServlet?action=delete&id=<%=t.getTimetableId()%>"
					class="btn btn-danger btn-sm"
					onclick="return confirm('Delete this record?')">Delete</a></td>
			</tr>

			<%
			}
			}

			if (count == 1) {
			%>
			<tr>
				<td colspan="8" class="text-center text-danger">No records
					found</td>
			</tr>
			<%
			}
			%>

		</table>

	</div>
	</br>
	</br>
	</br>
	</br>
	<center>
		<form action="<%=request.getContextPath()%>/ExportDailyPDFServlet" method="get">
    <input type="date" name="date" required>
    <button class="btn btn-success">Export PDF & Send Email</button>
</form>
</center>

</body>
</html>
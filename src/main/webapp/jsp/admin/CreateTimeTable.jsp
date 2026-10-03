<%@ page import="java.util.*, dao.*, model.*"%>
<%@ page import="dao.ClassDAO"%>
<%@ page import="model.ClassModel"%>
<%@ page import="dao.ClassRoomDAO"%>
<%@ page import="model.Classroom"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Create Timetable</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<script>
	function toggleMode() {
		var mode = document.getElementById("mode").value;

		if (mode === "DAY") {
			document.getElementById("daySection").style.display = "block";
			document.getElementById("weekSection").style.display = "none";
		} else {
			document.getElementById("daySection").style.display = "none";
			document.getElementById("weekSection").style.display = "block";
		}
	}
</script>

</head>

<body>

	<div class="container mt-4">

		<h2>Create Timetable</h2>

		<form action="<%=request.getContextPath()%>/TimeTableServlet"
			method="post">

			<!-- 🔥 MODE -->
			<div class="mb-3">
				<label>Mode</label> <select name="mode" id="mode"
					class="form-control" onchange="toggleMode()">
					<option value="DAY">Day Wise</option>
					<option value="WEEK">Week Wise</option>
				</select>
			</div>

			<!-- 🔥 DAY SECTION -->
			<div id="daySection" class="mb-3">
				<label>Date</label> <input type="date" name="lectureDate"
					class="form-control"> 
					
			</div>

			<!-- 🔥 WEEK SECTION -->
			<div id="weekSection" class="mb-3" style="display: none;">
				<label>Day</label> <select name="day" class="form-control">
					<option>MON</option>
					<option>TUE</option>
					<option>WED</option>
					<option>THU</option>
					<option>FRI</option>
					<option>SAT</option>
				</select>
			</div>

			<!-- 🔥 CLASS -->
			<div class="mb-3">
				<label>Class</label> <select name="classId" class="form-control">
					<%
					ClassDAO cdao = new ClassDAO();
					List<ClassModel> classes = cdao.getAllClasses();

					for (ClassModel c : classes) {
					%>
					<option value="<%=c.getClassId()%>">
						<%=c.getClassName()%>
					</option>
					<%
					}
					%>
				</select>
			</div>

			<!-- 🔥 SUBJECT -->
			<div class="mb-3">
				<label>Subject</label> <select name="subjectId" class="form-control">
					<%
					SubjectDAO sdao = new SubjectDAO();
					List<Subject> subjects = sdao.getAllSubjects();

					for (Subject s : subjects) {
					%>
					<option value="<%=s.getSubjectId()%>">
						<%=s.getSubjectName()%>
					</option>
					<%
					}
					%>
				</select>
			</div>

			<!-- 🔥 FACULTY -->
			<div class="mb-3">
				<label>Faculty</label> <select name="facultyId" class="form-control">
					<%
					FacultyDAO fdao = new FacultyDAO();
					List<Faculty> faculty = fdao.getAllFaculty();

					for (Faculty f : faculty) {
					%>
					<option value="<%=f.getFacultyId()%>">
						<%=f.getName()%>
					</option>
					<%
					}
					%>
				</select>
			</div>

			<!-- 🔥 ROOM -->
			<div class="mb-3">
				<label>Room</label> <select name="roomId" class="form-control">
					<%
					ClassRoomDAO rdao = new ClassRoomDAO();
					List<Classroom> rooms = rdao.getAllRooms();

					for (Classroom r : rooms) {
					%>
					<option value="<%=r.getRoomId()%>">
						<%=r.getRoomNumber()%>
					</option>
					<%
					}
					%>
				</select>
			</div>

			<!-- 🔥 TIME -->
			<div class="mb-3">
<label>Start Time</label>
<input type="time" name="startTime" class="form-control" required>
</div>

<div class="mb-3">
<label>End Time</label>
<input type="time" name="endTime" class="form-control" required>
</div>

			<button class="btn btn-primary">Create Timetable</button>

		</form>

	</div>

</body>
</html>
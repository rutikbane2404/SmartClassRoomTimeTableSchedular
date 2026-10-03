<%@ page import="model.*, dao.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Edit Daily Timetable</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

<h2>Edit Daily Timetable</h2>

<%
    DailyTimeTable t = (DailyTimeTable) request.getAttribute("timetable");
%>

<!-- 🔥 ERROR MESSAGE -->
<%
String error = request.getParameter("error");
if(error != null){
    error = java.net.URLDecoder.decode(error, "UTF-8");
%>
<div class="alert alert-danger">
    ❌ <%= error %>
</div>
<%
}
%>

<form action="<%=request.getContextPath()%>/DailyTimeTableServlet" method="post">

<!-- HIDDEN ID -->
<input type="hidden" name="timetableId" value="<%=t.getTimetableId()%>">

<!-- DATE -->
<div class="mb-3">
<label>Date</label>
<input type="date" name="lectureDate" value="<%=t.getLectureDate()%>" class="form-control" required>
</div>

<!-- CLASS -->
<div class="mb-3">
<label>Class</label>
<select name="classId" class="form-control">
<%
    ClassDAO cdao = new ClassDAO();
    List<ClassModel> classes = cdao.getAllClasses();

    for(ClassModel c : classes){
%>
<option value="<%=c.getClassId()%>" <%=c.getClassId()==t.getClassId()?"selected":""%>>
    <%=c.getClassName()%>
</option>
<% } %>
</select>
</div>

<!-- SUBJECT -->
<div class="mb-3">
<label>Subject</label>
<select name="subjectId" class="form-control">
<%
    SubjectDAO sdao = new SubjectDAO();
    List<Subject> subjects = sdao.getAllSubjects();

    for(Subject s : subjects){
%>
<option value="<%=s.getSubjectId()%>" <%=s.getSubjectId()==t.getSubjectId()?"selected":""%>>
    <%=s.getSubjectName()%>
</option>
<% } %>
</select>
</div>

<!-- FACULTY -->
<div class="mb-3">
<label>Faculty</label>
<select name="facultyId" class="form-control">
<%
    FacultyDAO fdao = new FacultyDAO();
    List<Faculty> faculty = fdao.getAllFaculty();

    for(Faculty f : faculty){
%>
<option value="<%=f.getFacultyId()%>" <%=f.getFacultyId()==t.getFacultyId()?"selected":""%>>
    <%=f.getName()%>
</option>
<% } %>
</select>
</div>

<!-- ROOM -->
<div class="mb-3">
<label>Room</label>
<select name="roomId" class="form-control">
<%
    ClassRoomDAO rdao = new ClassRoomDAO();
    List<Classroom> rooms = rdao.getAllRooms();

    for(Classroom r : rooms){
%>
<option value="<%=r.getRoomId()%>" <%=r.getRoomId()==t.getRoomId()?"selected":""%>>
    <%=r.getRoomNumber()%>
</option>
<% } %>
</select>
</div>

<!-- TIME -->
<div class="mb-3">
<label>Start Time</label>
<input type="time" name="startTime" value="<%=t.getStartTime()%>" class="form-control" required>
</div>

<div class="mb-3">
<label>End Time</label>
<input type="time" name="endTime" value="<%=t.getEndTime()%>" class="form-control" required>
</div>

<button class="btn btn-warning">Update</button>

</form>

</div>

</body>
</html>
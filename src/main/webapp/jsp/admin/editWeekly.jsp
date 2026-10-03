<%@ page import="model.*, dao.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Edit Weekly Timetable</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

<h2>Edit Weekly Timetable</h2>

<%
    WeeklyTimeTable t = (WeeklyTimeTable) request.getAttribute("timetable");
%>

<form action="<%=request.getContextPath()%>/WeeklyTimeTableServlet" method="post">

<!-- HIDDEN ID -->
<input type="hidden" name="timetableId" value="<%=t.getTimetableId()%>">

<!-- DAY -->
<div class="mb-3">
<label>Day</label>
<select name="day" class="form-control">
    <option <%= t.getDayOfWeek().equals("MON") ? "selected" : "" %>>MON</option>
    <option <%= t.getDayOfWeek().equals("TUE") ? "selected" : "" %>>TUE</option>
    <option <%= t.getDayOfWeek().equals("WED") ? "selected" : "" %>>WED</option>
    <option <%= t.getDayOfWeek().equals("THU") ? "selected" : "" %>>THU</option>
    <option <%= t.getDayOfWeek().equals("FRI") ? "selected" : "" %>>FRI</option>
    <option <%= t.getDayOfWeek().equals("SAT") ? "selected" : "" %>>SAT</option>
</select>
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
<input type="time" name="startTime" value="<%=t.getStartTime()%>" class="form-control">
</div>

<div class="mb-3">
<label>End Time</label>
<input type="time" name="endTime" value="<%=t.getEndTime()%>" class="form-control">
</div>

<button class="btn btn-warning">Update</button>

</form>

</div>

</body>
</html>
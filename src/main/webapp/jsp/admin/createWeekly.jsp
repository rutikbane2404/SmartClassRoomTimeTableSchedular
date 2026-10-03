<%@ page import="java.util.*, dao.*, model.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.User" %>

<%
User user = (User) session.getAttribute("user");

if(user == null || !user.getRole().equals("ADMIN")){

    response.sendRedirect("../auth/Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Create Weekly Timetable</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

<h2>Create Weekly Timetable</h2>

<form action="<%=request.getContextPath()%>/WeeklyTimeTableServlet" method="post">

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

<!-- DAY -->
<div class="mb-3">
<label>Day</label>
<select name="day" class="form-control">
    <option>MON</option>
    <option>TUE</option>
    <option>WED</option>
    <option>THU</option>
    <option>FRI</option>
    <option>SAT</option>
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
<option value="<%= c.getClassId() %>"><%= c.getClassName() %></option>
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
<option value="<%= s.getSubjectId() %>"><%= s.getSubjectName() %></option>
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
<option value="<%= f.getFacultyId() %>"><%= f.getName() %></option>
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
<option value="<%= r.getRoomId() %>"><%= r.getRoomNumber() %></option>
<% } %>
</select>
</div>

<!-- TIME -->
<div class="mb-3">
<label>Start Time</label>
<input type="time" name="startTime" class="form-control" required>
</div>

<div class="mb-3">
<label>End Time</label>
<input type="time" name="endTime" class="form-control" required>
</div>

<button class="btn btn-success">Create Weekly</button>

</form>

</div>

</body>
</html>
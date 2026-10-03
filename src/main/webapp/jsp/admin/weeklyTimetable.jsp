<%@ page import="java.util.*, dao.TimeTableDAO, model.TimeTable" %>

<!DOCTYPE html>
<html>
<head>
<title>Weekly Timetable</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

<h2>Weekly Timetable</h2>

<%
String error = request.getParameter("error");
if(error != null){
%>
<div class="alert alert-danger">
    ❌ <%= error %>
</div>
<%
}
%>

<!-- 🔥 DAY FILTER -->
<form method="get">
    <select name="day">
        <option>MON</option>
        <option>TUE</option>
        <option>WED</option>
        <option>THU</option>
        <option>FRI</option>
        <option>SAT</option>
    </select>
    <button class="btn btn-primary">View</button>
</form>

<hr>

<table class="table table-bordered">

<tr class="table-dark">
    <th>Class</th>
    <th>Subject</th>
    <th>Faculty</th>
    <th>Room</th>
    <th>Time</th>
</tr>

<%
    String selectedDay = request.getParameter("day");

    if(selectedDay != null){

        TimeTableDAO dao = new TimeTableDAO();
        List<TimeTable> list = dao.getAllTimeTable();

        for(TimeTable t : list){

            if(selectedDay.equals(t.getDayOfWeek())){
%>

<tr>
    <td><%= t.getClassName() %></td>
    <td><%= t.getSubjectName() %></td>
    <td><%= t.getFacultyName() %></td>
    <td><%= t.getRoomNumber() %></td>
    <td><%= t.getStartTime() %> - <%= t.getEndTime() %></td>
</tr>

<%
            }
        }
    }
%>

</table>

</div>

</body>
</html>
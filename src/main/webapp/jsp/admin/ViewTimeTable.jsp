<%@ page import="java.util.*, dao.TimeTableDAO, model.TimeTable" %>

<!DOCTYPE html>
<html>
<head>
<title>View Timetable</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

<h2>Weekly Timetable</h2>

<table class="table table-bordered table-hover mt-3">

<tr class="table-dark">
    <th>No</th>
    <th>Class</th>
    <th>Subject</th>
    <th>Faculty</th>
    <th>Room</th>
    <th>Day</th>
    <th>Time</th>
</tr>

<%
    TimeTableDAO dao = new TimeTableDAO();
    List<TimeTable> list = dao.getAllTimeTable();

    int count = 1;

    for(TimeTable t : list){
%>
<tr>
    <td><%= count++ %></td>
    <td><%= t.getClassName() %></td>
    <td><%= t.getSubjectName() %></td>
    <td><%= t.getFacultyName() %></td>
    <td><%= t.getRoomNumber() %></td>
    <td><%= t.getDayOfWeek() %></td>
    <td><%= t.getStartTime() %> - <%= t.getEndTime() %></td>
</tr>
<%
    }
%>

</table>

</div>

</body>
</html>
<%@ page import="java.util.*, dao.WeeklyTimeTableDAO, model.WeeklyTimeTable" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Weekly Timetable</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

<h2>Weekly Timetable</h2>

<!-- 🔥 FILTER FORM -->
<form method="get" class="mb-3">
    <select name="day" class="form-control w-25 d-inline">
        <option value="">All Days</option>
        <option>MON</option>
        <option>TUE</option>
        <option>WED</option>
        <option>THU</option>
        <option>FRI</option>
        <option>SAT</option>
    </select>
    <button class="btn btn-primary">Filter</button>

    <!-- 🔥 SHOW ALL -->
    <a href="viewWeekly.jsp" class="btn btn-secondary">Show All</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="../../ExportWeeklyPDFServlet"
class="btn btn-danger">

📄 Export PDF & Send Email

</a>
</form>

<table class="table table-bordered table-hover">

<tr class="table-dark">
    <th>No</th>
    <th>Day</th>
    <th>Class</th>
    <th>Subject</th>
    <th>Faculty</th>
    <th>Room</th>
    <th>Time</th>
    <th>Action</th>
</tr>

<%
    String selectedDay = request.getParameter("day");

    WeeklyTimeTableDAO dao = new WeeklyTimeTableDAO();
    List<WeeklyTimeTable> list = dao.getAllWeekly();

    int count = 1;

    for(WeeklyTimeTable t : list){

        // 🔥 CONDITION
        if(selectedDay == null || selectedDay.isEmpty() || selectedDay.equals(t.getDayOfWeek())){
%>

<tr>
    <td><%= count++ %></td>
    <td><%= t.getDayOfWeek() %></td>
    <td><%= t.getClassName() %></td>
    <td><%= t.getSubjectName() %></td>
    <td><%= t.getFacultyName() %></td>
    <td><%= t.getRoomNumber() %></td>
    <td><%= t.getStartTime() %> - <%= t.getEndTime() %></td>

    <!-- ACTION -->
    <td>
        <a href="<%=request.getContextPath()%>/WeeklyTimeTableServlet?action=edit&id=<%=t.getTimetableId()%>"
           class="btn btn-warning btn-sm">Edit</a>

        <a href="<%=request.getContextPath()%>/WeeklyTimeTableServlet?action=delete&id=<%=t.getTimetableId()%>"
           class="btn btn-danger btn-sm"
           onclick="return confirm('Delete this record?')">Delete</a>
    </td>
</tr>

<%
        }
    }

    if(count == 1){
%>
<tr>
<td colspan="8" class="text-center text-danger">No records found</td>
</tr>
<%
    }
%>

</table>

</div></br></br></br></br></br></br></br></br></br>

<center></center>

</body>
</html>
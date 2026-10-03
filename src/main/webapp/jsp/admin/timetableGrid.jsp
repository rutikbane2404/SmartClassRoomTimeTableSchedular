<%@ page import="java.util.*, dao.TimeTableDAO, model.TimeTable" %>

<!DOCTYPE html>
<html>
<head>
<title>Timetable Grid</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
td {
    height: 80px;
    vertical-align: middle;
    text-align: center;
}
</style>
</head>

<body>

<div class="container mt-4">

<h2>Weekly Timetable (Grid)</h2>

<%
    TimeTableDAO dao = new TimeTableDAO();
    List<TimeTable> list = dao.getAllTimeTable();

    String[] days = {"MON","TUE","WED","THU","FRI","SAT"};
    String[] slots = {"09:00:00","10:00:00","11:00:00","12:00:00"};
%>

<table class="table table-bordered">

<tr class="table-dark">
    <th>Time</th>
    <% for(String d : days){ %>
        <th><%= d %></th>
    <% } %>
</tr>

<%
for(int i=0; i<slots.length; i++){
%>

<tr>
    <td><%= slots[i] %></td>

<%
    for(String d : days){

        String cellData = "";

        for(TimeTable t : list){

            if(t.getDayOfWeek().equals(d) && t.getStartTime().equals(slots[i])){

                cellData = t.getSubjectName() + "<br>" +
                           t.getFacultyName() + "<br>" +
                           t.getRoomNumber();

                break;
            }
        }
%>

<td><%= cellData %></td>

<%
    }
%>

</tr>

<%
}
%>

</table>

</div>

</body>
</html>
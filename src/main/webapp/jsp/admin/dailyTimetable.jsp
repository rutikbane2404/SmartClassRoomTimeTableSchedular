<%@ page import="java.util.*, dao.TimeTableDAO, model.TimeTable" %>

<!DOCTYPE html>
<html>
<head>
    <title>Daily Timetable</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

    <h2 class="mb-4">Daily Timetable</h2>

    <!-- 🔥 DATE SELECTION FORM -->
    <form method="get" class="mb-3">
        <label>Select Date:</label>
        <input type="date" name="date" required class="form-control w-25 d-inline">
        <button type="submit" class="btn btn-primary">View</button>
    </form>

    <!-- 🔥 TABLE -->
    <table class="table table-bordered table-hover">

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
    String selectedDate = request.getParameter("date");

    if(selectedDate != null){

        TimeTableDAO dao = new TimeTableDAO();
        List<TimeTable> list = dao.getAllTimeTable();

        int count = 1;

        for(TimeTable t : list){

            // 🔥 FILTER BY DATE
            if(t.getLectureDate() != null && selectedDate.equals(t.getLectureDate())){
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
        }

        if(count == 1){
%>
        <tr>
            <td colspan="7" class="text-center text-danger">No timetable found for selected date</td>
        </tr>
<%
        }

    } else {
%>
        <tr>
            <td colspan="7" class="text-center text-muted">Please select a date</td>
        </tr>
<%
    }
%>

    </table>

</div>

</body>
</html>
<%@ page import="java.util.*, model.RoomUtilization"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Room Utilization</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body class="bg-light">

<form action="<%=request.getContextPath()%>/GenerateRoomReportServlet"
      method="get"
      class="text-center mt-5">

    <button type="submit"
            class="btn btn-dark btn-lg px-5"
            id="reportBtn">

        📄 Generate Analytics Report

    </button>

</form>

<script>

document.querySelector("form").addEventListener("submit", function(){

    let btn = document.getElementById("reportBtn");

    btn.innerHTML = "⏳ Generating Report...";
    btn.disabled = true;

});

</script>

	<div class="container mt-4">

		<h2 class="mb-3">🏫 Room Utilization Analytics</h2>

		<a href="<%= request.getContextPath() %>/jsp/admin/AdminDashboard.jsp" class="btn btn-secondary mb-3">⬅ Back</a>

		<table class="table table-bordered table-striped text-center">
			<thead class="table-dark">
				<tr>
					<th>Room</th>
					<th>Weekly</th>
					<th>Daily</th>
					<th>Total</th>
					<th>Utilization %</th>
				</tr>
			</thead>

			<tbody>

				<%
				List<RoomUtilization> list = (List<RoomUtilization>) request.getAttribute("roomList");

				if (list == null || list.isEmpty()) {
				%>
				<tr>
					<td colspan="5">No Data Found</td>
				</tr>
				<%
				} else {
				for (RoomUtilization r : list) {
				%>

				<tr>
					<td><%=r.getRoomName()%></td>
					<td><%=r.getWeeklyLectures()%></td>
					<td><%=r.getDailyLectures()%></td>
					<td><%=r.getTotalLectures()%></td>

					<td
						style="
    <%=r.getUtilizationPercent() > 70
		? "color:red;font-weight:bold"
		: r.getUtilizationPercent() > 40 ? "color:orange;font-weight:bold" : "color:green;"%>
    ">
						<%=String.format("%.2f", r.getUtilizationPercent())%>%
					</td>
				</tr>

				<%
				}
				}
				%>

			</tbody>
		</table>

		<!-- PIE CHART -->
		<div style="width: 400px; margin: auto;">
			<canvas id="pieChart"></canvas>
		</div>

	</div>

	<script>

const labels = [
<%if (list != null) {
	for (RoomUtilization r : list) {%>
"<%=r.getRoomName()%>",
<%}
}%>
];

const data = [
<%if (list != null) {
	for (RoomUtilization r : list) {%>
<%=r.getTotalLectures()%>,
<%}
}%>
];

new Chart(document.getElementById('pieChart'), {
    type: 'pie',
    data: {
        labels: labels,
        datasets: [{
            data: data
        }]
    }
});
</script>

</br>

<h4 class="mt-5">⏱ Room Time Utilization</h4>

<table class="table table-bordered table-striped text-center">
<tr>
    <th>Room</th>
    <th>Weekly Hours</th>
    <th>Daily Hours</th>
    <th>Total Hours</th>
    <th>Utilization %</th>
</tr>

<%
for(RoomUtilization r : list){
%>
<tr>
    <td><%= r.getRoomName() %></td>
    <td><%= r.getWeeklyHours() %></td>
    <td><%= r.getDailyHours() %></td>
    <td><%= r.getTotalHours() %></td>

    <td style="<%= r.getUtilizationPercent()>70?"color:red;font-weight:bold":"" %>">
        <%= String.format("%.2f", r.getUtilizationPercent()) %>%
    </td>
</tr>
<% } %>
</table>

</br></br>

<h4 class="mt-4">📊 Time Utilization Chart</h4>
<canvas id="timeChart" height="120"></canvas>

<!-- BAR CHART FOR TIME UTILIZATION -->
<div style="width: 500px; margin: 40px auto;">
    <canvas id="timeChart"></canvas>
</div>

<script>

const timeLabels = [
<% if(list != null){
    for(RoomUtilization r : list){ %>
        "<%= r.getRoomName() %>",
<%  }
} %>
];

const timeData = [
<% if(list != null){
    for(RoomUtilization r : list){ %>
        <%= r.getTotalHours() %>,
<%  }
} %>
];

new Chart(document.getElementById('timeChart'), {
    type: 'bar',
    data: {
        labels: timeLabels,
        datasets: [{
            label: 'Total Hours Used',
            data: timeData,
            barPercentage: 0.5,        // 👈 controls bar width inside category
            categoryPercentage: 1    // 👈 controls space between bars
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

</script>

</body>
</html>
<%@ page import="java.util.*, model.FacultyWorkload" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Faculty Workload Analytics</title>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f4f6f9;
        }

        .card {
            border-radius: 15px;
        }
    </style>
</head>

<body>

<div class="container mt-4">

    <h2 class="mb-4">📊 Faculty Workload Analytics</h2>

    <a href="<%= request.getContextPath() %>/jsp/admin/AdminDashboard.jsp"
   class="btn btn-secondary mb-3">
   ⬅ Back to Dashboard
</a>

    <%
    List<FacultyWorkload> workloadList =
        (List<FacultyWorkload>) request.getAttribute("workloadList");
    %>

    <div class="card p-3 shadow">

        <table class="table table-bordered mt-2">
            <thead class="table-dark">
                <tr>
                    <th>Faculty</th>
                    <th>Total Lectures</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>

            <%
            if(workloadList != null){
                for(FacultyWorkload f : workloadList){
            %>

                <tr>
                    <td><%= f.getFacultyName() %></td>
                    <td><%= f.getLectureCount() %></td>

                    <td>
                        <%
                        if(f.getStatus().equals("Overloaded")){
                        %>
                            <span class="badge bg-danger">Overloaded</span>
                        <%
                        } else if(f.getStatus().equals("Underutilized")){
                        %>
                            <span class="badge bg-primary">Underutilized</span>
                        <%
                        } else {
                        %>
                            <span class="badge bg-success">Balanced</span>
                        <%
                        }
                        %>
                    </td>
                </tr>

            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="3" class="text-center">No Data Found</td>
                </tr>
            <%
            }
            %>

            </tbody>
        </table>

    </div>

</div>

<div class="card mt-4 p-3 shadow">
    <h5>📊 Faculty Workload Analysis</h5>
    <canvas id="workloadChart" height="100"></canvas>
</div>

<script>
    let facultyNames = [];
    let lectureCounts = [];

    <% for(FacultyWorkload f : workloadList){ %>
        facultyNames.push("<%= f.getFacultyName() %>");
        lectureCounts.push(<%= f.getLectureCount() %>);
    <% } %>
</script>

<script>
    const ctx = document.getElementById('workloadChart').getContext('2d');

    const workloadChart = new Chart(ctx, {
        type: 'bar', // bar chart
        data: {
            labels: facultyNames,
            datasets: [{
                label: 'Lectures Assigned',
                data: lectureCounts,
                backgroundColor: 'rgba(54, 162, 235, 0.6)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true
                },
                title: {
                    display: true,
                    text: 'Faculty Workload Distribution'
                }
            },
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
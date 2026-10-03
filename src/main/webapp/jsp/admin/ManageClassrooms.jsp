<%@ page import="java.util.*,dao.ClassRoomDAO,model.Classroom"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<title>Manage Classrooms</title>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">

<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
* {
	font-family: 'Poppins', sans-serif;
}

body {
	background: #eef2f7;
}

.main-container {
	padding: 35px;
}

.top-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.page-title {
	font-size: 40px;
	font-weight: 700;
	color: #0f172a;
}

.page-subtitle {
	color: #64748b;
	margin-top: 8px;
}

.top-btn {
	background: #16a34a;
	color: white;
	text-decoration: none;
	padding: 12px 22px;
	border-radius: 12px;
	font-weight: 600;
	transition: 0.3s;
}

.top-btn:hover {
	background: #15803d;
	color: white;
	transform: translateY(-2px);
}

.content-card {
	background: white;
	border-radius: 20px;
	padding: 30px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.table {
	overflow: hidden;
	border-radius: 15px;
}

.table thead {
	background: #0f172a;
	color: white;
}

.table th {
	padding: 16px;
}

.table td {
	vertical-align: middle;
	padding: 15px;
}

.action-btn {
	border: none;
	padding: 8px 16px;
	border-radius: 8px;
	font-weight: 500;
}

.edit-btn {
	background: #facc15;
	color: black;
}

.delete-btn {
	background: #ef4444;
	color: white;
}

.search-box {
	width: 300px;
	height: 50px;
	border-radius: 12px;
	border: 1px solid #cbd5e1;
	padding-left: 15px;
}

.info-card {
	background: linear-gradient(135deg, #2563eb, #1d4ed8);
	color: white;
	padding: 25px;
	border-radius: 18px;
	margin-bottom: 25px;
}

.info-card h4 {
	font-weight: 700;
}
</style>

</head>

<body>

	<div class="container-fluid main-container">

		<div class="top-header">

			<div>

				<h1 class="page-title">🏫 Manage Classrooms</h1>

				<p class="page-subtitle">View, edit and manage classroom
					availability and capacity</p>

			</div>

			<div>

				<input type="text" placeholder="Search classrooms..."
					class="search-box me-3"> <a href="AddClassroom.jsp"
					class="top-btn"> ➕ Add Classroom </a>

			</div>

		</div>

		<div class="info-card">

			<h4>Smart Classroom Management</h4>

			<p class="mb-0">Manage room numbers, seating capacity and
				classroom records efficiently.</p>

		</div>

		<div class="content-card">

			<h4 class="mb-4">📋 Classroom Records</h4>

			<table class="table table-hover align-middle">

				<thead>

					<tr>
						<th>Sr.No</th>
						<th>Room Number</th>
						<th>Capacity</th>
						<th>Room Status</th>
						<th>Actions</th>
					</tr>

				</thead>

				<tbody>

					<%
					ClassRoomDAO dao = new ClassRoomDAO();

					List<Classroom> list = dao.getAllRooms();

					int count = 1;

					for (Classroom c : list) {
					%>

					<tr>

						<td><%=count++%></td>

						<td><strong> <%=c.getRoomNumber()%>
						</strong></td>

						<td><span class="badge bg-primary p-2"> <%=c.getCapacity()%>
								Seats

						</span></td>

						<td><span class="badge bg-success p-2"> Available </span></td>

						<td>

							<div class="d-flex gap-2">

								<form action="editClassroom.jsp" method="get">

									<input type="hidden" name="id" value="<%=c.getRoomId()%>">

									<button class="action-btn edit-btn">✏ Edit</button>

								</form>

								<form action="../../ClassroomServlet" method="post">

									<input type="hidden" name="action" value="delete"> <input
										type="hidden" name="id" value="<%=c.getRoomId()%>">

									<button class="action-btn delete-btn">🗑 Delete</button>

								</form>

							</div>

						</td>

					</tr>

					<%
					}
					%>

				</tbody>

			</table>

		</div>

	</div>

</body>
</html>
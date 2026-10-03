<%@ page import="model.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
User user = (User) session.getAttribute("user");

if (user == null || !user.getRole().equals("ADMIN")) {

	response.sendRedirect("../auth/Login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Add Faculty</title>

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
	padding: 40px;
}

.page-header {
	background: white;
	border-radius: 20px;
	padding: 30px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

.page-title {
	font-size: 38px;
	font-weight: 700;
	color: #0f172a;
}

.page-subtitle {
	color: #64748b;
	margin-top: 10px;
}

.form-card {
	background: white;
	border-radius: 20px;
	padding: 35px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.form-label {
	font-weight: 600;
	color: #334155;
}

.form-control {
	height: 55px;
	border-radius: 12px;
	border: 1px solid #dbeafe;
}

.form-control:focus {
	box-shadow: none;
	border-color: #2563eb;
}

.btn-save {
	background: #2563eb;
	color: white;
	border: none;
	padding: 14px;
	border-radius: 12px;
	font-weight: 600;
	width: 100%;
	transition: 0.3s;
}

.btn-save:hover {
	background: #1d4ed8;
	transform: translateY(-2px);
}

.top-actions {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.back-btn {
	text-decoration: none;
	background: #0f172a;
	color: white;
	padding: 10px 18px;
	border-radius: 10px;
	transition: 0.3s;
}

.back-btn:hover {
	background: #1e293b;
	color: white;
}

.alert {
	border-radius: 12px;
}

.info-box {
	background: #eff6ff;
	border-left: 5px solid #2563eb;
	padding: 15px;
	border-radius: 10px;
	margin-bottom: 25px;
}
</style>

</head>

<body>

	<div class="container-fluid main-container">

		<div class="top-actions">

			<div>

				<h2 class="page-title">👨‍🏫 Add Faculty</h2>

				<p class="page-subtitle">Create and register faculty members
					into the SmartClass system</p>

			</div>

			<a href="ManageFaculty.jsp" class="back-btn"> ← Back to Faculty </a>

		</div>

		<%
		String success = request.getParameter("success");
		String error = request.getParameter("error");

		if (success != null) {
		%>

		<div class="alert alert-success">✅ Faculty added successfully.</div>

		<%
		}

		if (error != null) {
		%>

		<div class="alert alert-danger">❌ Failed to add faculty.</div>

		<%
		}
		%>

		<div class="row justify-content-center">

			<div class="col-lg-8">

				<div class="form-card">

					<div class="info-box">

						<strong>NOTE:</strong> Faculty account credentials will
						automatically be stored inside the login system and faculty
						management module.

					</div>

					<form action="<%=request.getContextPath()%>/FacultyServlet"
						method="post">

						<input type="hidden" name="action" value="add">

						<div class="row">

							<div class="col-md-6 mb-4">

								<label class="form-label"> Faculty Name </label> <input
									type="text" name="name" class="form-control"
									placeholder="Enter faculty name" required>

							</div>

							<div class="col-md-6 mb-4">

								<label class="form-label"> Email Address </label> <input
									type="email" name="email" class="form-control"
									placeholder="Enter faculty email" required>

							</div>

						</div>

						<div class="row">

							<div class="col-md-6 mb-4">

								<label class="form-label"> Password </label> <input
									type="password" name="password" class="form-control"
									placeholder="Create password" required>

							</div>

							<div class="col-md-6 mb-4">

								<label class="form-label"> Department </label> <input
									type="text" name="department" class="form-control"
									placeholder="Enter department" required>

							</div>

						</div>

						<div class="mt-3">

							<button class="btn-save">➕ Register Faculty</button>

						</div>

					</form>

				</div>

			</div>

		</div>

	</div>

</body>
</html>
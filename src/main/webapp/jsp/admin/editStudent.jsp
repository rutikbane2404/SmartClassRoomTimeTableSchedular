<%@ page import="model.*,dao.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
String idStr = request.getParameter("id");

if (idStr == null) {
    response.sendRedirect("ManageStudent.jsp");
    return;
}

int id = Integer.parseInt(idStr);

StudentDAO dao = new StudentDAO();
Student s = dao.getStudentById(id);

ClassDAO cdao = new ClassDAO();
List<ClassModel> classList = cdao.getAllClasses();

if(s == null){
    out.println("<h3 class='text-danger text-center'>Student not found</h3>");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Edit Student</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #f4f6f9;
}

.card {
    border-radius: 12px;
}

.form-control, .form-select {
    border-radius: 8px;
}

.btn {
    border-radius: 8px;
}

.header-title {
    font-weight: 600;
    color: #2c3e50;
}
</style>

</head>

<body>

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card shadow p-4">

                <h3 class="mb-4 text-center header-title">Edit Student</h3>

                <form action="../../StudentServlet" method="post">

                    <!-- Hidden -->
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= s.getStudentId() %>">

                    <!-- Name -->
                    <div class="mb-3">
                        <label class="form-label">Student Name</label>
                        <input type="text" name="name" class="form-control"
                               value="<%= s.getName() %>" required>
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control"
                               value="<%= s.getEmail() %>" required>
                    </div>

                    <!-- Phone -->
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" class="form-control"
                               value="<%= s.getPhone() %>" required>
                    </div>

                    <!-- Class Dropdown (FIXED) -->
                    <div class="mb-4">
                        <label class="form-label">Class</label>
                        <select name="classId" class="form-select" required>

                            <option value="">-- Select Class --</option>

                            <% for(ClassModel c : classList){ %>
                                <option value="<%= c.getClassId() %>"
                                    <%= (c.getClassId() == s.getClassId()) ? "selected" : "" %>>
                                    <%= c.getClassName() %>
                                </option>
                            <% } %>

                        </select>
                    </div>

                    <!-- Buttons -->
                    <div class="d-flex justify-content-between">

                        <a href="ManageStudent.jsp" class="btn btn-secondary">
                            Cancel
                        </a>

                        <button type="submit" class="btn btn-primary">
                            Update Student
                        </button>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>

</body>
</html>
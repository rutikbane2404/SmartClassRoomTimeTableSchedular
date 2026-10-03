<%@ page import="java.util.*, dao.FacultyDAO, model.Faculty" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Faculty</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styling -->
    <style>
        body {
            background: #f4f6f9;
        }

        .card {
            border-radius: 12px;
        }

        .form-control {
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

<%
    String idStr = request.getParameter("id");

    if(idStr == null || idStr.isEmpty()){
        out.println("<h3 class='text-danger text-center'>Invalid Faculty ID</h3>");
        return;
    }

    int id = Integer.parseInt(idStr);

    FacultyDAO dao = new FacultyDAO();
    List<Faculty> list = dao.getAllFaculty();

    Faculty faculty = null;

    for(Faculty f : list){
        if(f.getFacultyId() == id){
            faculty = f;
            break;
        }
    }

    if(faculty == null){
        out.println("<h3 class='text-danger text-center'>Faculty not found</h3>");
        return;
    }
%>

    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow p-4">

                <h3 class="mb-4 text-center header-title">Edit Faculty</h3>

                <form action="../../FacultyServlet" method="post">

                    <!-- Hidden Fields -->
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= faculty.getFacultyId() %>">

                    <!-- Name -->
                    <div class="mb-3">
                        <label class="form-label">Faculty Name</label>
                        <input type="text" 
                               name="name" 
                               class="form-control"
                               value="<%= faculty.getName() %>" 
                               required>
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" 
                               name="email" 
                               class="form-control"
                               value="<%= faculty.getEmail() %>" 
                               required>
                    </div>

                    <!-- Department -->
                    <div class="mb-4">
                        <label class="form-label">Department</label>
                        <input type="text" 
                               name="department" 
                               class="form-control"
                               value="<%= faculty.getDepartment() %>" 
                               required>
                    </div>

                    <!-- Buttons -->
                    <div class="d-flex justify-content-between">

                        <a href="ManageFaculty.jsp" class="btn btn-secondary">
                            Cancel
                        </a>

                        <button type="submit" class="btn btn-primary">
                            Update Faculty
                        </button>

                    </div>

                </form>

            </div>

        </div>
    </div>

</div>

</body>
</html>
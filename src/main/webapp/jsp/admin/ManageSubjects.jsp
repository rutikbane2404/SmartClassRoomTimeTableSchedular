<%@ page import="java.util.*, dao.SubjectDAO, dao.FacultyDAO, model.Subject, model.Faculty" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Subjects</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">

    <h2 class="mb-4">Manage Subjects</h2>

    <%
        FacultyDAO fdao = new FacultyDAO();
        List<Faculty> faculties = fdao.getAllFaculty();
    %>

    <!-- ADD SUBJECT FORM -->
    <div class="card p-3 mb-4">
        <h4>Add Subject</h4>

        <form action="../../SubjectServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="row">
                <div class="col-md-3">
                    <input type="text" name="subjectName" class="form-control" placeholder="Subject Name" required>
                </div>

                <div class="col-md-2">
                    <input type="text" name="subjectCode" class="form-control" placeholder="Code" required>
                </div>

                <div class="col-md-2">
                    <input type="number" name="credits" class="form-control" placeholder="Credits" required>
                </div>

                <div class="col-md-3">
                    <select name="facultyId" class="form-control" required>
                        <option value="">Select Faculty</option>
                        <%
                            for(Faculty f : faculties){
                        %>
                            <option value="<%= f.getFacultyId() %>">
                                <%= f.getName() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="col-md-2">
                    <button class="btn btn-primary w-100">Add</button>
                </div>
            </div>
        </form>
    </div>

    <!-- SUBJECT TABLE -->
    <div class="card p-3">
        <h4>Subject List</h4>

        <table class="table table-bordered table-hover mt-3">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Code</th>
                    <th>Credits</th>
                    <th>Faculty</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>
            <%
                SubjectDAO dao = new SubjectDAO();
                List<Subject> list = dao.getAllSubjects();

                int count = 1;

                for (Subject s : list) {
            %>

            <tr>
                <td><%= count++ %></td>
                <td><%= s.getSubjectName() %></td>
                <td><%= s.getSubjectCode() %></td>
                <td><%= s.getCredits() %></td>
                <td><%= s.getFacultyName() %></td>

                <td>
                    <!-- EDIT -->
                    <form action="EditSubject.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= s.getSubjectId() %>">
                        <button class="btn btn-warning btn-sm">Edit</button>
                    </form>

                    <!-- DELETE -->
                    <form action="../../SubjectServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= s.getSubjectId() %>">
                        <button class="btn btn-danger btn-sm">Delete</button>
                    </form>
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
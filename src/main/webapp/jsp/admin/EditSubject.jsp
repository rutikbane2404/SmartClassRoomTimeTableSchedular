<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.SubjectDAO, dao.FacultyDAO, model.Subject, model.Faculty, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Subject</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">

<%
    // ✅ SAFE ID HANDLING
    String idStr = request.getParameter("id");

    if(idStr == null || idStr.isEmpty()){
        out.println("<h3 class='text-danger'>Invalid Subject ID</h3>");
        return;
    }

    int id = Integer.parseInt(idStr);

    // ✅ FETCH DATA
    SubjectDAO dao = new SubjectDAO();
    List<Subject> list = dao.getAllSubjects();

    Subject subject = null;

    for(Subject s : list){
        if(s.getSubjectId() == id){
            subject = s;
            break;
        }
    }

    // ✅ CHECK IF SUBJECT FOUND
    if(subject == null){
        out.println("<h3 class='text-danger'>Subject not found</h3>");
        return;
    }

    FacultyDAO fdao = new FacultyDAO();
    List<Faculty> faculties = fdao.getAllFaculty();
%>

    <div class="card p-4">
        <h3>Edit Subject</h3>

        <form action="../../SubjectServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="subjectId" value="<%= subject.getSubjectId() %>">

            <div class="mb-3">
                <label>Subject Name</label>
                <input type="text" name="subjectName" class="form-control"
                       value="<%= subject.getSubjectName() %>" required>
            </div>

            <div class="mb-3">
                <label>Subject Code</label>
                <input type="text" name="subjectCode" class="form-control"
                       value="<%= subject.getSubjectCode() %>" required>
            </div>

            <div class="mb-3">
                <label>Credits</label>
                <input type="number" name="credits" class="form-control"
                       value="<%= subject.getCredits() %>" required>
            </div>

            <div class="mb-3">
                <label>Faculty</label>
                <select name="facultyId" class="form-control">
                    <%
                        for(Faculty f : faculties){
                    %>
                        <option value="<%= f.getFacultyId() %>"
                            <%= (f.getFacultyId() == subject.getFacultyId()) ? "selected" : "" %>>
                            <%= f.getName() %>
                        </option>
                    <%
                        }
                    %>
                </select>
            </div>

            <button class="btn btn-success">Update</button>
            <a href="ManageSubjects.jsp" class="btn btn-secondary">Back</a>
        </form>
    </div>

</div>

</body>
</html>
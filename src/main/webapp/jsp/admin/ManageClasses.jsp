<%@ page import="java.util.*,dao.ClassDAO,model.ClassModel" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<title>Manage Classes</title>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href=
"https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
    font-family:'Poppins',sans-serif;
}

body{
    background:#eef2f7;
}

.main-container{
    padding:35px;
}

.top-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
}

.page-title{
    font-size:42px;
    font-weight:700;
    color:#0f172a;
}

.page-subtitle{
    color:#64748b;
    margin-top:8px;
}

.top-btn{
    background:#2563eb;
    color:white;
    text-decoration:none;
    padding:12px 22px;
    border-radius:12px;
    font-weight:600;
}

.top-btn:hover{
    background:#1d4ed8;
    color:white;
}

.content-card{
    background:white;
    border-radius:20px;
    padding:30px;
    box-shadow:0 4px 20px rgba(0,0,0,0.05);
}

.table{
    overflow:hidden;
    border-radius:15px;
}

.table thead{
    background:#0f172a;
    color:white;
}

.table th{
    padding:16px;
}

.table td{
    vertical-align:middle;
    padding:15px;
}

.action-btn{
    border:none;
    padding:8px 16px;
    border-radius:8px;
    font-weight:500;
}

.edit-btn{
    background:#facc15;
}

.delete-btn{
    background:#ef4444;
    color:white;
}

.search-box{
    width:300px;
    height:50px;
    border-radius:12px;
    border:1px solid #cbd5e1;
    padding-left:15px;
}

</style>

</head>

<body>

<div class="container-fluid main-container">

<div class="top-header">

<div>

<h1 class="page-title">
🏫 Manage Classes
</h1>

<p class="page-subtitle">
View and manage all classroom divisions and departments
</p>

</div>

<div>

<input type="text"
placeholder="Search classes..."
class="search-box me-3">

<a href="AddClasses.jsp"
class="top-btn">

➕ Add Class

</a>

</div>

</div>

<div class="content-card">

<h4 class="mb-4">
📚 Class Records
</h4>

<table class="table table-hover">

<thead>

<tr>
<th>#</th>
<th>Class Name</th>
<th>Semester</th>
<th>Department</th>
<th>Actions</th>
</tr>

</thead>

<tbody>

<%

ClassDAO dao =
new ClassDAO();

List<ClassModel> list =
dao.getAllClasses();

int count = 1;

for(ClassModel c : list){

%>

<tr>

<td>
<%= count++ %>
</td>

<td>
<strong>
<%= c.getClassName() %>
</strong>
</td>

<td>
Semester <%= c.getSemester() %>
</td>

<td>
<%= c.getDepartment() %>
</td>

<td>

<div class="d-flex gap-2">

<form action="EditClasses.jsp"
method="get">

<input type="hidden"
name="id"
value="<%= c.getClassId() %>">

<button class="action-btn edit-btn">

✏ Edit

</button>

</form>

<form action="../../ClassServlet"
method="post">

<input type="hidden"
name="action"
value="delete">

<input type="hidden"
name="id"
value="<%= c.getClassId() %>">

<button class="action-btn delete-btn">

🗑 Delete

</button>

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
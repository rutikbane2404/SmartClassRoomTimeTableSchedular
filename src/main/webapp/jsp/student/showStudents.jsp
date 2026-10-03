<%@ page import="java.util.*, dao.StudentDAO, model.Student" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Student List</title>

<meta charset="UTF-8">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
    font-family:'Poppins',sans-serif;
}

body{
    background:linear-gradient(135deg,#eef2ff,#f8fafc);
    min-height:100vh;
}

.header{
    padding:40px;
    text-align:center;
    animation:fadeDown 1s ease;
}

.header img{
    width:110px;
    margin-bottom:15px;
}

.header h1{
    font-weight:700;
    color:#0f172a;
}

.student-table{
    background:white;
    border-radius:20px;
    overflow:hidden;
    box-shadow:0 10px 30px rgba(0,0,0,0.08);
    animation:fadeUp 1s ease;
}

.table thead{
    background:#0f172a;
    color:white;
}

.table tbody tr{
    transition:0.3s;
}

.table tbody tr:hover{
    background:#f1f5f9;
    transform:scale(1.01);
}

.badge-class{
    background:#dcfce7;
    color:#166534;
    padding:8px 14px;
    border-radius:20px;
    font-size:12px;
    font-weight:600;
}

@keyframes fadeUp{
    from{
        opacity:0;
        transform:translateY(40px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

@keyframes fadeDown{
    from{
        opacity:0;
        transform:translateY(-40px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

</style>

</head>

<body>

<div class="header">

<img src="https://cdn-icons-png.flaticon.com/512/1995/1995574.png">

<h1>👨‍🎓 Student Directory</h1>

<p class="text-muted">
List of all registered students in SmartClass
</p>

</div>

<div class="container pb-5">

<div class="student-table p-4">

<div class="d-flex justify-content-between align-items-center mb-4">

<h3>
📋 Student List
</h3>

<input type="text"
       id="searchInput"
       class="form-control w-25"
       placeholder="Search student...">

</div>

<table class="table align-middle table-hover">

<thead>

<tr>

<th>#</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Class</th>

</tr>

</thead>

<tbody id="studentTable">

<%
StudentDAO dao = new StudentDAO();

List<Student> list = dao.getAllStudents();

int count = 1;

for(Student s : list){
%>

<tr>

<td>
<%= count++ %>
</td>

<td>
👨‍🎓 <%= s.getName() %>
</td>

<td>
<%= s.getEmail() %>
</td>

<td>
<%= s.getPhone() %>
</td>

<td>

<span class="badge-class">

Class ID :
<%= s.getClassId() %>

</span>

</td>

</tr>

<% } %>

</tbody>

</table>

</div>

</div>

<script>

const searchInput =
document.getElementById("searchInput");

searchInput.addEventListener("keyup", function(){

let filter =
this.value.toLowerCase();

let rows =
document.querySelectorAll("#studentTable tr");

rows.forEach(row => {

let text =
row.innerText.toLowerCase();

row.style.display =
text.includes(filter)
? ""
: "none";

});

});

</script>

</body>
</html>
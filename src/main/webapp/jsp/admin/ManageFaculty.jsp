<%@ page import="java.util.*, dao.FacultyDAO, model.Faculty" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<title>Manage Faculty</title>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

body{

    background:#f1f5f9;
    font-family:Arial;
}

/* 🔥 HEADER */

.page-header{

    background:white;

    padding:25px;

    border-radius:18px;

    box-shadow:0 5px 20px rgba(0,0,0,0.08);

    margin-bottom:25px;
}

/* 🔥 CARD */

.main-card{

    background:white;

    border-radius:18px;

    padding:25px;

    box-shadow:0 5px 20px rgba(0,0,0,0.08);
}

/* 🔥 TABLE */

.table{

    border-radius:15px;
    overflow:hidden;
}

/* 🔥 SEARCH */

.search-box{

    width:300px;
}

/* 🔥 BADGE */

.dept-badge{

    background:#2563eb;

    color:white;

    padding:6px 12px;

    border-radius:30px;

    font-size:13px;
}

/* 🔥 BUTTONS */

.action-btn{

    border-radius:10px;
}

/* 🔥 HOVER */

.table-hover tbody tr:hover{

    background:#f8fafc;
    transition:0.2s;
}

/* 🔥 ICON BOX */

.icon-box{

    width:55px;
    height:55px;

    border-radius:15px;

    background:#dbeafe;

    display:flex;

    justify-content:center;
    align-items:center;

    font-size:24px;
}

</style>

</head>

<body>

<div class="container-fluid p-4">

<!-- 🔥 PAGE HEADER -->

<div class="page-header">

<div class="d-flex justify-content-between align-items-center flex-wrap">

<div class="d-flex align-items-center gap-3">

<div class="icon-box">
👨‍🏫
</div>

<div>

<h2 class="mb-1">
Manage Faculty
</h2>

<p class="text-muted mb-0">
View, update and manage all faculty members
</p>

</div>

</div>

<div>

<input type="text"
id="searchInput"
class="form-control search-box"
placeholder="Search faculty...">

</div>

</div>

</div>

<!-- 🔥 FACULTY TABLE -->

<div class="main-card">

<div class="d-flex justify-content-between align-items-center mb-3">

<h4>
📋 Faculty Records
</h4>

<a href="RegisterFaculty.jsp"
class="btn btn-primary action-btn">

<i class="fa fa-plus"></i>
Register Faculty

</a>

</div>

<table class="table table-bordered table-hover align-middle"
id="facultyTable">

<thead class="table-dark">

<tr>

<th width="7%">
#</th>

<th>
Faculty Name
</th>

<th>
Email
</th>

<th>
Department
</th>

<th width="18%">
Actions
</th>

</tr>

</thead>

<tbody>

<%

FacultyDAO dao = new FacultyDAO();

List<Faculty> list =
dao.getAllFaculty();

int count = 1;

for(Faculty f : list){

%>

<tr>

<td>
<%= count++ %>
</td>

<td>

<div class="d-flex align-items-center gap-2">

<div style="
width:40px;
height:40px;
border-radius:50%;
background:#2563eb;
color:white;
display:flex;
justify-content:center;
align-items:center;
font-weight:bold;">

<%= f.getName().substring(0,1).toUpperCase() %>

</div>

<div>

<b>
<%= f.getName() %>
</b>

</div>

</div>

</td>

<td>

<%= f.getEmail() %>

</td>

<td>

<span class="dept-badge">

<%= f.getDepartment() %>

</span>

</td>

<td>

<div class="d-flex gap-2">

<!-- 🔥 EDIT -->

<form action="EditFaculty.jsp"
method="get">

<input type="hidden"
name="id"
value="<%= f.getFacultyId() %>">

<button class="btn btn-warning btn-sm action-btn">

<i class="fa fa-pen"></i>
Edit

</button>

</form>

<!-- 🔥 DELETE -->

<form action="../../FacultyServlet"
method="post">

<input type="hidden"
name="action"
value="delete">

<input type="hidden"
name="id"
value="<%= f.getFacultyId() %>">

<button
class="btn btn-danger btn-sm action-btn"

onclick="return confirm('Delete this faculty member?')">

<i class="fa fa-trash"></i>
Delete

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

<!-- 🔥 SEARCH SCRIPT -->

<script>

document
.getElementById("searchInput")
.addEventListener("keyup", function(){

let value =
this.value.toLowerCase();

let rows =
document.querySelectorAll("#facultyTable tbody tr");

rows.forEach(function(row){

row.style.display =
row.innerText.toLowerCase().includes(value)
? ""
: "none";

});

});

</script>

</body>
</html>
<%@ page import="java.util.*, dao.FacultyDAO, model.Faculty" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Faculty Directory</title>

<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
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
    overflow-x:hidden;
}

.header{
    padding:40px;
    text-align:center;
    animation:fadeDown 1s ease;
}

.header img{
    width:120px;
    margin-bottom:20px;
}

.header h1{
    font-weight:700;
    color:#0f172a;
}

.faculty-card{
    border:none;
    border-radius:20px;
    overflow:hidden;
    transition:0.4s;
    animation:fadeUp 0.8s ease;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

.faculty-card:hover{
    transform:translateY(-8px) scale(1.02);
}

.card-top{
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    padding:25px;
    text-align:center;
    color:white;
}

.avatar{
    width:80px;
    height:80px;
    border-radius:50%;
    background:white;
    color:#2563eb;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:35px;
    margin:auto;
    margin-bottom:10px;
}

.badge-dept{
    background:#dbeafe;
    color:#1e40af;
    padding:8px 15px;
    border-radius:30px;
    font-size:13px;
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

<img src="https://cdn-icons-png.flaticon.com/512/3135/3135755.png">

<h1>👨‍🏫 Faculty Directory</h1>

<p class="text-muted">
Explore all faculty members of SmartClass
</p>

</div>

<div class="container pb-5">

<div class="row g-4">

<%
FacultyDAO dao = new FacultyDAO();

List<Faculty> list = dao.getAllFaculty();

for(Faculty f : list){
%>

<div class="col-md-4">

<div class="card faculty-card">

<div class="card-top">

<div class="avatar">
👨‍🏫
</div>

<h4><%= f.getName() %></h4>

</div>

<div class="card-body text-center">

<p class="mb-2">
📧 <%= f.getEmail() %>
</p>

<span class="badge-dept">
<%= f.getDepartment() %>
</span>

</div>

</div>

</div>

<% } %>

</div>

</div>

</body>
</html>
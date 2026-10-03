<%@ page import="dao.ClassRoomDAO,model.Classroom" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<%

int id =
Integer.parseInt(request.getParameter("id"));

ClassRoomDAO dao =
new ClassRoomDAO();

Classroom c =
dao.getRoomById(id);

%>

<!DOCTYPE html>
<html>
<head>

<title>Edit Classroom</title>

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

.page-container{
    padding:45px;
}

.page-title{
    font-size:52px;
    font-weight:700;
    color:#0f172a;
}

.subtitle{
    color:#64748b;
    margin-top:8px;
    margin-bottom:35px;
}

.form-card{
    max-width:1050px;
    margin:auto;
    background:white;
    border-radius:24px;
    padding:40px;
    box-shadow:0 5px 25px rgba(0,0,0,0.05);
}

.info-box{
    background:#eff6ff;
    border-left:5px solid #2563eb;
    padding:20px;
    border-radius:14px;
    margin-bottom:30px;
}

.form-label{
    font-weight:600;
    margin-bottom:10px;
    color:#0f172a;
}

.form-control{
    height:58px;
    border-radius:14px;
    border:1px solid #cbd5e1;
}

.form-control:focus{
    box-shadow:none;
    border-color:#2563eb;
}

.submit-btn{
    width:100%;
    height:58px;
    border:none;
    border-radius:14px;
    background:#2563eb;
    color:white;
    font-size:18px;
    font-weight:600;
}

.back-btn{
    background:#0f172a;
    color:white;
    text-decoration:none;
    padding:14px 22px;
    border-radius:12px;
    float:right;
}

.back-btn:hover{
    color:white;
}

</style>

</head>

<body>

<div class="container-fluid page-container">

<a href="ManageClassrooms.jsp"
class="back-btn">

⬅ Back to Classrooms

</a>

<h1 class="page-title">
✏ Edit Classroom
</h1>

<p class="subtitle">
Update classroom information and capacity
</p>

<div class="form-card">

<div class="info-box">

<strong>Classroom ID:</strong>

<%= c.getRoomId() %>

</div>

<form action="../../ClassroomServlet"
method="post">

<input type="hidden"
name="action"
value="update">

<input type="hidden"
name="id"
value="<%= c.getRoomId() %>">

<div class="row">

<div class="col-md-6 mb-4">

<label class="form-label">
Room Number
</label>

<input type="text"
name="roomNumber"
class="form-control"
value="<%= c.getRoomNumber() %>"
required>

</div>

<div class="col-md-6 mb-4">

<label class="form-label">
Capacity
</label>

<input type="number"
name="capacity"
class="form-control"
value="<%= c.getCapacity() %>"
required>

</div>

</div>

<button class="submit-btn">

💾 Update Classroom

</button>

</form>

</div>

</div>

</body>
</html>
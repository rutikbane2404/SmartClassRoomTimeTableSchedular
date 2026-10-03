<%@ page import="model.User" %>
<%@ page import="java.sql.*, util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
User user = (User) session.getAttribute("user");

if(user == null || !user.getRole().equals("ADMIN")){

    response.sendRedirect("../auth/Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Student Registration</title>

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
    padding:40px;
}

.page-header{
    margin-bottom:30px;
}

.page-title{
    font-size:38px;
    font-weight:700;
    color:#0f172a;
}

.page-subtitle{
    color:#64748b;
    margin-top:10px;
}

.form-card{
    background:white;
    border-radius:20px;
    padding:35px;
    box-shadow:0 4px 20px rgba(0,0,0,0.05);
}

.form-label{
    font-weight:600;
    color:#334155;
}

.form-control{
    height:55px;
    border-radius:12px;
    border:1px solid #dbeafe;
}

.form-control:focus{
    box-shadow:none;
    border-color:#2563eb;
}

.btn-save{
    background:#2563eb;
    color:white;
    border:none;
    padding:14px;
    border-radius:12px;
    font-weight:600;
    width:100%;
    transition:0.3s;
}

.btn-save:hover{
    background:#1d4ed8;
    transform:translateY(-2px);
}

.back-btn{
    text-decoration:none;
    background:#0f172a;
    color:white;
    padding:10px 18px;
    border-radius:10px;
    transition:0.3s;
}

.back-btn:hover{
    background:#1e293b;
    color:white;
}

.top-actions{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}

.info-box{
    background:#eff6ff;
    border-left:5px solid #2563eb;
    padding:15px;
    border-radius:10px;
    margin-bottom:25px;
}

.alert{
    border-radius:12px;
}

</style>

</head>

<body>

<div class="container-fluid main-container">

<div class="top-actions">

<div>

<h2 class="page-title">
👨‍🎓 Student Registration
</h2>

<p class="page-subtitle">
Register and manage students inside SmartClass system
</p>

</div>

<a href="ManageStudent.jsp"
class="back-btn">
← Back to Students
</a>

</div>

<%
String success = request.getParameter("success");
String error = request.getParameter("error");

if(success != null){
%>

<div class="alert alert-success">
✅ Student registered successfully.
</div>

<%
}

if(error != null){
%>

<div class="alert alert-danger">
❌ Something went wrong while registering student.
</div>

<%
}
%>

<div class="row justify-content-center">

<div class="col-lg-8">

<div class="form-card">

<div class="info-box">

<strong>NOTE:</strong>

Student credentials will automatically be stored
inside the authentication system and student module.

</div>

<form
action="<%=request.getContextPath()%>/StudentServlet"
method="post">

<input type="hidden"
name="action"
value="add">

<div class="row">

<div class="col-md-6 mb-4">

<label class="form-label">
Full Name
</label>

<input type="text"
name="name"
class="form-control"
placeholder="Enter student name"
required>

</div>

<div class="col-md-6 mb-4">

<label class="form-label">
Email Address
</label>

<input type="email"
name="email"
class="form-control"
placeholder="Enter student email"
required>

</div>

</div>

<div class="row">

<div class="col-md-6 mb-4">

<label class="form-label">
Password
</label>

<input type="password"
name="password"
class="form-control"
placeholder="Create password"
required>

</div>

<div class="col-md-6 mb-4">

<label class="form-label">
Phone Number
</label>

<input type="text"
name="phone"
class="form-control"
placeholder="Enter phone number"
required>

</div>

</div>

<div class="mb-4">

<label class="form-label">
Select Class
</label>

<select
name="classId"
class="form-control"
required>

<option value="">
Choose Class
</option>

<%
try{

    Connection con =
    DBConnection.getConnection();

    Statement st =
    con.createStatement();

    ResultSet rs =
    st.executeQuery(
    "SELECT * FROM classes");

    while(rs.next()){
%>

<option
value="<%= rs.getInt("class_id") %>">

<%= rs.getString("class_name") %>

</option>

<%
    }

}catch(Exception e){

    e.printStackTrace();
}
%>

</select>

</div>

<div class="mt-3">

<button class="btn-save">

➕ Register Student

</button>

</div>

</form>

</div>

</div>

</div>

</div>

</body>
</html>
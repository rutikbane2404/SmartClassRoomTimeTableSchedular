<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Smart Classroom Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background: linear-gradient(135deg,#667eea,#764ba2);
    font-family: Arial;
}

.login-card{
    width:400px;
    background:white;
    padding:35px;
    border-radius:15px;
    box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

.logo{
    text-align:center;
    margin-bottom:25px;
}

.logo h2{
    font-weight:bold;
    color:#343a40;
}

.btn-login{
    width:100%;
    background:#667eea;
    border:none;
}

.btn-login:hover{
    background:#5a67d8;
}

</style>

</head>

<body>

<div class="login-card">

<div class="logo">
    <h2>🎓 Smart Classroom</h2>
    <p class="text-muted">Timetable Scheduler System</p>
</div>

<%
String error = request.getParameter("error");

if(error != null){
%>

<div class="alert alert-danger">
    Invalid Email or Password
</div>

<%
}
%>

<form action="<%=request.getContextPath()%>/LoginServlet" method="post">

<div class="mb-3">
<label>Email</label>
<input type="email"
       name="email"
       class="form-control"
       placeholder="Enter email"
       required>
</div>

<div class="mb-3">
<label>Password</label>
<input type="password"
       name="password"
       class="form-control"
       placeholder="Enter password"
       required>
</div>

<div class="mb-3">
<label>Login As</label>

<select name="role" class="form-control" required>
    <option value="">Select Role</option>
    <option value="ADMIN">Admin</option>
    <option value="FACULTY">Faculty</option>
    <option value="STUDENT">Student</option>
</select>

</div>

<button class="btn btn-primary btn-login">
    Login
</button>

</form>

</div>

</body>
</html>
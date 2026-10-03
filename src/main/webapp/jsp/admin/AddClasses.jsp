<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>Add Class</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

body{
    background:#eef2f7;
}

.form-card{
    max-width:900px;
    margin:auto;
    margin-top:40px;
    background:white;
    padding:40px;
    border-radius:20px;
    box-shadow:0 5px 20px rgba(0,0,0,0.05);
}

</style>

</head>

<body>

<div class="container">

<div class="form-card">

<h1 class="mb-4">
🏫 Add Class
</h1>

<form action="../../ClassServlet"
method="post">

<input type="hidden"
name="action"
value="add">

<div class="row">

<div class="col-md-4 mb-4">

<label>
Class Name
</label>

<input type="text"
name="className"
class="form-control"
required>

</div>

<div class="col-md-4 mb-4">

<label>
Semester
</label>

<input type="number"
name="semester"
class="form-control"
required>

</div>

<div class="col-md-4 mb-4">

<label>
Department
</label>

<input type="text"
name="department"
class="form-control"
required>

</div>

</div>

<button class="btn btn-primary w-100">

➕ Add Class

</button>

</form>

</div>

</div>

</body>
</html>
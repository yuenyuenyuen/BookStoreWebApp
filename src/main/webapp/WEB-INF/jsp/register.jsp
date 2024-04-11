<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Support - Register</title>
    <%@include file="meta.jsp" %>
</head>
<body>
<div class="container">
    <h2>Register</h2>
    <form:form method="POST" modelAttribute="ticketUser">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" id="username" path="username"/>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" path="password"/>
        </div>
        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" class="form-control" id="fullName" path="fullName"/>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="text" class="form-control" id="email" path="email"/>
        </div>
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" class="form-control" id="address" path="address"/>
        </div>
        <input type="hidden" path="roles" value="ROLE_USER"/>
        <button type="submit" class="btn btn-primary">Register</button>
    </form:form>
</div>
</body>
</html>

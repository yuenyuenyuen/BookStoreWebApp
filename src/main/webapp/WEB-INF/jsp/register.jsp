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
            <form:label path="username">Username</form:label>
            <form:input type="text" class="form-control" path="username"/>
        </div>
        <div class="form-group">
            <form:label path="password">Password</form:label>
            <form:input type="password" class="form-control" path="password"/>
        </div>
        <div class="form-group">
            <form:label path="fullName">Full Name</form:label>
            <form:input type="text" class="form-control" path="fullName"/>
        </div>
        <div class="form-group">
            <form:label path="email">Email</form:label>
            <form:input type="text" class="form-control" path="email"/>
        </div>
        <div class="form-group">
            <form:label path="address">Address</form:label>
            <form:input type="text" class="form-control" path="address"/>
        </div>
        <form:hidden path="roles" value="ROLE_USER"/>
        <button type="submit" class="btn btn-primary">Register</button>
    </form:form>
</div>
</body>
</html>

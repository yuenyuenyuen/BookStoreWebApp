<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Customer Support</title>
</head>
<body>
<div class="container">
    <h2>Create a User</h2>
    <form:form method="POST" modelAttribute="ticketUser">
        <div class="form-group">
            <form:label path="username">Username</form:label>
            <form:input type="text" path="username" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="password">Password</form:label>
            <form:input type="text" path="password" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="fullName">Full Name</form:label>
            <form:input type="text" path="fullName" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="email">Email</form:label>
            <form:input type="text" path="email" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="address">Address</form:label>
            <form:input type="text" path="address" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="roles">Roles</form:label>
            <br/>
            <form:checkbox path="roles" value="ROLE_USER" label="ROLE_USER" checked="${ticketUser.roles.contains('ROLE_USER')}"/>
            <form:checkbox path="roles" value="ROLE_ADMIN" label="ROLE_ADMIN" checked="${ticketUser.roles.contains('ROLE_ADMIN')}"/>
        </div>
        <input type="submit" value="Add User" class="btn btn-primary"/>
    </form:form>
</div>
</body>
</html>

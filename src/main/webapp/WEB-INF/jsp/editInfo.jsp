<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Edit User Information</title>
</head>
<body>
<div class="container">
    <h2>Edit User Information</h2>
    <form:form method="POST" modelAttribute="ticketUser">
        <div class="form-group">
            <form:label path="username">Username</form:label>
            <form:input type="text" path="username" readonly="true" class="form-control"/>
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
        <form:hidden path="roles" value="ROLE_USER"/>
        <security:authorize access="hasRole('ADMIN')">
            <div class="form-check">
                <form:checkbox path="roles" value="ROLE_USER" class="form-check-input"/>ROLE_USER
            </div>
            <div class="form-check">
                <form:checkbox path="roles" value="ROLE_ADMIN" class="form-check-input"/>ROLE_ADMIN
            </div>
        </security:authorize>
        <input type="submit" value="Update" class="btn btn-primary"/>
    </form:form>
</div>
</body>
</html>


<!DOCTYPE html>
<html>
<head><title>Customer Support</title></head>
<body>
<h2>Edit User Information</h2>
<form:form method="POST" modelAttribute="ticketUser">
    <form:label path="username">Username</form:label><br/>
    <form:input type="text" path="username" readonly="true"/><br/><br/>
    <form:label path="password">Password</form:label><br/>
    <form:input type="text" path="password"/><br/><br/>
    <form:label path="fullName">Full Name</form:label><br/>
    <form:input type="text" path="fullName"/><br/><br/>
    <form:label path="email">Email</form:label><br/>
    <form:input type="text" path="email"/><br/><br/>
    <form:label path="address">Address</form:label><br/>
    <form:input type="text" path="address"/><br/><br/>
    <form:hidden path="roles" value="ROLE_USER"/>
    <br/><br/>
    <input type="submit" value="Update"/>
</form:form>
</body>
</html>

<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Store Login</title>
    <%@include file="meta.jsp" %>
</head>
<body>
<div class="container">
    <h2>Book Store Login</h2>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger" role="alert">Login failed.</div>
    </c:if>
    <c:if test="${param.logout != null}">
        <div class="alert alert-info" role="alert">You have logged out.</div>
    </c:if>
    <form action="login" method="POST">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" id="username" name="username"/>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password"/>
        </div>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="remember-me" name="remember-me"/>
            <label class="form-check-label" for="remember-me">Remember me</label>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Log In</button>
    </form>
</div>
</body>
</html>

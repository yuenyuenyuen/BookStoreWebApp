<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Error page</title>
</head>
<body>
<div class="container">
    <h2>Error</h2>
    <a href="<c:url value="/ticket" />" class="btn btn-primary">Return to book list</a>
    <c:choose>
        <c:when test="${empty message}">
            <div class="alert alert-danger" role="alert">
                Something went wrong.
                <ul>
                    <li>Status Code: ${status}</li>
                    <li>Exception: ${exception}</li>
                    <li>Stacktrace: ${trace}</li>
                </ul>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-danger" role="alert">${message}</div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>

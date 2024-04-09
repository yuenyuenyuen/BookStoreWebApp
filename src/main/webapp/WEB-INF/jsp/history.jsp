<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>History</title>
</head>
<body>
<c:forEach items="${tickets}" var="ticket">
    <h4>Comments:</h4>
    <c:choose>
        <c:when test="${fn:length(ticket.comments) > 0}">
            <c:forEach var="cm" items="${ticket.comments}">
                <p>User: <c:out value="${cm.name}"/></p>
                <p><c:out value="${cm.content}"/></p>
                <security:authorize access="hasRole('ADMIN')">
                    [<a href="<c:url value='/ticket/delete/comment/${ticket.id}/${cm.id}' />">Delete</a>]<br/><br/>
                </security:authorize>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>There are no comments.</p>
        </c:otherwise>
    </c:choose>
    <hr>
</c:forEach>
<br/>
<a href="<c:url value='/ticket' />">Return to the ticket list</a>
</body>
</html>
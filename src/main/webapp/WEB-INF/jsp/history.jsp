<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>History</title>
</head>
<body>
<div class="container">
    <c:forEach items="${tickets}" var="ticket">
        <h4>Comments:</h4>
        <h5>Book Name:<c:out value="${ticket.bookName}"/></h5>
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
    <a href="<c:url value='/ticket' />" class="btn btn-primary">Return to the ticket list</a>
</div>
</body>
</html>

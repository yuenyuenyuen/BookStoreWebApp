<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
</head>
<body>
<h2>Book Store</h2>
<a href="<c:url value="/ticket/create" />">Create a Ticket</a><br/><br/>
<c:choose>
    <c:when test="${fn:length(ticketDatabase) == 0}">
        <i>There are no tickets in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${ticketDatabase}" var="entry">
            <c:if test="${entry.attachments != null}">
            <img src="<c:url value='/ticket/${entry.id}/attachment/${entry.attachments.id}' />" alt="Attachment" style="max-width: 200px; max-height: 200px;"><br/>
            </c:if>
            Book ${entry.id}:
            <a href="<c:url value="/ticket/view/${entry.id}" />">
                <c:out value="${entry.bookName}"/></a>
            (author: <c:out value="${entry.author}"/>)
            [<a href="<c:url value="/ticket/delete/${entry.id}" />">Delete</a>]<br/>
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
</html>
